//
//  AppDescriptionView.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 25/10/2023.
//

import UIKit

class AppDescriptionView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAppDescriptionView()
        configAppDescriptionView()
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        setUpAppDescriptionView()
        configAppDescriptionView()

    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

    }
    private func setUpAppDescriptionView() {
        Bundle.main.loadNibNamed("AppDescriptionView", owner: self , options: nil)
        addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
    }
}

extension AppDescriptionView {
    private func configAppDescriptionView() {
        containerView.layer.cornerRadius = 10
    }
}
