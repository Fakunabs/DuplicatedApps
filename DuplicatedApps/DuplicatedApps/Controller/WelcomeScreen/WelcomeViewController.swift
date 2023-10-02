//
//  WelcomeViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 02/10/2023.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    var homeScreenItemSlide : [Slide] = []
 
    @IBOutlet weak var homeScreenSlideCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configCollectionView()
    }
}


extension WelcomeViewController {
    private func configCollectionView() {
        homeScreenSlideCollectionView.register(UINib(nibName: WelcomeScreenSlideCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: WelcomeScreenSlideCollectionViewCell.className)
        homeScreenSlideCollectionView.delegate = self
        homeScreenSlideCollectionView.dataSource = self
    }
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let homeScreenCell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeScreenSlideCollectionViewCell.className, for: indexPath) as? WelcomeScreenSlideCollectionViewCell
        else {
            return UICollectionViewCell()
        }
//        categoryCell.setUpCell(category: listCategories[indexPath.row])
        return homeScreenCell
    }
    
    
}
