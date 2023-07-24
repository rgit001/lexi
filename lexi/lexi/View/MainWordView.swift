//
//  MainWordView.swift
//  lexi
//
//  Created by Hung Nguyen on 7/24/23.
//

import UIKit

class MainWordView: UIView {
    var completion: (() -> Void)?

    lazy var refreshButton: RefreshButton = {
        let button = RefreshButton(completion: { [weak self] in
            self?.completion?()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
        return button
    }()
    
    let wordView: WordView = {
        let view = WordView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let wordLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Rubik-Regular", size: 24)
//        label.text = "Programming" // Delete me
//        label.backgroundColor = .brown
//        return label
//    }()
//
//    let partOfSpeechLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Rubik-LightItalic", size: 12)
//        label.text = "noun" // delete me
//        label.backgroundColor = .green
//        return label
//    }()
//
//    let definitionLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Rubik-Regular", size: 16)
//        label.text = "creating a sequence of instructions to enable the computer to do something"
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.backgroundColor = .purple
//        return label
//    }()
    
    init(completion: (() -> Void)?, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.completion = completion
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        // Appearance
        layer.cornerRadius = 20
        
        // Views
//        addSubview(wordLabel)
//        addSubview(partOfSpeechLabel)
//        addSubview(definitionLabel)
        addSubview(wordView)
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
//            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            wordLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
//
//            partOfSpeechLabel.topAnchor.constraint(equalTo: wordLabel.topAnchor, constant: 15),
//            partOfSpeechLabel.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 10),
//            partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
//
//            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 10),
//            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
//            definitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            wordView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wordView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            wordView.heightAnchor.constraint(equalToConstant: 100),
            
            refreshButton.topAnchor.constraint(equalTo: wordView.bottomAnchor, constant: 10),
            refreshButton.leadingAnchor.constraint(equalTo: wordView.leadingAnchor, constant: 300),
            refreshButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
//            refreshButton.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 40),
//            refreshButton.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor, constant: 300),
//            refreshButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }
    
    func updateWordViewLabels(word: String, partOfSpeech: String, definition: String) {
        wordView.wordLabel.text = word
        wordView.partOfSpeechLabel.text = partOfSpeech
        wordView.definitionLabel.text = definition
        
//        wordView.wordLabel.text = "word"
//        wordView.partOfSpeechLabel.text = "partOfSpeech"
//        wordView.definitionLabel.text = "definition"
    }
}
