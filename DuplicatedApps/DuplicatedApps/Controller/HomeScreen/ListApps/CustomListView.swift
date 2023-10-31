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
    var selectedApp: ListApps?
    var listApps: [ListApps] = [
        ListApps(name: "Facebook", link: "www.facebook.com", appicon: AppImages.facebookIcon),
        ListApps(name: "Twitter", link: "www.twitter.com", appicon: AppImages.twitterIcon),
        ListApps(name: "Instagram", link: "www.instagram.com", appicon: AppImages.instagramIcon),
        ListApps(name: "LinkedIn", link: "www.linkedin.com", appicon: AppImages.linkedinIcon),
        ListApps(name: "Snapchat", link: "www.snapchat.com", appicon: AppImages.snapchatIcon),
        ListApps(name: "TikTok", link: "www.tiktok.com", appicon: AppImages.tiktokIcon),
        ListApps(name: "Pinterest", link: "www.pinterest.com", appicon: AppImages.pinterestIcon),
        ListApps(name: "WhatsApp", link: "www.whatsapp.com", appicon: AppImages.whatsappIcon),
        ListApps(name: "Reddit", link: "www.reddit.com", appicon: AppImages.redditIcon),
        ListApps(name: "Tumblr", link: "www.tumblr.com", appicon: AppImages.tumblrIcon),
        ListApps(name: "WeChat (China)", link: "www.wechat.com", appicon: AppImages.wechatIcon),
        ListApps(name: "Sina Weibo (China)", link: "www.sina.com", appicon: AppImages.sinaweiboIcon),
        ListApps(name: "QQ (China)", link: "www.qq.com", appicon: AppImages.qqIcon),
        ListApps(name: "Douyin (TikTok in China)", link: "www.douyin.com", appicon: AppImages.douyinIcon),
        ListApps(name: "Baidu Tieba (China)", link: "www.tieba.com", appicon: AppImages.baiduIcon),
        ListApps(name: "Youku Tudou (China)", link: "www.youku.com", appicon: AppImages.youkuIcon),
        ListApps(name: "Meituan-Dianping (China)", link: "www.meituan.com", appicon: AppImages.meituanIcon),
        ListApps(name: "Zhihu (China)", link: "www.zhihu.com", appicon: AppImages.zhihuIcon),
        ListApps(name: "Meitu (China)", link: "www.meitu.com", appicon: AppImages.meituIcon),
        ListApps(name: "Douban (China)", link: "www.douban.com", appicon: AppImages.doubanIcon),
        ListApps(name: "YouTube", link: "www.youtube.com", appicon: AppImages.youtubeIcon),
        ListApps(name: "Vimeo", link: "www.vimeo.com", appicon: AppImages.vimeoIcon),
        ListApps(name: "Flickr", link: "www.flickr.com", appicon: AppImages.flickrIcon),
        ListApps(name: "Quora", link: "www.quora.com", appicon: AppImages.quoraIcon),
        ListApps(name: "Google+", link: "www.google.com", appicon: AppImages.googlePlusIcon),
        ListApps(name: "Myspace", link: "www.myspace.com", appicon: AppImages.myspaceIcon),
        ListApps(name: "Meetup", link: "www.meetup.com", appicon: AppImages.meetupIcon),
        ListApps(name: "Plurk", link: "www.plurk.com", appicon: AppImages.plurkIcon),
        ListApps(name: "VKontakte (VK)", link: "www.vk.com", appicon: AppImages.vkIcon),
        ListApps(name: "Renren (China)", link: "www.renren.com", appicon: AppImages.renrenIcon),
        ListApps(name: "XING", link: "www.xing.com", appicon: AppImages.xingIcon),
        ListApps(name: "LiveJournal", link: "www.livejournal.com", appicon: AppImages.livejournalIcon)
    ]


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
        appDescriptionView.delegate = self
        appDescriptionView.isHidden = true
        appDescriptionView.layer.cornerRadius = 10
    }
}



extension CustomListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listAppsCell = tableView.dequeueReusableCell(withIdentifier: ListAppsTableViewCell.className, for: indexPath) as? ListAppsTableViewCell else { return UITableViewCell()}
        let listApps = listApps[indexPath.row]
        listAppsCell.setUpData(listApps: listApps)
        return listAppsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedApp = listApps[indexPath.row]
        appDescriptionView.isHidden = false
        appDescriptionView.update(with: selectedApp)
    }
}

extension CustomListView: AppDescriptionViewDelegate {
    func didTapCloseAppDescriptionView() {
        appDescriptionView.isHidden = true
    }
}
