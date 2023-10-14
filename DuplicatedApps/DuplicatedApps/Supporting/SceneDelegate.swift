//
//  SceneDelegate.swift
//  DuplicatedApps
//
//  Created by vuong on 27/09/2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Published var userSession: FirebaseAuth.User?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setUpWindow(with: scene)
        self.checkAuthentication()
    }
    
    private func setUpWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let mainController = WelcomeViewController(nibName: WelcomeViewController.className, bundle: nil)
        let navigation = UINavigationController(rootViewController: mainController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        
        self.userSession =  Auth.auth().currentUser
        if userSession != nil {
            goToController(with: WelcomeViewController())
        } else {
            goToController(with: WelcomeViewController())
        }
        
        func goToController(with viewController: UIViewController) {
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 0
                    
                } completion: { [weak self] _ in
                    
                    let nav = UINavigationController(rootViewController: viewController)
                    nav.modalPresentationStyle = .fullScreen
                    self?.window?.rootViewController = nav
                    
                    UIView.animate(withDuration: 0.25) { [weak self] in
                        self?.window?.layer.opacity = 1
                    }
                }
            }
        }
    }
}

