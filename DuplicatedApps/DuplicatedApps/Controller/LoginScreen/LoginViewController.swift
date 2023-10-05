//
//  LoginViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 03/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    struct Constant {
        static let createAccount = "or Create Account"
    }
    
    @IBOutlet weak var loginTextFieldView: UIView!
    @IBOutlet weak var createAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFieldBackgroud()
        configCreateAccountText()
    }
}


extension LoginViewController {
    
    private func configTextFieldBackgroud() {
        loginTextFieldView.layer.cornerRadius = 50
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
}
