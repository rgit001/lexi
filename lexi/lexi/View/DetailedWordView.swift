//
//  DetailedWordView.swift
//  lexi
//
//  Created by Hung Nguyen on 7/25/23.
//

import UIKit

class DetailedWordView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // MARK: - Views
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-SemiBoldItalic", size: 14)
        label.text = "header" // Delete me
        label.isHidden = true
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Light", size: 18)
        label.text = "enjoying or showing or marked by joy or pleasure" // delete me
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true
        return label
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-SemiBold", size: 12)
        label.text = "Definition"
        label.isHidden = true
        label.textColor = .white
        return label
    }()
    
    // MARK: - Property Observers
    var headerText: String = "" {
        didSet {
            print("didSet headerText")
            headerLabel.text = headerText
            headerLabel.isHidden = false
        }
    }
    
    var bodyText: String = "" {
        didSet {
            print("didSet bodyText")
            bodyLabel.text = bodyText
            bodyLabel.isHidden = false
        }
    }
    
    var footerText: String = "" {
        didSet {
            print("didSet footerText")
            footerLabel.text = footerText
            footerLabel.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(headerLabel)
        addSubview(bodyLabel)
        addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            footerLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 10),
            footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
