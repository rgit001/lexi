//
//  SearchView.swift
//  lexi
//
//  Created by Hung Nguyen on 8/24/23.
//

import Foundation
import UIKit

protocol SearchDefinitionsDelegate: AnyObject {
    func searchDefinitions(forWord word: String?)
}


class SearchView: UIView {
    
    weak var searchDefinitionsDelegate: SearchDefinitionsDelegate?
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Find a word..."
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 15.0
        
        // create icon
        let iconView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        iconView.image = UIImage(systemName: "magnifyingglass")
        // container for iconView
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 25, height: 25))
        iconContainerView.addSubview(iconView)
        
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    // MARK: - Initializers
    init(searchDefinitionsDelegate: SearchDefinitionsDelegate?) {
        super.init(frame: .zero)
        self.searchDefinitionsDelegate = searchDefinitionsDelegate
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchButtonPressed() {
        print("searchButtonPressed")
        searchDefinitionsDelegate?.searchDefinitions(forWord: textField.text)
    }
    
    func setUpViews() {
        backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(searchButton)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
        ])
        
        
        
        
        
    }
    
    
    
    
}
