//
//  MostPopularAppsHeaderView.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 12/10/2023.
//

import UIKit

class MostPopularAppsHeaderView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private var hideAppsTitleView: UIView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        
        Bundle.main.loadNibNamed(MostPopularAppsHeaderView.className, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleView.layer.cornerRadius = 9
        hideAppsTitleView.layer.cornerRadius = 9
    }

}
