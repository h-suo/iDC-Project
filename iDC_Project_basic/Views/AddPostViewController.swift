//
//  AddPostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class AddPostViewController: UIViewController, UITextViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
                
        setupNavigation()
        navigationItemSetting()
        setupUI()
        setupLayout()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Post"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func navigationItemSetting() {
        let rightButton = UIBarButtonItem(title: "write", style: .plain, target: self, action: #selector(writeButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - Setup function
    @IBAction func writeButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Setup TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Please enter your content." {
            textView.text = nil
            textView.textColor = .white
            textView.becomeFirstResponder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringeRange = Range(range, in: currentText) else { return false }
        
        let changeText = currentText.replacingCharacters(in: stringeRange, with: text)
        
        textCountLabel.text = "(\(changeText.count)/1000)"
        return changeText.count <= 999
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Setup UI
    let titleTextField: UITextField = {
        let ttf = UITextField()
        ttf.borderStyle = .roundedRect
        ttf.placeholder = "title"
        ttf.backgroundColor = .systemFill
        ttf.font = .systemFont(ofSize: 20)
        
        return ttf
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemFill
        tv.font = .systemFont(ofSize: 18)
        tv.text = "Please enter your content."
        tv.textColor = .systemGray2
        tv.layer.cornerRadius = 4
        
        return tv
    }()
    
    let textCountLabel: UILabel = {
        let tcl = UILabel()
        tcl.font = UIFont.systemFont(ofSize: 14)
        tcl.textColor = .gray
        tcl.textAlignment = .right
        tcl.text = "(0/1000)"
        
        return tcl
    }()
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(titleTextField)
        self.view.addSubview(textView)
        self.view.addSubview(textCountLabel)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            titleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 300),
            textView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            textCountLabel.widthAnchor.constraint(equalToConstant: 80),
            textCountLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -12),
            textCountLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -12)
        ])
    }
}
