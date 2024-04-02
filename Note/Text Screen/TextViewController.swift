//
//  TextViewController.swift
//  Note
//
//  Created by Eugene Kovs on 02.04.2024.
//  https://github.com/kovs705
//

import UIKit
import CoreData

import UIKit
import CoreData

class TextVC: UIViewController {
    
    private let noteRepository = NoteRepository.shared
    var note: Note?
    private var textView: TextView!
    
    override func loadView() {
        textView = TextView()
        view = textView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textField.delegate = self
        textView.textView.delegate = self
        
        textView.textField.text = note?.nameRow
        textView.textView.text = note?.text
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSave))
    }
    
    @objc func didSave() {
        guard let nameRow = textView.textField.text, !nameRow.isEmpty,
                let text = textView.textView.text, !text.isEmpty else {
            return
        }
        
        if let note = self.note {
            // Update existing note
            note.nameRow = nameRow
            note.text = text
            do {
                try noteRepository.addOrUpdateNote(note: note)
            } catch {
                print("Error updating note: \(error)")
            }
        } else {
            // Create a new Note object and add it
            let newNote = Note(context: noteRepository.persistentContainer.viewContext)
            newNote.id = UUID()
            newNote.nameRow = nameRow
            newNote.text = text
            do {
                try noteRepository.addOrUpdateNote(note: newNote)
            } catch {
                print("Error adding new note: \(error)")
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate, UITextViewDelegate
extension TextVC: UITextFieldDelegate, UITextViewDelegate {
    // Implement delegate methods as needed
}
