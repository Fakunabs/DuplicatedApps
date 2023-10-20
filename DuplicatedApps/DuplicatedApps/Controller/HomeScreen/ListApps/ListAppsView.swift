//
//  ListAppsViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 17/10/2023.
//

import UIKit

enum ListAppItem: String, CaseIterable {
    case fEDeveloper = "FE Developer"
    case bEDeveloper = "BE Developer"
    case mBDeveloper = "MB Developer"
    case facebook = "Facebook"
}

class ListAppsView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ListAppsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    @IBOutlet private weak var listAppsView: UIView!
    @IBOutlet private weak var listAppsTableView: UITableView!
    
    @IBAction func didTapCloseAction(_ sender: Any) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configTableView()
        configListAppsView()
    }
}

extension ListAppsView {
    
    private func configTableView() {
        listAppsTableView.register(UINib(nibName: ListAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: ListAppsTableViewCell.className)
        listAppsTableView.delegate = self
        listAppsTableView.dataSource = self
        listAppsTableView.backgroundColor = .white
        listAppsTableView.separatorStyle = .none
    }
    
    private func configListAppsView() {
        listAppsView.layer.cornerRadius = 25
    }
}

extension ListAppsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listAppsCell = tableView.dequeueReusableCell(withIdentifier: ListAppsTableViewCell.className, for: indexPath) as? ListAppsTableViewCell else { return UITableViewCell()}
        return listAppsCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
