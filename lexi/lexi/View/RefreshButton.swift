//
//  RefreshButton.swift
//  lexi
//
//  Created by Hung Nguyen on 7/24/23.
//

import UIKit

class RefreshButton: UIButton {
    var completion: (() -> Void)?
    
    init(completion: (() -> Void)?,frame: CGRect = .zero) {
        super.init(frame: frame)
        self.completion = completion
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle", withConfiguration: symbolConfiguration)
        tintColor = .white
        setImage(image, for: .normal)
        
        // When user taps button, send message to button to call the buttonPressed method
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        print("buttonPressed")
        completion?()
    }
}
