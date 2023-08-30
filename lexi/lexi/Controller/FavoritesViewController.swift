//
//  FavoritesViewController.swift
//  lexi
//
//  Created by Hung Nguyen on 8/29/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    let favoriteHeaderLabel: UILabel = { // the topmost word displayed on the page
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Favorites"
        label.font = UIFont(name: "Rubik-SemiBold", size: 36)
        return label
    }()
    
    let horizontalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor(named: "GrayBackground")
        return tableView
    }()
    
    var favoriteWords: [Favorite]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "GrayBackground")
        fetchFavorites()
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    private func fetchFavorites() {
        DataManager.fetchFavoriteItems(completion: { [weak self] favoriteWords in
            if let favoriteWords = favoriteWords {
                self?.favoriteWords = favoriteWords
            }
        })
        print("favoriteWords count: \(favoriteWords!.count)")
    }
    
    private func setUpUI() {
        view.addSubview(favoriteHeaderLabel)
        view.addSubview(horizontalLine)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            favoriteHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            favoriteHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            favoriteHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            horizontalLine.topAnchor.constraint(equalTo: favoriteHeaderLabel.bottomAnchor),
            horizontalLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        
        cell.updateFavoriteLabels(withFavorite: favoriteWords[indexPath.row])
        return cell
    }
}
