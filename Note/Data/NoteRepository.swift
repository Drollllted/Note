//
//  NoteRepository.swift
//  Note
//
//  Created by Eugene Kovs on 01.04.2024.
//  https://github.com/kovs705
//

import Foundation
import CoreData

enum NoteRepositoryError: Error {
    case noteNotFound
}

final class NoteRepository: NoteRepositoryProtocol {
    
    static let shared = NoteRepository()
    var persistentContainer: NSPersistentContainer
    
    private(set) var notes: [Note] = []
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Note")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func addOrUpdateNote(note: Note) throws {
        let context = persistentContainer.viewContext
        try context.performAndWait {
            if note.objectID.isTemporaryID {
                do {
                    // если заметка новая - она добавится
                    try context.save()
                } catch {
                    context.rollback()
                    throw error
                }
            } else {
                // Если уже существует - обновится
                if let existingNote = try? getNoteById(id: note.id) {
                    existingNote.text = note.text
                    existingNote.nameRow = note.nameRow
                    do {
                        try context.save()
                    } catch {
                        context.rollback()
                        throw error
                    }
                }
            }
        }
    }
    
    
    func deleteNote(id: UUID) throws {
        let context = persistentContainer.viewContext
        
        try context.performAndWait {
            guard let note = try getNoteById(id: id) else {
                throw NoteRepositoryError.noteNotFound
            }
            
            context.delete(note)
            do {
                try context.save()
                try getNotes()
            } catch {
                context.rollback()
                throw error
            }
        }
    }
    
    func getNotes() throws {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            do {
                notes = try context.fetch(fetchRequest)
            } catch {
                fatalError("Failed to fetch notes: \(error)")
            }
        }
    }
    
    func getNoteById(id: UUID) throws -> Note? {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let context = persistentContainer.viewContext
        var note: Note? = nil
        context.performAndWait {
            do {
                note = try context.fetch(fetchRequest).first
            } catch {
                fatalError("Failed to fetch note by id: \(error)")
            }
        }
        return note
    }
    
}
