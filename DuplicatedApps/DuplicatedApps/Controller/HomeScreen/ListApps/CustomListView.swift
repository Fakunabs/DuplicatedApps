//
//  CustomListView.swift
//  DuplicatedApps
//
//  Created by vuong on 20/10/2023.
//

import UIKit

protocol CustomListViewDelegate: AnyObject {
    func didTapCloseListView()
}


class CustomListView: UIView {

    weak var delegate: CustomListViewDelegate?

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var listAppsTableView: UITableView!
    @IBOutlet private weak var appDescriptionView: AppDescriptionView!
    
    @IBAction func didTapCloseListViewAction(_ sender: Any) {
        delegate?.didTapCloseListView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupListAppView()
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setupListAppView()
        configTableView()
        configListAppsView()
        configAppDesriptionView()
    }

    private func setupListAppView(){
        Bundle.main.loadNibNamed(CustomListView.className, owner: self , options: nil)
        addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
    }
}
extension CustomListView {
    
    private func configTableView() {
        listAppsTableView.delegate = self
        listAppsTableView.dataSource = self
        listAppsTableView.separatorStyle = .none
        listAppsTableView.register(UINib(nibName: ListAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: ListAppsTableViewCell.className)
        
    }
    
    private func configListAppsView() {
        containerView.layer.cornerRadius = 10
    }
    
    private func configAppDesriptionView() {
        appDescriptionView.isHidden = true
    }
}



extension CustomListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listAppsCell = tableView.dequeueReusableCell(withIdentifier: ListAppsTableViewCell.className, for: indexPath) as? ListAppsTableViewCell else { return UITableViewCell()}
        return listAppsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("a")
        appDescriptionView.isHidden = false
    }
}
