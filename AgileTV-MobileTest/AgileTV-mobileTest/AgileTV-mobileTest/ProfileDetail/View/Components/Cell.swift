//
//  Cell.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit
import Foundation

class Cell: UITableViewCell {
    
    static let id = "RepositoryCell"
    
    // MARK: UI Elements
    lazy var repositoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var programmingLanguage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    public func configureCell(repository: Repository) {
        repositoryLabel.text = repository.name
        programmingLanguage.text = repository.language ?? "Null"
    }
}

extension Cell: ViewCode {
    func addSubviews() {
        addSubview(repositoryLabel)
        addSubview(programmingLanguage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            repositoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            repositoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            
            programmingLanguage.topAnchor.constraint(equalTo: repositoryLabel.bottomAnchor, constant: 2),
            programmingLanguage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            ])
    }
    
    
}
