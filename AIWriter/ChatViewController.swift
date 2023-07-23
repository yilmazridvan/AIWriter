//
//  ChatViewController.swift
//  AIWriter
//
//  Created by Rıdvan Yılmaz on 22.07.2023.
//

import UIKit

final class ChatViewController: UIViewController {
    
    private var basicList: BasicList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        
        setupBackgroundImageConstraints()
        setupTableViewConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    init(basicList: BasicList) {
        self.basicList = basicList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupBackgroundImageConstraints() {
        let backgroundImageConstraints = [
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(backgroundImageConstraints)
    }
    
    private func setupTableViewConstraints() {
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: TableViewCell.self, for: indexPath)
        let newBasicList = basicList.map { (basicList: BasicList) -> BasicList in
            var tempBasicList = basicList
            tempBasicList.title = ""
            tempBasicList.buttonTitle = ""
            return tempBasicList
        }
        
        cell.setCell(basicList: newBasicList!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
}
