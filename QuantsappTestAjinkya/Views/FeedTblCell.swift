//
//  FeedTblCell.swift
//  QuantsappTestAjinkya
//
//  Created by apple on 04/10/20.
//

import UIKit
import Kingfisher

class FeedTblCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedNameLbl: UILabel!
    @IBOutlet weak var feedTimeLbl: UILabel!
    @IBOutlet weak var feedDescriptionLbl: UILabel!
    @IBOutlet weak var feedProfileImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureFeedCell(feedDetails: FeedDetails) {
        feedNameLbl.text = feedDetails.name
        let feedDate = Date(timeIntervalSince1970: TimeInterval(Double(feedDetails.timeStamp)!)/1000)
        feedTimeLbl.text = getRelativeTimeDifferenceFor(date: feedDate)
        feedDescriptionLbl.text = feedDetails.status
        
        
        if let feedProfileImageUrl = URL(string: feedDetails.profilePic) {
            feedProfileImageView.kf.indicatorType = .activity
            feedProfileImageView.kf.setImage(with: feedProfileImageUrl, placeholder: AppImageAssets.NO_PREVIEW_IMAGE)
        }
        
        if let feedImage = feedDetails.image {
            feedImageView.kf.indicatorType = .activity
            
            if let feedImageUrl = URL(string: feedImage) {
                feedImageView.kf.indicatorType = .activity
                feedImageView.kf.setImage(with: feedImageUrl, placeholder: AppImageAssets.NO_PREVIEW_IMAGE)
            }
        }
        else {
            feedImageView.kf.indicatorType = .activity
            feedImageView.image = AppImageAssets.NO_PREVIEW_IMAGE
        }
        
    }
    
}
