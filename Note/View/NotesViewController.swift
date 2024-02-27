//
//  ViewController.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    private let dataBase = DataBaseNotes.shared
    
    private let build = ViewBuilder.shared
    
    var notes = [Note]()
    
    var note: Note?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setTableView()
        
        self.navigationItem.title = "Note"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(didTap))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func didTap() {
        let vc = TextViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}
     
extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataBase.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataBase.notes[indexPath.row].nameRow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TextViewController()
        vc.note = dataBase.notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = dataBase.notes[indexPath.row]
            note.deleteNotes()
            dataBase.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
}
