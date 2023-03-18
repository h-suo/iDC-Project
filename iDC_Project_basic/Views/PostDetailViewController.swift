//
//  PostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class PostDetailiViewController: UIViewController {
    
    let cellId = "CommentTableViewCell"
    var postVM: PostViewModel!
    var textFieldConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        commentTextField.delegate = self
        
        setupNavigation()
        setupUI()
        setupLayout()
        
        updateData()
        
        observeKeyboard()
    }
    
    // MARK: - Update Data
    func updateData() {
        titleLabel.text = postVM.title
        contentTextView.text = postVM.description
        timeLabel.text = postVM.time
    }
    
    // MARK: - Observe textField
    func observeKeyboard() {
        
        self.textFieldConstraint = NSLayoutConstraint(item: self.commentTextField, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.textFieldConstraint?.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            self.textFieldConstraint?.constant = -1 * keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        debugPrint("keyboardWillHide")
        self.textFieldConstraint?.constant = 0
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Setup UI
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = .systemFont(ofSize: 20)
        
        return tl
    }()
    
    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .gray
        
        return tl
    }()
    
    let contentTextView: UITextView = {
        let ctv = UITextView()
        ctv.font = .systemFont(ofSize: 18)
        ctv.textColor = .lightGray
        ctv.isEditable = false
        
        return ctv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .tertiarySystemFill
        
        return tv
    }()
    
    
    let commentTextField: UITextField = {
        let ctf = UITextField()
        ctf.borderStyle = .roundedRect
        ctf.placeholder = "Please enter a comment"
        ctf.backgroundColor = .systemFill
        ctf.font = .systemFont(ofSize: 18)
        
        return ctf
    }()
    
    func setupUI() {
        self.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.backgroundColor = .black
        self.view.addSubview(titleLabel)
        self.view.addSubview(timeLabel)
        self.view.addSubview(contentTextView)
        self.view.addSubview(tableView)
        self.view.addSubview(commentTextField)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            timeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            contentTextView.heightAnchor.constraint(equalToConstant: 250),
            contentTextView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            contentTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contentTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension PostDetailiViewController: UITextFieldDelegate {
    
    // MARK: - Write Comment
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if commentTextField.text == "" {
            showAlert("Check the comment", "comment is empty")
        } else {
            var newComment = postVM.comment
            newComment.append(commentTextField.text!)
            FirebaseDB().writeComment(documentID: postVM.id, comment: newComment)
            commentTextField.resignFirstResponder()
        }
        
        return true
    }
}

extension PostDetailiViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Code
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.postVM == nil ? 0 : self.postVM.commentNumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postVM.commentNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CommentTableViewCell else { fatalError("CommentTableViewCell not found") }
        
        let comment = self.postVM.commentAtIndex(indexPath.row)
        cell.commentLabel.text = comment
        
        return cell
    }
}
