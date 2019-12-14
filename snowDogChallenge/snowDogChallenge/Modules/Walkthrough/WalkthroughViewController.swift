//
//  WalkthroughViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    @IBOutlet weak var wtCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    private var imageArray: [String] = ["wt_1","wt_2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUIElements(title: nil, viewDelegation: [wtCollectionView])
    }
    
    override func setUIElements(title: String?, viewDelegation: [UIView]?) {
        super.setUIElements(title: title, viewDelegation: viewDelegation)
        
        pageController.numberOfPages = imageArray.count
    }
    
    @IBAction func loginAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: showWalkthrough)
        self.dismiss(animated: true, completion: nil)
    }

}
extension WalkthroughViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walkthroughCell", for: indexPath) as! WalkthroughCollectionViewCell
        cell.populateCell(with: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 500)
    }
}

extension WalkthroughViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
}
