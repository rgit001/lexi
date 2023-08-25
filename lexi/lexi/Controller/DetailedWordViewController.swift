//
//  WordDetailedViewController.swift
//  lexi
//
//  Created by Hung Nguyen on 7/25/23.
//

import UIKit

class DetailedWordViewController: UIViewController {
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 30
        return view
    }()
    
    let wordHeaderLabel: UILabel = {
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
    
    var word: Word?

    init(withWord word: Word) {
        super.init(nibName: nil, bundle: nil)
        self.word = word
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "WordHeader")
        setUpUI()

        // Do any additional setup after loading the view.
    }
    

    
    private func setUpUI() {
        if let word = self.word {
            wordHeaderLabel.text = word.word
            
            // Determine which word detailed views to display
            // Note: definitiondetailedView is always displayed
            if let partOfSpeech = word.results[0].partOfSpeech {
                definitionDetailedView.headerText = partOfSpeech
                definitionDetailedView.bodyText = word.results[0].definition
            }
            
            if let synonyms = word.results[0].synonyms {
                synonymsDetailedView.isHidden = false
                synonymsDetailedView.bodyText = synonyms.joined(separator: ", ")
            }
            
            if let antonyms = word.results[0].antonyms {
                antonymsDetailedView.isHidden = false
                antonymsDetailedView.bodyText = antonyms.joined(separator: ", ")
            }
            
            
        }
        
        
        view.addSubview(wordHeaderLabel)
        view.addSubview(horizontalLine)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(definitionDetailedView)
        stackView.addArrangedSubview(synonymsDetailedView)
        stackView.addArrangedSubview(antonymsDetailedView)
//        stackView.addArrangedSubview(exampleUsageDetailedView)
        
        NSLayoutConstraint.activate([
            wordHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wordHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            wordHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            horizontalLine.topAnchor.constraint(equalTo: wordHeaderLabel.bottomAnchor),
            horizontalLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalLine.heightAnchor.constraint(equalToConstant: 10),
            
            containerView.topAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: 1),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
