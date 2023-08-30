//
//  WordTableViewCell.swift
//  lexi
//
//  Created by Hung Nguyen on 7/24/23.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    static let identifier = "WordTableViewCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "PeachCellColor")
        view.layer.cornerRadius = 15
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-SemiBold", size: 12)
        label.text = "Programming" // Delete me
        return label
    }()
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-LightItalic", size: 9)
        label.text = "noun" // delete me
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Regular", size: 11)
        label.text = "creating a sequence of instructions to enable the computer to do something"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(wordLabel)
        containerView.addSubview(partOfSpeechLabel)
        containerView.addSubview(definitionLabel)
        contentView.backgroundColor = UIColor(named: "WhiteTableView")
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            wordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            wordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            wordLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor),
            
            partOfSpeechLabel.topAnchor.constraint(equalTo: wordLabel.topAnchor, constant: 2),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 5),
            partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 1),
            definitionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            definitionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    func updateLabels(withWord word: Word?, andIndexPath indexPath: IndexPath) {
        print("updateLabels called")
        
        if let word = word {
            wordLabel.text = word.word
            definitionLabel.text = word.results[indexPath.row].definition
            partOfSpeechLabel.text = word.results[indexPath.row].partOfSpeech
        }
    }
    
    func updateFavoriteLabels(withFavorite favorite: Favorite?) {
        print("updateFavoriteLabels called")
        
        if let favorite = favorite {
            wordLabel.text = favorite.word
            definitionLabel.text = favorite.definition
            partOfSpeechLabel.text = favorite.partOfSpeech
        }
    }
}
