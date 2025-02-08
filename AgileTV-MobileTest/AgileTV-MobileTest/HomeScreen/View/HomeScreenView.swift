//
//  MainView.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit

class HomeScreenView: UIView {
    // MARK: variables
    var delegate: HomeScreenViewDelegate?
    
    // MARK: UI Elements
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialization
    init(delegate: HomeScreenViewDelegate) {
        super.init(frame: .zero)
        setupView()
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Functions
    @objc private func handleTap() {
        delegate?.handleButtonTap(username: nameTextField.text)
    }
}

// MARK: Extension - View Setup
extension HomeScreenView: ViewCode {
    func addSubviews() {
        addSubview(nameTextField)
        addSubview(searchButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 32),
            nameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            
            searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
        ])
            
    }
    
    func configurations() {
        self.backgroundColor = UIColor.white
    }
}
