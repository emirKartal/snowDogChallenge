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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userImageView: CachedImageClass!
    @IBOutlet weak var starredButton: UIButton!
    
    @IBOutlet weak var tagView: UIView!
    
    var likeTapped: (()->())?
    var isStarred = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView.layer.cornerRadius = 10
        tagView.layer.borderWidth = 1
        tagView.layer.borderColor = UIColor.gray.cgColor
        
    }
    override func prepareForReuse() {
        // I couldnt find in whether repo is starred. So I leave it like that. But if it comes from api I would solve reusable cell problem here.
        starredButton.isSelected = isStarred
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
        timeLabel.text = "Updated at \(feed.createdAt ?? "")"
        feedTitleLabel.text = "\(feed.actorName ?? "") \(feed.type ?? "") \(feed.repoName ?? "")"
        if let imageURL = feed.actorImageUrl {
            userImageView.loadImageFromApi(urlString: imageURL)
        }
       
    }
    
    @IBAction func likeAction(_ sender: Any) {
        likeTapped?()
    }
    

}
