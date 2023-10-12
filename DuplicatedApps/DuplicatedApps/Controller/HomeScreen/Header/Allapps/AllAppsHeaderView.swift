//
//  AllAppsHeaderView.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 10/10/2023.
//

import UIKit

class AllAppsHeaderView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleView: UIView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        
        Bundle.main.loadNibNamed(AllAppsHeaderView.className, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleView.layer.cornerRadius = 9
    }

}
