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
    
    let mainWordView: MainWordView = {
        let view = MainWordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BlueMainWord")
        return view
    }()

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
}

