//
//  WelcomeViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 02/10/2023.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    struct Constants {
        static let collectionViewRatio: CGFloat = 622 / 414
        static let itemSpacing: CGFloat = 5
    }
    
    var homeScreenItemSlide : [Slide] = []
    var currentPage : Int = 0
    
    
    @IBOutlet weak var homeScreenSlideCollectionView: UICollectionView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    
    @IBAction func didTapGetStartedButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configCollectionView()
        setUpPageControll()
    }
}


extension WelcomeViewController {
    private func setUpPageControll() {
        slidePageControl.currentPage = 0
        slidePageControl.numberOfPages = 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getIndexFromItemPosition()
        slidePageControl.currentPage = currentPage
    }
}

extension WelcomeViewController {
    private func configCollectionView() {
        homeScreenSlideCollectionView.register(UINib(nibName: WelcomeScreenSlideCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: WelcomeScreenSlideCollectionViewCell.className)
        homeScreenSlideCollectionView.delegate = self
        homeScreenSlideCollectionView.dataSource = self
    }
    
    private func getIndexFromItemPosition() -> Int {
        let itemWidth = homeScreenSlideCollectionView.bounds.width - Constants.itemSpacing * 2
        let proportionalOffset = homeScreenSlideCollectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        return index
    }
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidePageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let homeScreenCell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeScreenSlideCollectionViewCell.className, for: indexPath) as? WelcomeScreenSlideCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        return homeScreenCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        slidePageControl.currentPage = indexPath.row
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WelcomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = homeScreenSlideCollectionView.bounds.width - Constants.itemSpacing * 2
        return CGSize(width: width, height: homeScreenSlideCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constants.itemSpacing, bottom: 0, right: Constants.itemSpacing)
    }
}
