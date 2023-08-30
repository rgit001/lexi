//
//  WordDetailedViewController.swift
//  lexi
//
//  Created by Hung Nguyen on 7/25/23.
//

import UIKit

class DetailedWordViewController: UIViewController {
    
    let detailedWordStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 30
        return view
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let imageHollowStar = UIImage(systemName: "star", withConfiguration: symbolConfig)
        let imageFillStar = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)
        button.setImage(imageHollowStar, for: .normal) // Display hollow Favorite star when button is in the normal state
        button.setImage(imageFillStar, for: .selected) // Display a filled star when the button is in selected state
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        return button
    }()
   
    let wordHeaderLabel: UILabel = { // the topmost word displayed on the page
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    let horizontalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "GrayBackground")
        return view
    }()
    
    let definitionDetailedView: DetailedWordView = {
        let view = DetailedWordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        view.footerText = "Definition"
        view.backgroundColor = UIColor(named: "LightBlueDefinition")
        return view
    }()
    
    let synonymsDetailedView: DetailedWordView = {
        let view = DetailedWordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        view.isHidden = true
        view.footerText = "Synonyms"
        view.backgroundColor = UIColor(named: "LightGreenSynonyms")
        return view
    }()
    
    let antonymsDetailedView: DetailedWordView = {
        let view = DetailedWordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        view.isHidden = true
        view.footerText = "Antonyms"
        view.backgroundColor = UIColor(named: "PinkAntonyms")
        return view
    }()
   
    /* COMMENTED OUT BECAUSE I DONT KNOW IF EXAMPLE USAGE IS A VALID FIELD FROM THE API*/
//    let exampleUsageDetailedView: DetailedWordView = {
//        let view = DetailedWordView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
//        view.layer.cornerRadius = 15
//        view.isHidden = true
//        view.footerText = "Example Usages"
//        return view
//    }()
    
    var favorite: Favorite? // Store the favorite item fetched from the entity when the view is loaded. Is set in checkFavoritesStar()
    
    var word: Word!
    
    var indexPath: IndexPath!

    init(withWord word: Word, andIndexPath indexPath: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.word = word
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "WordHeader")
        
       
        // Each time view is loaded check to see if the word is a favorite.
        checkFavoritesStar()
        setUpUI()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        
        // Check if word has been favorited
        if favoriteButton.isSelected {
            print("favorite is selected")
            
            // Add word to Favorite entity
            DataManager.createFavoriteItem(word: word.word, partOfSpeech: word.results[indexPath.row].partOfSpeech, definition: word.results[indexPath.row].definition)
            
        } else {
            print("favorite is NOT selected")
            
            // If a previously favorited word has been unfavorited upon exiting the view, delete word from Favorite entity. 
            if let favorite = self.favorite {
                DataManager.deleteFavorite(favorite: favorite)
            }
        }
    }

    // Call when view is loaded to check if the favorite star is selected.
    // Calls fetchFavoriteItem to see if item is in the Entity. If it is, toggle favoriteButton to 'selected" state.
    private func checkFavoritesStar() {
        DataManager.fetchFavoriteItem(usingWord: word.word, completion: { [weak self] favorite in
            if let favorite = favorite {
                self?.favoriteButton.isSelected.toggle()
                self?.favorite = favorite
            }
        })
    }
    
    private func setUpUI() {
        if let word = self.word {
            wordHeaderLabel.text = word.word // the top most word displayed on the page.
            
            // Determine which word detailed views to display
            // Note: definitiondetailedView is always displayed
            if let partOfSpeech = word.results[indexPath.row].partOfSpeech {
                definitionDetailedView.headerText = partOfSpeech
                definitionDetailedView.bodyText = word.results[indexPath.row].definition
            }
            
            if let synonyms = word.results[indexPath.row].synonyms {
                synonymsDetailedView.isHidden = false
                synonymsDetailedView.bodyText = synonyms.joined(separator: ", ")
            }
            
            if let antonyms = word.results[indexPath.row].antonyms {
                antonymsDetailedView.isHidden = false
                antonymsDetailedView.bodyText = antonyms.joined(separator: ", ")
            }
        }
        
        view.addSubview(favoriteButton)
        view.addSubview(wordHeaderLabel)
        view.addSubview(horizontalLine)
        view.addSubview(containerView)
        containerView.addSubview(detailedWordStackView)
        detailedWordStackView.addArrangedSubview(definitionDetailedView)
        detailedWordStackView.addArrangedSubview(synonymsDetailedView)
        detailedWordStackView.addArrangedSubview(antonymsDetailedView)
//        stackView.addArrangedSubview(exampleUsageDetailedView)
        
        NSLayoutConstraint.activate([
            wordHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wordHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            wordHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: wordHeaderLabel.trailingAnchor, constant: 25),
            favoriteButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            horizontalLine.topAnchor.constraint(equalTo: wordHeaderLabel.bottomAnchor),
            horizontalLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalLine.heightAnchor.constraint(equalToConstant: 10),
            
            containerView.topAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: 1),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailedWordStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            detailedWordStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            definitionDetailedView.heightAnchor.constraint(equalToConstant: 145),
            definitionDetailedView.widthAnchor.constraint(equalToConstant: 319),
            
            synonymsDetailedView.heightAnchor.constraint(equalToConstant: 145),
            synonymsDetailedView.widthAnchor.constraint(equalToConstant: 319),
            
            antonymsDetailedView.heightAnchor.constraint(equalToConstant: 145),
            antonymsDetailedView.widthAnchor.constraint(equalToConstant: 319),
            
//            exampleUsageDetailedView.heightAnchor.constraint(equalToConstant: 145),
//            exampleUsageDetailedView.widthAnchor.constraint(equalToConstant: 319),
        ])
    }
    
    @objc func favoriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()  // When button is clicked, toggle the image for each selected state ("normal" or "selected").
        print("favoriteButton is selected: \(favoriteButton.isSelected)")
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
