//
//  PostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class PostDetailViewController: UIViewController, UITextViewDelegate {
    
    let cellId = "CommentTableViewCell"
    var postViewModel: PostViewModel!
    var textFieldConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        
        contentTextView.delegate = self
        contentTextView.isScrollEnabled = false
        
        commentTextField.delegate = self
        
        setupNavigation()
        setupUI()
        setupLayout()
        
        updateData()
        
        observeKeyboard()
    }
    
    // MARK: - Update Data
    func updateData() {
        titleLabel.text = postViewModel.title
        contentTextView.text = postViewModel.description
        timeLabel.text = postViewModel.time
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
    let contentView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    let contentScrollView: UIScrollView = {
        let bv = UIScrollView()
        
        return bv
    }()
    
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
        ctv.textColor = .white
        ctv.isEditable = false
        
        return ctv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
//        tv.backgroundColor = .tertiarySystemFill
        
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
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        self.view.backgroundColor = .black
        self.view.addSubview(contentScrollView)
        self.view.addSubview(commentTextField)
        self.contentScrollView.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(contentTextView)
        self.contentView.addSubview(tableView)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: commentTextField.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo:  contentScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo:  contentScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo:  contentScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo:  contentScrollView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            timeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            contentTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contentTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
//            tableView.heightAnchor.constraint(equalToConstant: 500),
            tableView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            tableView.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: contentView.bottomAnchor),
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
            postViewModel.getDocument(documentID: postViewModel.id, completion: { result in
                switch result {
                case .success:
                    self.tableView.reloadData()
                    print("Load comment success")
                case .failure(let err):
                    print("Error Loading comment: \(err)")
                }
            })
            
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
        return self.postViewModel == nil ? 0 : self.postViewModel.commentNumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.commentNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CommentTableViewCell else { fatalError("CommentTableViewCell not found") }
        
        let comment = self.postViewModel.commentAtIndex(indexPath.row)
        cell.selectionStyle = .none
        cell.commentLabel.text = comment
        
        return cell
    }
}
