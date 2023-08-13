//
//  NetworkManager.swift
//  lexi
//
//  Created by Hung Nguyen on 7/28/23.
//

import Foundation

enum CommonError: LocalizedError {
    case defaultError
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .defaultError:
            return "Default Error"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

enum APIError: LocalizedError {
    case missingOrInvalidURL
    
    var errorDescription: String? {
        switch self {
        case .missingOrInvalidURL:
            return "Missing or Invalid URL"
        }
    }
}

class NetworkManager {
    // A shared object we can use throughout the project
    static let shared = NetworkManager()
    
    // Function that fetches a random word. It takes in a completion handler. The handler takes a Result object as a parameter and returns void.
    func fetchRandomWord(completion: @escaping (Result<Word, Error>) -> Void) {
        guard let randomWordURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions") else {
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        let headers = [
            "x-rapidapi-key": "59e0b99e1bmshbc2aee70a07c9cfp1e130cjsnd30df63eb36c",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: randomWordURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response,error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.missingOrInvalidURL))
                print("Fetching for random word failed with error \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                print(randomWord)
                completion(.success(randomWord))
            } catch {
                print("Fetching for random word failed with error \(String(describing: error.localizedDescription))")
                completion(.failure(APIError.missingOrInvalidURL))
            }
        }).resume()
    }
    
    func fetchWordWithDetails(_ word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        guard let fetchWordDataURL = URL(string: "https://worsdapiv1.p.rapidapi.com/words/\(word)") else {
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        let headers = [
            "x-rapidapi-key": "59e0b99e1bmshbc2aee70a07c9cfp1e130cjsnd30df63eb36c",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: fetchWordDataURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.missingOrInvalidURL))
                return
            }
            
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(word))
            } catch {
                print("Failed to decode Word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }).resume()
    }
}
