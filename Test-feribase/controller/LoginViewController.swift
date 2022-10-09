//
//  LoginViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 26/09/22.
//


import UIKit
import MBProgressHUD
import Loaf

class LoginViewController: UIViewController {
    
    
    weak var delegate : OnboardingDelegate?
    private let authManager = AuthManager()
    
        
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segmentadControl: UISegmentedControl!
    
    private enum PageType{
        case login
        case signUp
    }
    
    private var errorMassage: String? {
        didSet{
            showErrorMessageIfNeeded(text: errorMassage)
        }
    }
    
    private var currentPageType: PageType = .login {
        didSet{
            setupViewFor(pageType: currentPageType)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewFor(pageType: .login)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }

    private func setupViewFor(pageType: PageType){
        errorMassage = nil
        passwordConfirmationTextField.isHidden = pageType == .login
        signUpButton.isHidden = pageType == .login
        forgetPasswordButton.isHidden = pageType == .signUp
        loginButton.isHidden = pageType == .signUp
    }
    
    private func showErrorMessageIfNeeded(text: String?){
        errorLabel.isHidden = text == nil
        errorLabel.text = text
    }

    @IBAction func forgetPasswordButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Forget password", message: "Please enter your email.", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let this = self else {return}
            if let textField = alertController.textFields?.first, let email = textField.text , !email.isEmpty{
                this.authManager.resetPassword(withemail: email) { (result) in
                    switch result {
                    case .success:
                        this.showAlert(title: "Password Reset Successeful", message: "Please check your email to find the password reset link.")
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .bottom, sender: this).show()
                    
                }
            }
        }
    }
        alertController.addAction(alertOk)
        alertController.addAction(cancelAction)
        present(alertController , animated: true, completion: nil)
    }
    
    private func showAlert(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              let passwordConfirmation = passwordConfirmationTextField.text,
              !passwordConfirmation.isEmpty else{
            showErrorMessageIfNeeded(text: "Inavalid form")
            return}
        
        guard password == passwordConfirmation else{
            showErrorMessageIfNeeded(text: "Password are incorrect")
        return}
        
        MBProgressHUD.showAdded(to: view, animated: true)
        authManager.signUpNewUser(wirhEmail: email, password: password) { [weak self] result in
            guard let this  = self else {return}
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result{
            case .success:
                this.delegate?.showMainTabController()
            case .failure(let error):
                this.showErrorMessageIfNeeded(text: error.localizedDescription)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else{
            showErrorMessageIfNeeded(text: "Inavalid form")
            return}
        MBProgressHUD.showAdded(to: view, animated: true)

        authManager.loginUser(withEmail: email, password: password) { [weak self] result in
            guard let this = self else {return}
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result{
            case .success:
                this.delegate?.showMainTabController()
            case .failure(let error):
                this.showErrorMessageIfNeeded(text: error.localizedDescription)
            }
        }
}
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl){
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}
