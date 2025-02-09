//
//  ViewController.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit

protocol HomeScreenViewDelegate {
    func handleButtonTap(username: String?)
}

class HomeScreenViewController: UIViewController {
    
    // MARK: View lifecycle functions
    override func loadView() {
        self.view = HomeScreenView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "GitHub Viewer"
    }
}

// MARK: Extension - View Delegate
extension HomeScreenViewController: HomeScreenViewDelegate {
    func handleButtonTap(username: String?) {
        guard let username = username else { return }
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Go Back", style: .plain, target: nil, action: nil) // this sets the navigation title in the next vc
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.pushViewController(ProfileDetailViewController(username: username), animated: true)
    }
}
