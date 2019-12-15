//
//  SearchTableViewCell.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 15.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, CellMainFunctions {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerImage: CachedImageClass!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(with: Any?) {
        self.selectionStyle = .none
        let item = with as! RepoDetailModel
        repoNameLabel.text = item.fullName
        ownerImage.loadImageFromApi(urlString: item.ownerImage ?? "")
    }

}
