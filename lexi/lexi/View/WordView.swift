//
//  wordView.swift
//  lexi
//
//  Created by Hung Nguyen on 7/24/23.
//

import UIKit

class WordView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Regular", size: 24)
        label.text = "Programming" // Delete me
        return label
    }()
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-LightItalic", size: 12)
        label.text = "noun" // delete me
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "creating a sequence of instructions to enable the computer to do something"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        // Appearance
        
        // Views
        addSubview(wordLabel)
        addSubview(partOfSpeechLabel)
        addSubview(definitionLabel)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wordLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            partOfSpeechLabel.topAnchor.constraint(equalTo: wordLabel.topAnchor, constant: 10),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 10),
            partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 10),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }
    

}
