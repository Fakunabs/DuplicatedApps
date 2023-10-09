//
//  BaseViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 06/10/2023.
//

import UIKit
import Foundation

class BaseViewController : UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
}

// MARK : - Navigation Bar
extension BaseViewController {
    private func setUpNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppColors.heliotrope
    }
}

// MARK : - Keyboard Handling
extension BaseViewController {
    func configureTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK : - Keyboard Handling
extension BaseViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


