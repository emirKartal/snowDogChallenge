//
//  WalkthroughCollectionViewCell.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class WalkthroughCollectionViewCell: UICollectionViewCell, CollectionCellMainFunctions {

    @IBOutlet weak var contentImageView: UIImageView!
    
    func populateCell(with: Any?) {
        contentImageView.image = UIImage(named: with as! String)
    }
    
}
