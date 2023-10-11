//
//  HomeViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 09/10/2023.
//

import UIKit

enum HomeSectionType: CaseIterable {
    case mostpopularapps
    case allapps
    
}

class HomeViewController: UIViewController {
    
    private var headerHeight: CGFloat = 25
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
    
    private func configTableView() {
        homeTableView.separatorStyle = .none
        homeTableView.backgroundColor = .clear
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(UINib(nibName: MostPopularHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: MostPopularHeaderView.className)
        homeTableView.register(UINib(nibName: AllAppsHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: AllAppsHeaderView.className)    }
}


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSectionType.allCases[section] {
        case .mostpopularapps:
            return 1
        case .allapps:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSectionType.allCases[section] {
        case .allapps:
            let headerView = MostPopularHeaderView()
            return headerView
        case .mostpopularapps:
            let headerView = AllAppsHeaderView()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch HomeSectionType.allCases[indexPath.section] {
        case .mostpopularapps, .allapps :
            break
        }
    }
}
