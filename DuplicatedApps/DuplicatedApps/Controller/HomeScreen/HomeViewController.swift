//
//  HomeViewController.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 09/10/2023.
//

import UIKit

// MARK: - Heading of Home Table View
enum HomeSectionType: CaseIterable {
    case mostpopularapps
    case allapps
}

protocol HomeViewControllerDelegate: AnyObject {
    func presentToViewController(viewController: UIViewController)
}

class HomeViewController: UIViewController {
    
    struct Constants {
        static let helloUserText = "Hello, Gustano"
    }
    
//    let listView = ListAppsView.instanceFromNib()
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var headerHeight: CGFloat = 31
    
    @IBOutlet weak var listView: CustomListView!
    @IBOutlet private weak var homeTableView: UITableView!
    @IBOutlet private weak var welcomeUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configWelcomeText()
        addSubView()
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func configTableView() {
        homeTableView.separatorStyle = .none
        homeTableView.backgroundColor = .clear
        // MARK: - Register Home Table View
        homeTableView.dataSource = self
        homeTableView.delegate = self
        // MARK: - Register Heading View
        homeTableView.register(UINib(nibName: MostPopularAppsHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: MostPopularAppsHeaderView.className)
        homeTableView.register(UINib(nibName: AllAppsHeaderView.className, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: AllAppsHeaderView.className)
        // MARK: - Register Table View Cell
        homeTableView.register(UINib(nibName: MostPopularAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: MostPopularAppsTableViewCell.className)
        homeTableView.register(UINib(nibName: AllAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: AllAppsTableViewCell.className)
    }
}

// MARK: - Table View Data Source
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSectionType.allCases[section] {
        case .mostpopularapps:
            return 1
        case .allapps:
            return 1
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
            guard let allAppsCell = homeTableView.dequeueReusableCell(withIdentifier: AllAppsTableViewCell.className, for: indexPath) as? AllAppsTableViewCell
            else {
                return UITableViewCell()
            }
            allAppsCell.delegate = self
            allAppsCell.reloadCollectionCellData()
            return allAppsCell
        }
    }
}
// MARK: - Table View Delegate
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

// MARK: - ConfigWelcomeText
extension HomeViewController {
    private func configWelcomeText() {
        let welcomeText = Constants.helloUserText
        let attributedString = NSMutableAttributedString(string: welcomeText)
        let range = (attributedString.string as NSString).range(of: "Gustano")
        attributedString.addAttributes([.font: AppFonts.fontInterBoldItalic(size: 17) as Any], range: range)
        welcomeUserLabel.attributedText = attributedString
    }
    
    private func addSubView() {
//        self.listView.isHidden = true
//        self.view.addSubview(self.listView)
    }
}

extension HomeViewController: AllAppsTableViewCellDelegate {
    func showListView() {
//        self.listView.isHidden = false
    }
}
