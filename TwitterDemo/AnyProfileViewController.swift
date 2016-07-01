//
//  AnyProfileViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/29/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class AnyProfileViewController: UIViewController {


    
    var tweet: Tweet!
    
    var user: User! {
        didSet {
            self.anyProfileUsername.text = user.name! as String
            
            self.anyProfileScreenname.text = ("@\(user.screenname!)") as String
            
            let tweetsCount = user.tweetsCount!
            let tweetCount = String(tweetsCount)
            self.anyProfileTweetsCount.text = tweetCount + " TWEETS"
            
            let followersCount = user.followersCount!
            let followerCount = String(followersCount)
            self.anyProfileFollowersCount.text = followerCount + " FOLLOWERS"
            
            let followingsCount = user.followingCount!
            let followingCount = String(followingsCount)
            self.anyProfileFollowingCount.text = followingCount + " FOLLOWING"
            
            self.anyProfileDescription.text = user.tagline! as String
            
            
            let profileUrlString = String(user.profileUrl!)
            
            let modifiedProfileUrlString = profileUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "")
            
            let imageUrl = NSURL(string: modifiedProfileUrlString)
            self.anyProfilePic.setImageWithURL(imageUrl!)
            
//            self.anyProfilePic.setImageWithURL(user.profileUrl!)
        }
    }
    
    @IBOutlet weak var anyProfilePic: UIImageView!
    
    @IBOutlet weak var anyProfileUsername: UILabel!
    
    @IBOutlet weak var anyProfileScreenname: UILabel!
    
    @IBOutlet weak var anyProfileTweetsCount: UILabel!
    
    @IBOutlet weak var anyProfileFollowersCount: UILabel!
    
    @IBOutlet weak var anyProfileFollowingCount: UILabel!

    @IBOutlet weak var anyProfileDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.anyAccount(tweet.screenname, success: { (
            user: User) -> () in
            self.user = user
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        } )
    
        // Do any additional setup after loading the view.
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
