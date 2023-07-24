//
//  ViewController.swift
//  lexi
//
//  Created by Hung Nguyen on 7/16/23.
//

import UIKit

class ViewController: UIViewController {
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lexi"
        label.font = UIFont(name: "Rubik-SemiBold", size: 36)
        label.backgroundColor = .yellow
        return label
    }()
    
    lazy var mainWordView: MainWordView = {
        let view = MainWordView(completion: { [weak self] in
            self?.getRandomWord()
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BlueMainWord")
        return view
    }()
    
    let wordDatabase = [
        Word(word: "word1", results: [
            WordDetail(definition: "w1 definition.", partOfSpeech: "partofspeech")
        ]),
        Word(word: "word2", results: [
            WordDetail(definition: "w2 definition.", partOfSpeech: "partofspeech")
        ]),
        Word(word: "word3", results: [
            WordDetail(definition: "w3 definition.", partOfSpeech: "partofspeech")
        ]),
        Word(word: "word4", results: [
            WordDetail(definition: "w4 definition.", partOfSpeech: "partofspeech")
        ]),
        Word(word: "word5", results: [
            WordDetail(definition: "w5 definition.", partOfSpeech: "partofspeech")
        ]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "GrayBackground")
        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(appTitleLabel)
        view.addSubview(mainWordView)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            mainWordView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 20),
            mainWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainWordView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    private func getRandomWord() {
        print("getRandomWord")
        
        let randomWord = wordDatabase.randomElement()
        updateMainWord(withWord: randomWord!)
    }
    
    private func updateMainWord(withWord word: Word) {
        mainWordView.wordLabel.text = word.word
        mainWordView.partOfSpeechLabel.text = word.results[0].partOfSpeech
        mainWordView.definitionLabel.text = word.results[0].definition
    }
}

