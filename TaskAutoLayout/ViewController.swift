//
//  ViewController.swift
//  TaskAutoLayout
//
//  Created by Igor Ashurkov on 28.03.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileHeaderViewCell.self, forCellReuseIdentifier: "ProfileHeaderViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        
        self.drawSelf()
    }
    
    
    // MARK: - Private methods
    
    private func drawSelf() {
        self.view.addSubview(self.tableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        let constraintsForTableView = self.constraintsForTableView()
        
        NSLayoutConstraint.activate(
            constraintsForTableView
        )
    }
    
    private func constraintsForTableView() -> [NSLayoutConstraint] {
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor,
            trailingAnchor,
            leadingAnchor,
            bottomAnchor
        ]
    }
    
    @objc private func forcedHideKeyboard() {
        self.view.endEditing(true)
    }
    
    private func forceUpdateTableView() {
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderViewCell", for: indexPath)
        (cell as? ProfileHeaderViewCell)?.delegate = self
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}


// MARK: - ProfileHeaderViewCellDelegate

extension ViewController: ProfileHeaderViewCellDelegate {
    
    func didTapEditButton() {
        self.forcedHideKeyboard()
        self.forceUpdateTableView()
    }
}
