//
//  ListAppsTableViewCell.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 17/10/2023.
//

import UIKit

class ListAppsTableViewCell: UITableViewCell {

    @IBOutlet private weak var appIconImage: UIImageView!
    @IBOutlet private weak var appNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(listApps: ListApps) {
        appIconImage.image = listApps.appicon
        appNameLabel.text = listApps.name
    }
}
