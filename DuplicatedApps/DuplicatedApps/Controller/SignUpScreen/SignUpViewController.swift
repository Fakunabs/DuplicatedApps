//
//  SignUpViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 04/10/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpBackgroundView: UIView!
    
    @IBOutlet weak var emailSignUpTextField: UITextField!
    
    @IBOutlet weak var usernameSignUpTextField: UITextField!
    
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    @IBAction func didTapSignUpAction(_ sender: Any) {
        let registerUserRequest = RegisterUserRequest(
            username: self.usernameSignUpTextField.text ?? "",
            email: self.emailSignUpTextField.text ?? "",
            password: self.passwordSignUpTextField.text ?? ""
        )
        
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        print(registerUserRequest)
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configSignUpBackgroundView()
    }

}

extension SignUpViewController {
    
    private func configSignUpBackgroundView() {
        signUpBackgroundView.layer.cornerRadius = 50
    }
}
