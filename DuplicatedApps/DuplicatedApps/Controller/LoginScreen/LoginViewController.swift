//
//  LoginViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 03/10/2023.
//

import UIKit

class LoginViewController: BaseViewController {
    
    struct Constant {
        static let createAccount = "or Create Account"
    }
    
    private var isPasswordHidden = true
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    
    @IBOutlet private weak var loginTextFieldView: UIView!
    @IBOutlet private weak var createAccountLabel: UILabel!
    
    @IBOutlet private weak var emailLoginTextField: UITextField!
    @IBOutlet private weak var passwordLoginTextField: UITextField!
    @IBOutlet private weak var viewBottomConstraint: NSLayoutConstraint!
    
    
    @IBAction private func didTapShowPasswordAction(_ sender: Any) {
        togglePasswordVisibility()
    }
    
    
    @IBAction private func didTapSignInAction(_ sender: Any) {
        let loginRequest = LoginUserRequest(
            email: self.emailLoginTextField.text ?? "",
            password: self.passwordLoginTextField.text ?? ""
        )
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            let homeViewController = HomeViewController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFieldBackgroud()
        configCreateAccountText()
        registerForKeyboardNotifications()
        setUpTextField(passwordLoginTextField, isSecureTextEntry: true)
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.viewBottomConstraint.constant = 0
        }
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] is NSValue {
            let keyboardHeight = 100
            viewBottomConstraint.constant = CGFloat(keyboardHeight)
        }
    }
}

// MARK: - Setup TextField Background
extension LoginViewController {
    
    private func configTextFieldBackgroud() {
        loginTextFieldView.layer.cornerRadius = 50
        loginTextFieldView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// MARK: - Setup Text Field
extension LoginViewController {
    
    private func setUpTextField(_ textField: UITextField, isSecureTextEntry: Bool) {
        textField.delegate = self
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    private func togglePasswordVisibility() {
        isPasswordHidden.toggle()
        passwordLoginTextField.isSecureTextEntry = isPasswordHidden
    }
}

// MARK: - Handle Create Account Tap
extension LoginViewController {
    private func configCreateAccountText() {
        let createAccountText = Constant.createAccount
        let attributedString = NSMutableAttributedString(string: createAccountText)
        let range = (attributedString.string as NSString).range(of: "Create Account")
        attributedString.addAttributes([ .underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        createAccountLabel.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCreateAccountTap))
        createAccountLabel.isUserInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleCreateAccountTap() {
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

// MARK: - Handle Return Key Tap on Keyboard
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
