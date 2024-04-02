//
//  NoteRepositoryProtocol.swift
//  Note
//
//  Created by Eugene Kovs on 01.04.2024.
//  https://github.com/kovs705
//

import Foundation
import CoreData

protocol NoteRepositoryProtocol {
    func addOrUpdateNote(note: Note) throws
    func deleteNote(id: UUID) throws
    func getNotes() throws
    func getNoteById(id: UUID) throws -> Note?
}
