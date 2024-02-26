//
//  TextViewController.swift
//  Note
//
//  Created by Drolllted on 26.02.2024.
//

import UIKit

class TextViewController: UIViewController {
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        textView.keyboardType = .default
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "1"
        
        setTextView()
    }
    
    private func setTextView() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}
