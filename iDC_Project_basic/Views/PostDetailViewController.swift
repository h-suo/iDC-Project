//
//  PostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class PostDetailiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "CommentTableViewCell"
    var postVM: PostViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigation()
        setupUI()
        setupLayout()
        updateData()
    }
    
    // MARK: - Function Code
    func updateData() {
        titleLabel.text = postVM.title
        textView.text = postVM.description
        timeLabel.text = postVM.time
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
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
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .lightGray
        tv.isEditable = false
        
        return tv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemFill
        
        return tv
    }()
    
    let commentTextField: UITextField = {
        let ctf = UITextField()
        ctf.borderStyle = .roundedRect
        ctf.placeholder = "Please enter a comment"
        ctf.backgroundColor = .secondarySystemFill
        ctf.font = .systemFont(ofSize: 18)
        
        return ctf
    }()
    
    func setupUI() {
        self.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.backgroundColor = .black
        self.view.addSubview(titleLabel)
        self.view.addSubview(timeLabel)
        self.view.addSubview(textView)
        self.view.addSubview(tableView)
        self.view.addSubview(commentTextField)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
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
            textView.heightAnchor.constraint(equalToConstant: 250),
            textView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
            tableView.bottomAnchor.constraint(equalTo: commentTextField.topAnchor),
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
