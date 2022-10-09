//
//  HomeViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 27/09/22.
//

import UIKit
import FirebaseAuth


class HomeViewController: UIViewController{
    
    @IBOutlet weak var emailLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    private func setupNavigationBar(){
        self.title = K.NavigationTitle.home
    }
    
    private func setupViews(){
        if let email = Auth.auth().currentUser?.email{
            emailLabel.text = email
        }else{
            emailLabel.text = "something is terriblya wrong!"
        }
    }
}
