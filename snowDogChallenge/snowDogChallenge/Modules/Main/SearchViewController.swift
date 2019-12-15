//
//  SearchViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchCountLabel: UILabel!
    @IBOutlet weak var displayCountView: UIView!
    
    private var search: SearchModel?
    private var searchItems: [RepoDetailModel] = []
    //Pagination Variables
    private var currentPage = 0
    private var isLastPage = false
    private var isInProgress = false
    //----------------------
    private var searchText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIElements(title: "Search Repository", viewDelegation: [searchTableView,searchBar])
        
    }
    
    override func setUIElements(title: String?, viewDelegation: [UIView]?) {
        super.setUIElements(title: title, viewDelegation: viewDelegation)
        displayCountView.isHidden = true
        searchBar.barTintColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
    private func search(query: String, page: Int) {
        isInProgress = true
        //Spinner.start(frame: searchTableView.frame)
        SearchApiController.getSearchResult(query: query, page: page) { [weak self](result) in
            switch result {
            case .success(let data):
                //Spinner.stop()
                self?.displayCountView.isHidden = false
                self?.search = data
                self?.searchCountLabel.text = "\(data?.totalCount ?? 0) repository found"
                self?.isInProgress = false
                
                self?.isLastPage = data?.items?.count ?? 0 == 0
                
                if self?.currentPage == 0 {
                    self?.searchItems = data?.items ?? []
                } else {
                    self?.searchItems += data?.items ?? []
                }
                self?.searchTableView.reloadData()
                break
            case .failure(let error):
                self?.isInProgress = false
                //Spinner.stop()
                break
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newModerators: [RepoDetailModel]) -> [IndexPath] {
        let startIndex = searchItems.count - newModerators.count
        let endIndex = startIndex + newModerators.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.populateCell(with: searchItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height)
        if bottomEdge <= scrollView.frame.size.height && !isLastPage && !isInProgress {
            currentPage += 1
            search(query: searchText, page: currentPage)
            
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 3 {
            search(query: searchText, page: 0)
        } else {
            searchItems.removeAll()
            searchCountLabel.text = ""
            displayCountView.isHidden = true
            searchTableView.reloadData()
        }
        self.searchText = searchText
    }
}
