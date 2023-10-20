//
//  CustomListView.swift
//  DuplicatedApps
//
//  Created by vuong on 20/10/2023.
//

import UIKit

class CustomListView: UIView
{

    @IBOutlet var contentView: UIView!
    
    @IBAction func doClose(_ sender: Any) {
    }
    @IBOutlet weak var listView: UITableView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setupView()
    }
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//        fatalError("init(coder:) has not been implemented")
//    }
    private func setupView(){
        Bundle.main.loadNibNamed("CustomListView", owner: self , options: nil)
        addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        listView.register(UINib(nibName: ListAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: ListAppsTableViewCell.className)
//        contentvi
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension CustomListView {
    
    private func configTableView() {
//        bt.frame = CGRect(x: 0, y: 010, width: 10, height: 10)
        listView.register(UINib(nibName: ListAppsTableViewCell.className, bundle: nil), forCellReuseIdentifier: ListAppsTableViewCell.className)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = .white
        listView.separatorStyle = .none
    }
    
    private func configListAppsView() {
        self.layer.cornerRadius = 100
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
        
    }
}
