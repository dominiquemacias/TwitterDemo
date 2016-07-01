//
//  HomeDetailViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/28/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController {

    
    
    var tweet: Tweet!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetsNumber: UILabel!
    
    @IBOutlet weak var favoritesNumber: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameLabel.text = tweet.username
        
        self.screennameLabel.text = ("@") + tweet.screenname!
        
        self.tweetText.text = tweet.text
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        let time = formatter.stringFromDate(tweet.timestamp!)
        self.timestampLabel.text = time as String
        
        let RTNumber = String(tweet.retweetCount)
        self.retweetsNumber.text = "\(RTNumber) RETWEETS"
        
        let faveNumber = String(tweet.favoritesCount)
        self.favoritesNumber.text = "\(faveNumber) LIKES"
    
        
        let profileUrlString = tweet.profileImageUrl!
        
        let modifiedProfileUrlString = profileUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "")
        
        let imageUrl = NSURL(string: modifiedProfileUrlString)
        self.profileImage.setImageWithURL(imageUrl!)
        
//        
//        let imageUrl = NSURL(string: tweet.profileImageUrl!)
//        
//        self.profileImage.setImageWithURL(imageUrl!)
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func didRetweet(sender: AnyObject) {
        print("retweet")
        
        TwitterClient.sharedInstance.retweet( tweet.idNumber,
                                              success: { (tweet: Tweet) -> () in
                                                
            }, failure: {(error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
                
        })
        let rtNumber = String(tweet.retweetCount + 1)
        retweetsNumber.text = "\(rtNumber) RETWEETS"
    }
    
    
    @IBAction func didFavorite(sender: AnyObject) {
        print("favorite")
        
        TwitterClient.sharedInstance.favorite(tweet.idNumber, success: { (tweet: Tweet) -> () in
            
            }, failure: {(error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        })
        let favNumber = String(tweet.favoritesCount + 1)
        favoritesNumber.text = "\(favNumber) LIKES"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
