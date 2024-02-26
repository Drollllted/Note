 //
//  Note+CoreDataProperties.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var nameRow: String?

}

extension Note : Identifiable {

    //MARK: For Rows
    func updateNotes(nameRow: String) {
        self.id = id
        self.nameRow = nameRow
        try? managedObjectContext?.save()
    }
    
    func deleteNotes() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
    
    
    //MARK: For textView
    func updateText(text: String){
        self.id = id
        self.text = text
        try? managedObjectContext?.save()
    }
}
