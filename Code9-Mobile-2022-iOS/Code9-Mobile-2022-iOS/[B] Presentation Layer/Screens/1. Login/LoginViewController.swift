//
//  LoginViewController.swift.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/23/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func tapLogin(sender: UIButton!) {
        
        // 1. Check if Username is OK or skip the execution
        if let usernameText = loginView.userNameTextField.text {
            if LoginService.isValideUsername(text: usernameText) == false {
                showUsernameAlert()
                return
            }
        }
        
        // 2. Check if the Password is OK or skip the execution
        if let passwordText = loginView.passwordTextField.text {
            if LoginService.isValidePassword(text: passwordText) == false {
                showPasswordAlert()
                return
            }
        }
        
        // 3. If all is OK navigate to the table view but with NavigationView (top part of the bar)
        let masterViewController = MasterViewController()
        let navigationController = UINavigationController(rootViewController: masterViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    // MARK: - Alert
    
    private func showUsernameAlert() {
        let alert = UIAlertController(title: "Wrong Username", message: "Username need to have 6 or more characters.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
    
    private func showPasswordAlert() {
        let alertMessage = "Password need to have at least one uppercase, at least one digit, at least one lowercase, at least one symbol, min 8 characters total"
        let alert = UIAlertController(title: "Wrong Password", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
}
