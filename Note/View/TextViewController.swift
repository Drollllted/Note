//
//  TextViewController.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit
import CoreData
class TextViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    private let dataBase = DataBaseNotes.shared
    var note: Note?
    
    //MARK: Setup UI models
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        textView.keyboardType = .default
        textView.text = note?.text
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name Title"
        textField.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        textField.keyboardType = .default
        textField.backgroundColor = .white
        textField.text = note?.nameRow
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        textView.delegate = self
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSave))
        
        //print(dataBase.notes.description)
        
        setTextField()
        setTextView()
        
    }
    
    
    //MARK: Objc method
    
    @objc func didSave() {
        if self.note == nil {
            self.dataBase.addRowNotes(nameRow: textField.text ?? "", text: textView.text)
        }else{
            self.note?.updateNotes(nameRow: textField.text ?? "", text: textView.text)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Constraints
    private func setTextField() {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setTextView() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    
}
