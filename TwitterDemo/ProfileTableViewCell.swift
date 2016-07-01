//
//  ProfileTableViewCell.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 7/1/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userProfilePic: UIImageView!
    
    @IBOutlet weak var userUsername: UILabel!
    
    @IBOutlet weak var userTimestamp: UILabel!
    
    @IBOutlet weak var userTweetText: UILabel!
    
    @IBOutlet weak var userRetweetCount: UILabel!
    
    @IBOutlet weak var userFavoriteCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            userTweetText.text = tweet.text
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            //        let time = formatter.stringFromDate(tweet.timestamp!)
            userTimestamp.text = tweet.time! as String
            let retweets = String(tweet.retweetCount)
            userRetweetCount.text = retweets
            let favorites = String(tweet.favoritesCount)
            userFavoriteCount.text = favorites
            userUsername.text = tweet.username
            
            
            let profileUrlString = tweet.profileImageUrl!
            
            let modifiedProfileUrlString = profileUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "")
            
            let imageUrl = NSURL(string: modifiedProfileUrlString)
            userProfilePic.setImageWithURL(imageUrl!)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
