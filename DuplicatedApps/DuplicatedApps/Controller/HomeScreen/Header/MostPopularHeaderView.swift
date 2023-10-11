//
//  MostPopularHeaderView.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 10/10/2023.
//

import UIKit

class MostPopularHeaderView: UIView {
    
    @IBOutlet private var contentView: UIView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        loadnNib()
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        loadnNib()
    }
    
    private func loadnNib() {
        Bundle.main.loadNibNamed(MostPopularHeaderView.className, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
