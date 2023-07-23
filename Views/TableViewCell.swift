//
//  TableViewCell.swift
//  AIWriter
//
//  Created by Rıdvan Yılmaz on 22.07.2023.
//

import UIKit

struct BasicList {
    var title: String
    var subtitle: String
    var buttonTitle: String
}

protocol TableViewCellDelegate: AnyObject {
    func buttonTapped(cell: UITableViewCell)
}

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    weak var delegate: TableViewCellDelegate?
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor("A8B5C1")
        return label
    }()
    
    private var tryButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    func tryButtonAction() {
        tryButton.addTarget(self, action: #selector(self.handleTryButton(sender:)), for: .touchUpInside)
    }
    
    @objc func handleTryButton(sender: UIButton) {
        delegate?.buttonTapped(cell: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tryButtonAction()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor("BDDDFB", alpha: 0.14)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(tryButton)
        
        configureConstraints()
        
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14)
        ]
        
        let commandLabelConstraints = [
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ]
        
        let tryButtonConstraints = [
            tryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tryButton.heightAnchor.constraint(equalToConstant: 26),
            tryButton.widthAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(commandLabelConstraints)
        NSLayoutConstraint.activate(tryButtonConstraints)
    }
    
    func setCell(basicList: BasicList) {
        titleLabel.text = basicList.title
        subtitleLabel.text = basicList.subtitle
        tryButton.setTitle(basicList.buttonTitle, for: .normal)
    }
}
