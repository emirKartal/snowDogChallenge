//
//  HomeFeedViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit



class HomeFeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var feedArray: [FeedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIElements(title: "Feeds", viewDelegation: [feedTableView])
        
    }
    
    override func setUIElements(title: String?, viewDelegation: [UIView]?) {
        super.setUIElements(title: title, viewDelegation: viewDelegation)
        getFeedData()
    }
    
    private func getFeedData() {
        FeedApiController.getFeeds { [weak self](result) in
            switch result {
            case .success(let data):
                self?.feedArray = data ?? []
                self?.feedTableView.reloadData()
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private func getRepoDetail(endPoint: String) {

    }
}
extension HomeFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        let feed = feedArray[indexPath.row]
        cell.populateCell(with: feed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = feedArray[indexPath.row].repoUrl ?? ""
        
        //MARK: I used this function here in order to show ( _ = myVC.view )
        
        FeedApiController.getRepoDetail(endPoint: url) { (result) in
            switch result {
            case .success(let data):
                let detailVC: RepoDetailViewController = UIStoryboard(storyboard: .main).create()
                _ = detailVC.view  //<-------- trigger next viewcontroller life cycle
                
                self.navigationController?.pushViewController(detailVC, animated: true)
                break
            case .failure(let error):
                break
            }
        }
        
        // ---------------------------------------------------------------
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
