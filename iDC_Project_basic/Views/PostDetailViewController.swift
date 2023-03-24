//
//  PostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class PostDetailViewController: UIViewController, UITextViewDelegate {
    
    let commentCellId = "CommentTableViewCell"
    let detailCellId = "PostDetailTableViewCell"
    var postViewModel: PostViewModel!
    var textFieldConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        commentTextField.delegate = self
        
        tableView.register(PostDetailTableViewCell.self, forCellReuseIdentifier: detailCellId)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: commentCellId)
        
        setupNavigation()
        setupUI()
        setupLayout()
        
        observeKeyboard()
    }
    
    // MARK: - Observe textField
    func observeKeyboard() {
        
        self.textFieldConstraint = NSLayoutConstraint(item: self.commentTextField, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.textFieldConstraint?.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    let tableView: UITableView = {
        let tv = UITableView()
        
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
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        self.view.backgroundColor = .black
        self.view.addSubview(tableView)
        self.view.addSubview(commentTextField)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - PostDetailViewController extension
extension PostDetailViewController: UITextFieldDelegate {
    // MARK: - Write Comment
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if commentTextField.text == "" {
            showAlert("Check the comment", "comment is empty")
        } else {
            var newComment = postViewModel.comment
            newComment.append(commentTextField.text!)
            
            postViewModel.writeComment(documentID: postViewModel.id, comment: newComment)
            
            Task(priority: .userInitiated) {
                do {
                    try await postViewModel.getDocument(documentID: postViewModel.id)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("Load comment Success")
                } catch {
                    print("Error Load comment: \(error.localizedDescription)")
                }
            }
            
            commentTextField.resignFirstResponder()
            commentTextField.text = nil
        }
        
        return true
    }
}

// MARK: - PostDetailViewController extension
extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Code
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.postViewModel == nil ? 0 : self.postViewModel.NumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.postDetailNumberOfRowInSection(section) + postViewModel.commentNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: detailCellId, for: indexPath) as? PostDetailTableViewCell else { fatalError("PostDetailTableViewCell not found") }
            
            cell.titleLabel.text = postViewModel.title
            cell.timeLabel.text = postViewModel.time
            cell.contentTextView.text = postViewModel.description
            cell.selectionStyle = .none
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellId, for: indexPath) as? CommentTableViewCell else { fatalError("CommentTableViewCell not found") }
        
        let comment = self.postViewModel.commentAtIndex(indexPath.row)
        cell.commentLabel.text = comment
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}
