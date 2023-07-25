//
//  WordTableViewCell.swift
//  lexi
//
//  Created by Hung Nguyen on 7/24/23.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    static let identifier = "WordTableViewCell"
    
    let wordView: WordView = {
        let view = WordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wordLabel.font = UIFont(name: "Rubik-Regular", size: 12)
        view.partOfSpeechLabel.font = UIFont(name: "Rubik-LightItalic", size: 9)
        view.definitionLabel.font = UIFont(name: "Rubik-Regular", size: 12)
        view.backgroundColor = .brown
        return view
    }()

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(wordView)
        contentView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            wordView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            wordView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            wordView.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    func updateLabels(word: String, partOfSpeech: String, definition: String) {
        wordView.wordLabel.text = word
        wordView.partOfSpeechLabel.text = partOfSpeech
        wordView.definitionLabel.text = definition
        print("updateLabels called")
//        wordView.wordLabel.text = "word"
//        wordView.partOfSpeechLabel.text = "partOfSpeech"
//        wordView.definitionLabel.text = "definition"
    }
}
