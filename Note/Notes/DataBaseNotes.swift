//
//  dataBaseNotes.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit
import CoreData

class DataBaseNotes {
    static let shared = DataBaseNotes()
    var notes = [Note]()
    
    
    private init() {
        fetchNotes()
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Note")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext (){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchNotes() {
        let req = Note.fetchRequest()
        if let notes = try? persistentContainer.viewContext.fetch(req){
            self.notes = notes
        }
    }
    
    func addRowNotes(nameRow: String, text: String) {
        let note = Note(context: persistentContainer.viewContext)
        
        note.id = UUID()
        note.nameRow = nameRow
        note.text = text

        saveContext()
        fetchNotes()
    }
    
}

