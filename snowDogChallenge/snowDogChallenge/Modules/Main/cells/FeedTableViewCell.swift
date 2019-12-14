//
//  FeedTableViewCell.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell, CellMainFunctions {
    
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(with: Any?) {
        self.selectionStyle = .none
        
        let feed = with as! FeedModel
        repoNameLabel.text = feed.repoName
        descriptionLabel.text = feed.repoDescription
        timeLabel.text = feed.createdAt
        feedTitleLabel.text = "\(feed.actorName ?? "") \(feed.type ?? "") \(feed.repoName ?? "")"
       
        DispatchQueue.main.async {
            if let url = URL(string: feed.actorImageUrl ?? ""), let data = try? Data(contentsOf: url) {
                self.userImageView.image = UIImage(data: data)
            }
        }
        

        
    }
    


}
