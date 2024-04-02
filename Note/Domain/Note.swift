//
//  Note.swift
//  Note
//
//  Created by Eugene Kovs on 01.04.2024.
//  https://github.com/kovs705
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {}

extension Note: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var nameRow: String

}


