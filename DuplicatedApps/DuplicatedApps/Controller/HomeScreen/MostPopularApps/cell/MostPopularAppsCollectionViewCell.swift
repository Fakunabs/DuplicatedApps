//
//  MostPopularAppsCollectionViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 12/10/2023.
//

import UIKit

class MostPopularAppsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var iconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        iconView.layer.cornerRadius = 10
    }

}
