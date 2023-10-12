//
//  MostPopularAppsTableViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 10/10/2023.
//

import UIKit

class MostPopularAppsTableViewCell: UITableViewCell {

    struct Constants {
        static let collectionViewRatio: CGFloat = 101/414
        static let collectionViewMinLineSpacing: CGFloat = 11
        static let collectionViewMinInteritemSpacing: CGFloat = 12
        static let imageBottomPadding: CGFloat = 48
        static var collectionViewEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 27)
    }
    
    


    @IBOutlet var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    
}


extension MostPopularAppsTableViewCell {
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewHeightConstraint.constant = CGFloat(UIScreen.main.bounds.width * Constants.collectionViewRatio)
        collectionView.register(UINib(nibName: MostPopularAppsCollectionViewCell.className, bundle: nil),
                                        forCellWithReuseIdentifier: MostPopularAppsCollectionViewCell.className)
    }
    
    func reloadCollectionCellData() {
        collectionView.reloadData()
    }
}

extension MostPopularAppsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mostPopularAppsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularAppsCollectionViewCell.className, for: indexPath) as? MostPopularAppsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        return mostPopularAppsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.collectionViewEdgeInsets
    }

}
