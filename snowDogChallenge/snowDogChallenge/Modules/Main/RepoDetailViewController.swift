//
//  RepoDetailViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var subscriberCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: CachedImageClass!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
    var apiResponse: ((_ isSuccess: Bool)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUIElements(title: "", viewDelegation: nil)
    }
    
    override func setUIElements(title: String?, viewDelegation: [UIView]?) {
        super.setUIElements(title: title, viewDelegation: nil)
    }
    
    func getDetailData(url: String) {
        FeedApiController.getRepoDetail(endPoint: url) { [weak self](result) in
            switch result {
            case .success(let data):
                self?.apiResponse?(true)
                self?.fillLabels(data: data ?? RepoDetailModel())
                break
            case .failure(let error):
                self?.showBanner(title: "Error", subTitle: error.message, style: .danger)
                self?.apiResponse?(false)
                break
            }
        }
    }
    
    func fillLabels(data: RepoDetailModel) {
        repoNameLabel.text = data.name
        issuesCountLabel.text = "\(data.openIssuesCount ?? 0)"
        watchersCountLabel.text = "\(data.watcherCount ?? 0)"
        starsCountLabel.text = "\(data.starCount ?? 0)"
        subscriberCountLabel.text = "\(data.subscriberCount ?? 0)"
        nameLabel.text = data.ownerName
        imageView.loadImageFromApi(urlString: data.ownerImage ?? "")
        let status = data.isPrivate ?? false ? "Private Repo" : "Public Repo"
        createDateLabel.text = "Created on \(data.createdAt ?? "")\n Language: \(data.language ?? "")\n \(status)"
        updateLabel.text = "Last update on \(data.updatedAt ?? "")"
    }

}
