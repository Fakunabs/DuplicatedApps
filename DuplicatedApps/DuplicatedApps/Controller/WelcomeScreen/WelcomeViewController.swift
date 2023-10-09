//
//  WelcomeViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 02/10/2023.
//

import UIKit

class WelcomeViewController: BaseViewController {

    struct Constants {
        static let collectionViewRatio: CGFloat = 622 / 414
        static let itemSpacing: CGFloat = 5
    }
    
    private var homeScreenItemSlide : [Slide] = []
    private var currentPage : Int = 0
    private var autoScrollTimer: Timer?

    @IBOutlet private weak var homeScreenSlideCollectionView: UICollectionView!
    @IBOutlet private weak var slidePageControl: UIPageControl!
    
    
    @IBAction private func didTapGetStartedButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        setUpPageControl()
        startAutoScroll()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }
}

// MARK: - Setup Page Control
extension WelcomeViewController : UIScrollViewDelegate {
    private func setUpPageControl() {
        slidePageControl.currentPage = 0
        slidePageControl.numberOfPages = 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getIndexFromItemPosition()
        slidePageControl.currentPage = currentPage
    }
}

// MARK: - Setup Collection View 
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
    
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScrollToNextPage), userInfo: nil, repeats: true)
    }

    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    @objc private func autoScrollToNextPage() {
        let nextPage = currentPage + 1
        if nextPage < slidePageControl.numberOfPages {
            let indexPath = IndexPath(item: nextPage, section: 0)
            homeScreenSlideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentPage = nextPage
            slidePageControl.currentPage = currentPage
        } else {
            let indexPath = IndexPath(item: 0, section: 0)
            homeScreenSlideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentPage = 0
            slidePageControl.currentPage = currentPage
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
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
