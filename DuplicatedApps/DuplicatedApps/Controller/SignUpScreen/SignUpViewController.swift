//
//  SignUpViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 04/10/2023.
//

import UIKit

enum PasswordStrength {
    case empty
    case weak
    case medium
    case strong

    var colors: (UIColor, UIColor, UIColor) {
        switch self {
        case .empty:
            return (AppColors.gray, AppColors.gray, AppColors.gray)
        case .weak:
            return (AppColors.vermilion, AppColors.gray, AppColors.gray)
        case .medium:
            return (AppColors.brown, AppColors.oliveGreen, AppColors.gray)
        case .strong:
            return (AppColors.japaneseLaurel, AppColors.green, AppColors.harlequin)
        }
    }
}

class SignUpViewController: BaseViewController {
    
    private var passwordStrength: PasswordStrength = .empty
    private var isPasswordHidden = true
    private var isPasswordStrengthViewsHidden = true
    
    @IBOutlet private weak var signUpBackgroundView: UIView!
    @IBOutlet private weak var emailSignUpTextField: UITextField!
    @IBOutlet private weak var usernameSignUpTextField: UITextField!
    @IBOutlet private weak var passwordSignUpTextField: UITextField!
    @IBOutlet private weak var passwordSignalWeakView: UIView!
    @IBOutlet private weak var passwordSignalMediumView: UIView!
    @IBOutlet private weak var passwordSignalStrongView: UIView!
    @IBOutlet private weak var passwordAlertLabel: UILabel!
    @IBOutlet private weak var showHidePasswordImageView: UIImageView!
    
    @IBAction private func didTapShowPasswordAction(_ sender: Any) {
        togglePasswordVisibility()
    }
    
    @IBAction private func didTapSignUpAction(_ sender: Any) {
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
        configStrengthPasswordView()
        setUpTextField(emailSignUpTextField, isSecureTextEntry: false, placeholder: "yourname@gmail.com")
        setUpTextField(usernameSignUpTextField, isSecureTextEntry: false, placeholder: "@yourname")
        setUpTextField(passwordSignUpTextField, isSecureTextEntry: true, placeholder: "••••••••")
        updatePasswordStrengthViewsAndIconVisibility(isHidden: true)
    }

}

extension SignUpViewController {
    private func configSignUpBackgroundView() {
        signUpBackgroundView.layer.cornerRadius = 50
    }
    
    private func togglePasswordVisibility() {
        isPasswordHidden.toggle()
        passwordSignUpTextField.isSecureTextEntry = isPasswordHidden
        updatePasswordStrengthViewsAndIconVisibility(isHidden: isPasswordStrengthViewsHidden)
    }
    
    private func setUpTextField(_ textField: UITextField, isSecureTextEntry: Bool, placeholder: String) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontPoppinsRegular(size: 14)!,
            .foregroundColor: AppColors.silverChalice
        ]
        textField.delegate = self
        textField.isSecureTextEntry = isSecureTextEntry
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
    }
    
    private func configStrengthPasswordView() {
        passwordSignalWeakView.layer.cornerRadius = 1
        passwordSignalMediumView.layer.cornerRadius = 1
        passwordSignalStrongView.layer.cornerRadius = 1
    }
}

extension SignUpViewController {
    private func updatePasswordStrengthUI() {
        let (weakColor, mediumColor, strongColor) = passwordStrength.colors
        passwordSignalWeakView.backgroundColor = weakColor
        passwordSignalMediumView.backgroundColor = mediumColor
        passwordSignalStrongView.backgroundColor = strongColor
    }
    
    private func updatePasswordAlertLabel() {
        switch passwordStrength {
        case .empty:
            passwordAlertLabel.text = ""
            passwordAlertLabel.textColor = AppColors.gray
        case .weak:
            passwordAlertLabel.text = "weak"
            passwordAlertLabel.textColor = AppColors.vermilion
        case .medium:
            passwordAlertLabel.text = "medium"
            passwordAlertLabel.textColor = AppColors.oliveGreen
        case .strong:
            passwordAlertLabel.text = "strong"
            passwordAlertLabel.textColor = AppColors.harlequin
        }
    }
}

extension SignUpViewController {
    private func updatePasswordStrengthViewsAndIconVisibility(isHidden: Bool) {
        isPasswordStrengthViewsHidden = isHidden
        passwordSignalWeakView.isHidden = isHidden
        passwordSignalMediumView.isHidden = isHidden
        passwordSignalStrongView.isHidden = isHidden
        passwordAlertLabel.isHidden = isHidden
        showHidePasswordImageView.isHidden = !isHidden
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordSignUpTextField {
            guard let text = textField.text as NSString? else { return true }
            let newText = text.replacingCharacters(in: range, with: string)
            if newText.isEmpty {
                passwordStrength = .empty
                updatePasswordStrengthViewsAndIconVisibility(isHidden: true)
            } else {
                updatePasswordStrengthViewsAndIconVisibility(isHidden: false)
                if Validator.isPasswordValid(for: newText) {
                    passwordStrength = .strong
                } else if newText.count >= 6 {
                    passwordStrength = .medium
                } else {
                    passwordStrength = .weak
                }
                updatePasswordAlertLabel()
                updatePasswordStrengthUI()

            }
        }

        return true
    }
}

