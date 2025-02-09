//
//  ProfileDetailViewController.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit

// This is the delegate protocol for the View Model, it handles communication between view, view controller and view model
protocol ProfileDetailViewModelDelegate {
    func updateViewWithUser()
    func showErrorAlert(for error: FetchError)
}

// The View Controller for ProfileDetail
class ProfileDetailViewController: UIViewController {
    // MARK: Instances of view and view model
    let profileDetailView = ProfileDetailView()
    let profileDetailViewModel: ProfileDetailViewModel
    
    // MARK: Initializer
    init(username: String) {
        self.profileDetailViewModel = ProfileDetailViewModel(username: username)
        super.init(nibName: nil, bundle: nil)
        self.profileDetailViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle functions
    override func loadView() {
        self.view = profileDetailView
    }
    
}

// MARK: Extension - View Model Delegate
// This extension handles the bodies for the functions in the delegate protocol
extension ProfileDetailViewController: ProfileDetailViewModelDelegate {
    func showErrorAlert(for error: FetchError) {
        var message = ""
        
        switch error {
        case .notFound:
            message = "User not found. Please enter another name"
        default:
            message = "A network error has occurred. Check your Internet connection and try again later"
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func updateViewWithUser() {
        guard let user = self.profileDetailViewModel.user else { return }
        self.profileDetailView.updateView(with: user)
    }
    
    
}
