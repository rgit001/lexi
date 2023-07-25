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
        addSubview(wordView)
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            wordView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wordView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            wordView.heightAnchor.constraint(equalToConstant: 100),
            
            refreshButton.topAnchor.constraint(equalTo: wordView.bottomAnchor, constant: 10),
            refreshButton.leadingAnchor.constraint(equalTo: wordView.leadingAnchor, constant: 300),
            refreshButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }
    
    func updateWordViewLabels(word: String, partOfSpeech: String, definition: String) {
        wordView.wordLabel.text = word
        wordView.partOfSpeechLabel.text = partOfSpeech
        wordView.definitionLabel.text = definition
    }
}
