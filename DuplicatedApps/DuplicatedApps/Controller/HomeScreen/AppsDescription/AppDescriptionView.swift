//
//  AppDescriptionView.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 25/10/2023.
//

import UIKit

protocol AppDescriptionViewDelegate: AnyObject {
    func didTapCloseAppDescriptionView()
}

class AppDescriptionView: UIView {
    
    weak var delegate: AppDescriptionViewDelegate?

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var appIconImage: UIImageView!
    @IBOutlet private weak var appNameLabel: UILabel!

    @IBAction func didTapCloseAppDesriptionView(_ sender: Any) {
        delegate?.didTapCloseAppDescriptionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAppDescriptionView()
        configAppDescriptionView()
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        setUpAppDescriptionView()
        configAppDescriptionView()
        configTextField()

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
    
    private func configTextField() {
        descriptionTextField.layer.cornerRadius = 20
    }
    
    func update(with app: ListApps?) {
        if let app = app {
            appIconImage.image = app.appicon
            appNameLabel.text = app.name
        }
    }
}
