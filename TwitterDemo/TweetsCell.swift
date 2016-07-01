//
//  TweetsCell.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/28/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsCell: UITableViewCell {

    
    @IBOutlet weak var timestampField: UILabel!
    
    @IBOutlet weak var textField: UILabel!
    
    @IBOutlet weak var retweetsField: UILabel!
    
    @IBOutlet weak var favoritesField: UILabel!
    
    @IBOutlet weak var usernameField: UILabel!
    
    @IBOutlet weak var profilePicField: UIImageView!
    

    var vc: TweetsViewController!
    
    var tweet: Tweet! {
        didSet {
            textField.text = tweet.text
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            //        let time = formatter.stringFromDate(tweet.timestamp!)
            timestampField.text = tweet.time! as String
            let retweets = String(tweet.retweetCount)
            retweetsField.text = retweets
            let favorites = String(tweet.favoritesCount)
            favoritesField.text = favorites
            usernameField.text = tweet.username
            
            
            let profileUrlString = tweet.profileImageUrl!
            
            let modifiedProfileUrlString = profileUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "")
            
            let imageUrl = NSURL(string: modifiedProfileUrlString)
            profilePicField.setImageWithURL(imageUrl!)
            
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        print("retweet")
        TwitterClient.sharedInstance.retweet( tweet.idNumber,
            success: { (tweet: Tweet) -> () in
                
            }, failure: {(error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
                
        })
        print("retweeted")
        print(String(tweet.retweetCount + 1))
        retweetsField.text = String(tweet.retweetCount + 1)

    }
    
    @IBAction func onTapAnyProfile(sender: AnyObject) {
        vc.performSegueWithIdentifier("anyProfileSegue", sender: tweet)
    }
    
    
    
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet.idNumber, success: { (tweet: Tweet) -> () in

            }, failure: {(error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        })
        print(String(tweet.favoritesCount + 1))
        print("favorited")
        favoritesField.text = String(tweet.favoritesCount + 1)
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








