//
//  SignUpViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 04/10/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpBackgroundView: UIView!
    
    
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
