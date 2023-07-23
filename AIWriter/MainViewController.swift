//
//  ViewController.swift
//  AIWriter
//
//  Created by Rıdvan Yılmaz on 22.07.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        setupTableView()
    }
    
    private func navTitleWithImageAndText(titleText: String, imageName: String) -> UIView {
        
        let titleView = UIView()
        
        let label = UILabel()
        label.text = titleText
        label.sizeToFit()
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center
        
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        
        let imageAspect = image.image!.size.width / image.image!.size.height
        
        let imageX = label.frame.origin.x - label.frame.size.height * imageAspect
        let imageY = label.frame.origin.y
        
        let imageWidth = label.frame.size.height * imageAspect
        let imageHeight = label.frame.size.height
        
        image.frame = CGRect(x: imageX - 5, y: imageY, width: imageWidth, height: imageHeight)
        
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        titleView.addSubview(label)
        titleView.addSubview(image)
        
        titleView.sizeToFit()
        
        return titleView
        
    }
    
    private func setupNavigation() {
        self.navigationItem.titleView = navTitleWithImageAndText(titleText: "AI Writer", imageName: "vector")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"setting"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        
        setupBackgroundImageConstraints()
        setupTableViewConstraints()
    }
    
    private let basicLists: [BasicList] = [
        .init(
            title: "Easy Writer",
            subtitle: "“Write an essay about”",
            buttonTitle: "TRY IT"
        ),
        .init(
            title: "Tweet Writer",
            subtitle: "“Write a viral tweet about”",
            buttonTitle: "TRY IT"
        ),
        .init(
            title: "Song Writer",
            subtitle: "“Write song lyrics about”",
            buttonTitle: "TRY IT"
        )
    ]
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: TableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.setCell(basicList: basicLists[indexPath.section])
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

extension MainViewController: TableViewCellDelegate {
    
    func buttonTapped(cell: UITableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        let vc = ChatViewController(basicList: basicLists[indexPath.section])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
