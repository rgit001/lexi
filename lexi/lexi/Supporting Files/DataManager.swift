//
//  DataManager.swift
//  lexi
//
//  Created by Hung Nguyen on 8/27/23.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    // This managed object context allows us to access our persistent container
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext // Think of the "persistentContainer" as our database, and the "viewContext" as the staging
                                                            // area where we can make changes.
    }()
    
    // MARK: - Create
    static func createFavoriteItem(word: String, partOfSpeech: String, definition: String) {
        let favoriteItem = Favorite(context: managedObjectContext)
        favoriteItem.word = word
        favoriteItem.definition = definition
        favoriteItem.partOfSpeech = partOfSpeech
        
        do {
            try managedObjectContext.save()
        } catch {
            // add error handling here
        }
    }
    
    // MARK: - Read
    static func fetchFavoriteItems(completion: ([Favorite]?) -> Void) {
        do {
            let favoriteItems = try managedObjectContext.fetch(Favorite.fetchRequest())
            completion(favoriteItems)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        completion(nil)
    }
    
    static func fetchFavoriteItem(usingWord word: String, completion: (Favorite?) -> Void) {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        
        do {
            let favoriteItem = try managedObjectContext.fetch(fetchRequest)
            completion(favoriteItem.first)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        completion(nil)
    }
    
    // MARK: - Delete
    static func deleteFavorite(favorite: Favorite) {
        managedObjectContext.delete(favorite)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not delete due to error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update
    // TODO: - Decide if an update method is necessary. Right now I don't think it is.
    
    
    
}

