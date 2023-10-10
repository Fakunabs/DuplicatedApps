//
//  TabController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 09/10/2023.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
    }
    
    
    private func setupTabs() {
        let homeViewController = self.createNav(with: AppImages.tabbarItemHome, viewController: HomeViewController())
        let favouriteViewController  = self.createNav(with: AppImages.tabbarItemFavourite, viewController: FavouriteViewController())
        let settingViewController = self.createNav(with: AppImages.tabbarItemSetting, viewController: SettingViewController())
        self.setViewControllers([homeViewController, favouriteViewController, settingViewController], animated: true)
        self.tabBar.tintColor = AppColors.eastBay
        UITabBar.appearance().backgroundColor = .white
        let newTabBarHeight: CGFloat = 80.0
        
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: (newTabBarHeight - tabBar.frame.height) / 2, left: 0, bottom: -((newTabBarHeight - tabBar.frame.height) / 2), right: 0)
        }
        var tabBarFrame = self.tabBar.frame
    }
    
    private func createNav(with image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.image = image
        navigation.navigationController?.isNavigationBarHidden = true
        
        return navigation
    }
}

