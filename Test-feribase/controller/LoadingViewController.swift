//
//  LoadingViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 14/09/22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(durationInSeconds: 2.0) {
            self.showInitialView()
        }
    }

    private func showInitialView(){
        if AuthManager().isUserLoggedIn() {
            PresenterManager.shared.show(vc: .mainTabBarController)
        }else{
            performSegue(withIdentifier: K.Segue.showOnboarding , sender: nil)
        }
    }
}
