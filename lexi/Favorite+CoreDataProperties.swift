//
//  Favorite+CoreDataProperties.swift
//  lexi
//
//  Created by Hung Nguyen on 8/26/23.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var word: String?
    @NSManaged public var definition: String?
    @NSManaged public var partOfSpeech: String?

}

extension Favorite : Identifiable {

}
