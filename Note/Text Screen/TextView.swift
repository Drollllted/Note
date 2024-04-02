//
//  TextView.swift
//  Note
//
//  Created by Eugene Kovs on 02.04.2024.
//  https://github.com/kovs705
//

import UIKit

class TextView: UIView {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name Title"
        textField.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        textField.keyboardType = .default
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        textView.keyboardType = .default
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(textField)
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            textView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
