//
//  Word.swift
//  lexi
//
//  Created by Hung Nguyen on 7/16/23.
//

import Foundation

protocol WordProtocol {
    var word: String { get }
    var results: [WordDetail] { get }
}

struct Word: WordProtocol, Codable {
    var word: String
    var results: [WordDetail]
}

struct WordDetail: Codable {
    var definition: String
    var partOfSpeech: String?
    var synonyms: [String]?
    var antonyms: [String]?
//    var exampleUsages: [String]? // Commented out - not sure if example usage is an actual api field
}
