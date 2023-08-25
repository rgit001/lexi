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
  
    /*** START SEARCH CODE ***/
    lazy var searchView: SearchView = {
        let searchView = SearchView(searchDefinitionsDelegate: self)
        searchView.translatesAutoresizingMaskIntoConstraints = false

        // Top right corner, Top left corner
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return searchView
    }()
    
    var wordResult: Word?
    /*** END SEARCH CODE ***/
    
    
    lazy var mainWordView: MainWordView = {
        let view = MainWordView(completion: { [weak self] in
            self?.getRandomWord() // Update this method to call the API
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BlueMainWord")
        return view
    }()
    
    // MARK: - TableView code
    var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        view.separatorStyle = .singleLine
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(named: "WhiteTableView")
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "GrayBackground")
        tableView.dataSource = self
        tableView.delegate = self
        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(appTitleLabel)
        view.addSubview(mainWordView)
        view.addSubview(tableView)
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            mainWordView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 20),
            mainWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainWordView.heightAnchor.constraint(equalToConstant: 200),
            
            searchView.topAnchor.constraint(equalTo: mainWordView.bottomAnchor, constant: 1),
            searchView.leadingAnchor.constraint(equalTo: mainWordView.leadingAnchor, constant: 0),
            searchView.trailingAnchor.constraint(equalTo: mainWordView.trailingAnchor, constant: 0),
            searchView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
        ])
    }
    
    private func getRandomWord() {
        print("getRandomWord")
        
        // use API to get random word
        NetworkManager.shared.fetchRandomWord(completion: { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.mainWordView.updateWordViewLabels(word: word.word, partOfSpeech: word.results[0].partOfSpeech!, definition: word.results[0].definition)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.mainWordView.wordView.wordLabel.text = "Fetch error"
                    print("Fetch error: \(error.localizedDescription)")
                }
            }
        })
        
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordResult?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        
        cell.updateLabels(withWord: self.wordResult, andIndexPath: indexPath)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailedWordViewController(withWord: wordResult!, andIndexPath: indexPath), animated: true)
    }
}


extension ViewController: SearchDefinitionsDelegate {
    func searchDefinitions(forWord word: String?) {
        guard let word = word, !word.isEmpty else {
            print("search field is empty")
            return
        }
        
        
        // fetchword code goes here
        NetworkManager.shared.fetchWordWithDetails(word) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.wordResult = word
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                // good place to handle errors
                print("failed to decoede word with error: \(error.localizedDescription)")
            }
        }
    }
}
