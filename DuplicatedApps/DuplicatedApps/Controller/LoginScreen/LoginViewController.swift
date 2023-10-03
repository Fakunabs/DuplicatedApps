//
//  LoginViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 03/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextFieldBackgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFieldBackgroud()
    }
}


extension LoginViewController {
    
    private func configTextFieldBackgroud() {
        loginTextFieldBackgroundImageView.layer.cornerRadius = 50
    }
    
}
