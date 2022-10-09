//
//  SettingsViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//

import UIKit
import MBProgressHUD
import Loaf

class SettingsViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        self.title = K.NavigationTitle.settings
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 0.5){ [weak self] in
            guard let this = self else {return}
            let result = this.authManager.logOutUser()
            switch result {
            case .success:
                PresenterManager.shared.show(vc: .onboarding)
            case .failure(let error):
                Loaf(error.localizedDescription, state: .error, location: .top , sender: this).show()
            }
            MBProgressHUD.hide(for: this.view, animated: true)
        }
    }
}
