//
//  ProfileDetailView.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit

// This is the main view for the ProfileDetailViewController
class ProfileDetailView: UIView {
    // MARK: Variables
    fileprivate var user: User? {
        didSet {
            finishProcessing()
        }
    }
    
    // MARK: UI Elements
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profilePicture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 75
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 17)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider: UIView = {
        let divider = UIView()
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor.gray.cgColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.isHidden = true
        return divider
    }()
    
    lazy var repositoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: Initialization
    init(user: User? = nil) {
        super.init(frame: .zero)
        self.user = user
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    // This function should handle the ui elements processing, it is supposed to be called whenever the user variable is set
    private func finishProcessing() {
        guard let user = user else { return }
        self.activityIndicatorView.stopAnimating()
        
        self.profilePicture.isHidden = false
        self.nameLabel.isHidden = false
        self.divider.isHidden = false
        self.repositoriesTableView.isHidden = false
        
        if let image = user.image {
            self.profilePicture.image = UIImage(data: image)
        }
        self.nameLabel.text = user.name
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.repositoriesTableView.reloadData()
            if user.repositories != nil {
            self.repositoriesTableView.beginUpdates()
            self.repositoriesTableView.endUpdates()
            }
        }
    }
    
    public func updateView(with user: User) {
        self.user = user
    }
}

// MARK: Extension - View Setup
extension ProfileDetailView: ViewCode {
    func addSubviews() {
        addSubview(activityIndicatorView)
        addSubview(profilePicture)
        addSubview(nameLabel)
        addSubview(divider)
        addSubview(repositoriesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 150),
            profilePicture.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 16),
            
            divider.centerYAnchor.constraint(equalTo: repositoriesTableView.topAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            repositoriesTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            repositoriesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            repositoriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            repositoriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    func configurations() {
        backgroundColor = UIColor.white
    }
}

// MARK: Extension - TableView Data Source
extension ProfileDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user?.repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.id, for: indexPath) as? Cell else { fatalError("Could not dequeue cell") }
        
        guard let repository = self.user?.repositories?[indexPath.row] else { return cell }
        
        cell.configureCell(repository: repository)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: Extension - TableView Delegate
extension ProfileDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
