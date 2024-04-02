//
//  NoteVC.swift
//  Note
//
//  Created by Eugene Kovs on 01.04.2024.
//  https://github.com/kovs705
//

import UIKit
import CoreData

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - Properties
    private let noteRepository = NoteRepository.shared
    private var noteView: NoteView!
    
    // MARK: - Lifecycle
    override func loadView() {
        noteView = NoteView()
        view = noteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(didTap))
        
        noteView.tableView.delegate = self
        noteView.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try noteRepository.getNotes()
        } catch {
            print("Failed to fetch and update notes: \(error)")
        }
        
        noteView.tableView.reloadData()
    }
    
    // MARK: - Methods
    
    @objc func didTap() {
        let vc = TextVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteRepository.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = noteRepository.notes[indexPath.row].nameRow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TextVC()
        vc.note = noteRepository.notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = noteRepository.notes[indexPath.row]
            do {
                try noteRepository.deleteNote(id: note.id)
                
                tableView.performBatchUpdates({
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }, completion: { finished in
                    if finished {
                        print("Удаление прошло успешно")
                    }
                })
                
            } catch {
                
                print("Ошибка в поиске и удалении заметки \(note): \(error)")
            }
        }
    }
}
