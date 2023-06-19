//
//  View.swift
//  VIPER-Architecture
//
//  Created by Lucas C Barros on 2023-06-18.
//

import UIKit

/// Responsible for the user interface
// ViewController (Can have a ViewController be the view i this architecture)
// Protocol
// Reference Presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    // Simple tableView just to help explain
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add color so we see it it's running
        view.backgroundColor = .systemRed
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
        
        DispatchQueue.main.async {
            self.label.text = error
            self.label.isHidden = false
        }
    }
}

// MARK: TableView methods not related to VIPER
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Check Success flow
        cell.textLabel?.text = users[indexPath.row].name
        
        // Check Error flow
//        cell.textLabel?.text = "\(users[indexPath.row].name)"
        return cell
    }
    
    
}
