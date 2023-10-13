//
//  AllSppsCollectionViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 13/10/2023.
//

import UIKit

class AllAppsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var appIconImage: UIImageView!
    @IBOutlet private var jobPostionLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var mailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
    }
    
    func setUpCell(allApps: AllApps) {
        appIconImage.image = allApps.appImage
        jobPostionLabel.text = allApps.position
        locationLabel.text = allApps.location
        mailLabel.text = allApps.mailContact
    }
}
