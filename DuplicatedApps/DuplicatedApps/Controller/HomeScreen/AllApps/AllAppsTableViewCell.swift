//
//  AllAppsTableViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 13/10/2023.
//

import UIKit

class AllAppsTableViewCell: UITableViewCell {

    struct Constants {
        static let collectionViewCellRatio: CGFloat = 127/155
    }
    
    var appsCollections: [AllApps] = [
        AllApps(appImage: AppImages.googleIcon, position: "FE Developer", location: "Google - Jakarta, ID", mailContact: "mail@mail.com"),
        AllApps(appImage: AppImages.facebookLiteIcon, position: "Finance", location: "Facebook - Jakarta, ID", mailContact: "Acc1"),
        AllApps(appImage: AppImages.graphicDesignerIcon, position: "Graphic Designer", location: "Bukalapak - Jakarta, ID", mailContact: "graphics"),
        AllApps(appImage: AppImages.uxIcon, position: "UX Writter", location: "Gojek - Jakarta, ID", mailContact: "my writter app"),
        AllApps(appImage: AppImages.appleIcon, position: "Mobile Developer", location: "Apple - California, USA", mailContact: "apple@icloud.com"),
        AllApps(appImage: AppImages.twitterIcon, position: "BE Developer", location: "Twitter - Seatle, USA", mailContact: "twitter@mail.com"),
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
}

// MARK: - Collection View Data Source and Delegate
extension AllAppsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let allAppsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAppsCollectionViewCell.className, for: indexPath) as? AllAppsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        allAppsCell.setUpCell(allApps: appsCollections[indexPath.row])
        return allAppsCell
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
