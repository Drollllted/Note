//
//  ViewBuilder.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit
import CoreData
class ViewBuilder{
    static let shared = ViewBuilder()
    
    var note: Note?
    
    private init(){}
    
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
}
