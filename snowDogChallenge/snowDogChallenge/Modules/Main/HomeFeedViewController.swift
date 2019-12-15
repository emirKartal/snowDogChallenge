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
    
    private var refreshControl = UIRefreshControl()
    
    //Pagination Variables
    private var currentPage = 0
    private var isLastPage = false
    private var isInProgress = false
    //----------------------
    
    private var feedArray: [FeedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIElements(title: "Feeds", viewDelegation: [feedTableView])
        
    }
    
    override func setUIElements(title: String?, viewDelegation: [UIView]?) {
        super.setUIElements(title: title, viewDelegation: viewDelegation)
        getFeedData(page: currentPage)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        feedTableView.addSubview(refreshControl)
    }
    
    private func getFeedData(page: Int) {
        
        isInProgress = true
        FeedApiController.getFeeds(page: page) { [weak self](result) in
            switch result {
            case .success(let data):
                
                self?.isInProgress = false
                self?.isLastPage = data?.count ?? 0 == 0
                
                if self?.currentPage == 0 {
                    self?.feedArray = data ?? []
                } else {
                    self?.feedArray += data ?? []
                }
                self?.feedTableView.reloadData()
                break
            case .failure(let error):
                break
            }
        }
    }
    
    @objc func refreshTableView() {
        currentPage = 0
        getFeedData(page: currentPage)
        refreshControl.endRefreshing()
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
        
        cell.likeTapped = {
            cell.isStarred = cell.starredButton.isSelected
            cell.starredButton.isSelected = !cell.starredButton.isSelected
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = feedArray[indexPath.row].repoEndPoint ?? ""
        
        //MARK: I used this function here in order to show ( _ = myVC.view )
        
        FeedApiController.getRepoDetail(endPoint: url) { [weak self](result) in
            switch result {
            case .success(let data):
                let detailVC: RepoDetailViewController = UIStoryboard(storyboard: .main).create()
                _ = detailVC.view  //<-------- trigger next viewcontroller life cycle
                let repoDetailData = data
                detailVC.repoNameLabel.text = repoDetailData?.fullName
                self?.navigationController?.pushViewController(detailVC, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height)
        if bottomEdge <= scrollView.frame.size.height && !isLastPage && !isInProgress {
            currentPage += 1
            getFeedData(page: currentPage)
            
        }
    }
    
}
