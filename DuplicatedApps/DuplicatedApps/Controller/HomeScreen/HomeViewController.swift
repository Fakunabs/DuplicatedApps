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
    
    struct Constants {
        static let helloUserText = "Hello, Gustano"
    }
    
    private var headerHeight: CGFloat = 31
    
    @IBOutlet private weak var homeTableView: UITableView!
    @IBOutlet private var welcomeUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configWelcomeText()
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
        homeTableView.register(UINib(nibName: MostPopularAppsHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: MostPopularAppsHeaderView.className)
        homeTableView.register(UINib(nibName: AllAppsHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: AllAppsHeaderView.className)
        homeTableView.register(UINib(nibName: MostPopularAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: MostPopularAppsTableViewCell.className)
    }
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
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSectionType.allCases[indexPath.section]{
        case .mostpopularapps:
            guard let mostPopularAppsCell = homeTableView.dequeueReusableCell(withIdentifier: MostPopularAppsTableViewCell.className, for: indexPath) as? MostPopularAppsTableViewCell
            else {
                return UITableViewCell()
            }
            mostPopularAppsCell.reloadCollectionCellData()
            
            return mostPopularAppsCell
        case .allapps:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSectionType.allCases[section] {
        case .mostpopularapps:
            let headerView = MostPopularAppsHeaderView()
            return headerView
        case .allapps:
            let headerView = AllAppsHeaderView()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch HomeSectionType.allCases[indexPath.section] {
        case .mostpopularapps :
            break
        case .allapps:
            break
        }
    }
}

extension HomeViewController {
    private func configWelcomeText() {
        let welcomeText = Constants.helloUserText
        let attributedString = NSMutableAttributedString(string: welcomeText)
        let range = (attributedString.string as NSString).range(of: "Gustano")
        attributedString.addAttributes([.font: AppFonts.fontInterBoldItalic(size: 17) as Any], range: range)
        welcomeUserLabel.attributedText = attributedString
    }
}
