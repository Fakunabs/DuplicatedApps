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
    var panGestureRecognizer: UIPanGestureRecognizer?
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    @IBOutlet weak var loginTextFieldView: UIView!
    @IBOutlet weak var createAccountLabel: UILabel!
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    
    @IBAction func didTapShowPasswordAction(_ sender: Any) {
        togglePasswordVisibility()
    }
    
    
    @IBAction func didTapSignInAction(_ sender: Any) {
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
            
            let newViewController = NewViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFieldBackgroud()
        configCreateAccountText()
        registerForKeyboardNotifications()
        setUpTextField(passwordLoginTextField, isSecureTextEntry: true)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        // Đảm bảo màn hình B luôn nằm trên màn hình A
        self.view.window?.windowLevel = .normal
        
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


extension LoginViewController {
    
    private func configTextFieldBackgroud() {
        loginTextFieldView.layer.cornerRadius = 50
        loginTextFieldView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
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
    
    private func togglePasswordVisibility() {
        isPasswordHidden.toggle()
        passwordLoginTextField.isSecureTextEntry = isPasswordHidden
    }
    
    private func setUpTextField(_ textField: UITextField, isSecureTextEntry: Bool) {
        textField.delegate = self
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: self.view.window)
        
        switch gesture.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            let xOffset = touchPoint.x - initialTouchPoint.x
            if xOffset > 0 {
                self.view.frame.origin.x = xOffset
            }
        case .ended:
            let xOffset = touchPoint.x - initialTouchPoint.x
            if xOffset >= 100 {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.x = 0
                }
            }
        default:
            break
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
