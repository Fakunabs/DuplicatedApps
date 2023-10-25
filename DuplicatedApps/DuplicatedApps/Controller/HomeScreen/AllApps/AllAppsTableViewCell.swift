//
//  AllAppsTableViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 13/10/2023.
//

import UIKit

protocol AllAppsTableViewCellDelegate: AnyObject {
    func showListView()
}

class AllAppsTableViewCell: UITableViewCell {
    
    struct Constants {
        static let collectionViewCellRatio: CGFloat = 127/155
    }
    
    weak var delegate: AllAppsTableViewCellDelegate?
    
    var allAppsCollectionView : [AllApps] = [
        AllApps(appImage: AppImages.homeScreenAddCellIcon, position: "Add your app", location: "Multiple Social", mailContact: "Account Linking"),
    ]
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
}

// MARK: - Config Collection View
extension AllAppsTableViewCell {
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: AllAppsCollectionViewCell.className, bundle: nil),
                                forCellWithReuseIdentifier: AllAppsCollectionViewCell.className)
    }
    
    func reloadCollectionCellData() {
        collectionView.reloadData()
    }
}

// MARK: - Collection View Data Source and Delegate
extension AllAppsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAppsCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let allAppsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAppsCollectionViewCell.className, for: indexPath) as? AllAppsCollectionViewCell else { return UICollectionViewCell() }
        allAppsCell.setUpCell(allApps: allAppsCollectionView[indexPath.row])
        return allAppsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            delegate?.showListView()
        } else {
            print("b")
        }
    }
}

// MARK: - Collection View FLowLayout
extension AllAppsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidthRatio = collectionView.frame.size.width/2 - 10
        let collectionViewHeightRatio = collectionViewWidthRatio * Constants.collectionViewCellRatio
        return CGSize(width: collectionViewWidthRatio , height: collectionViewHeightRatio)
    }
}
