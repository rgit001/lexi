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
    static func createFavoriteItem(word: String, partOfSpeech: String?, definition: String) {
        do {
            let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
            // Fetch any record of this word.
            fetchRequest.predicate = NSPredicate(format: "word == %@", word)
            
            // Determine number of records with this word. We don't want duplicate words in the database.
            let numOfRecords = try managedObjectContext.count(for: fetchRequest)
            
            // If no record of this word exists, then create the word in the db.
            if numOfRecords == 0 {
                do {
                    let favoriteItem = Favorite(context: managedObjectContext)
                    favoriteItem.word = word
                    favoriteItem.definition = definition
                    
                    if let partOfSpeech = partOfSpeech {
                        favoriteItem.partOfSpeech = partOfSpeech
                    } else {
                        favoriteItem.partOfSpeech = "n/a"
                    }
                    print("numOfRecords: \(numOfRecords). Saving context")
                    
                    // Word is not in the database so save word.
                    try managedObjectContext.save()
                } catch {
                    print("error saving context: \(error.localizedDescription)")
                }
            } else {
                print("numOfRecords: \(numOfRecords). Not saving context")
            }
        } catch {
                print("error saving context: \(error.localizedDescription)")
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
        print("fetchFavoriteItem: \(word)")
        
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
    
    static func batchDeleteFavorites() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.executeAndMergeChanges(using: batchDeleteRequest)
        } catch {
            print("Batch delete error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update
    // TODO: - Decide if an update method is necessary. Right now I don't think it is.
}

extension NSManagedObjectContext {
    
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
    public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        // Configure the request to return the IDs of the objects it deletes.
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        // Execute request.
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        
        // Extract the IDs of the deleted managed objects from the request's result.
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        // Merge the deletions into the app's managed object context.
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
    }
}
