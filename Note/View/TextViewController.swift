//
//  TextViewController.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit
import CoreData
class TextViewController: UIViewController, UITextViewDelegate {
    
    private let dataBase = DataBaseNotes.shared
    private let build = ViewBuilder.shared
    
    var note: Note?
    
    private var textView = UITextView()
    private var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        build.textView.delegate = self
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSave))
        
        print(dataBase.notes.description)
        
        setTextField()
        setTextView()

    }

    @objc func didSave() {
        if self.note == nil {
            self.dataBase.addRowNotes(nameRow: textField.text ?? "", text: textView.text)
        }else{
            self.note?.updateNotes(nameRow: textField.text ?? "", text: textView.text)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func setTextField() {
        textField = build.textField
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setTextView() {
        textView = build.textView
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
 

}
