//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/28/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var user: User! {
        didSet {
            self.userUsername.text = user.name! as String
            
            self.userScreenname.text = ("@\(user.screenname!)") as String
            
            let tweetsCount = user.tweetsCount!
            let tweetCount = String(tweetsCount)
            self.userTweetCount.text = tweetCount + " TWEETS"
            
            let followersCount = user.followersCount!
            let followerCount = String(followersCount)
            self.userFollowerCount.text = followerCount + " FOLLOWERS"
            
            let followingsCount = user.followingCount!
            let followingCount = String(followingsCount)
            self.userFollowingCount.text = followingCount + " FOLLOWING"
            
            self.userDescription.text = user.tagline! as String
            
            
            let profileUrlString = String(user.profileUrl!)
            let modifiedProfileUrlString = profileUrlString.stringByReplacingOccurrencesOfString("_normal", withString: "")
            
            let imageUrl = NSURL(string: modifiedProfileUrlString)
            self.userProfilePic.setImageWithURL(imageUrl!)
            
//            self.userProfilePic.setImageWithURL(user.profileUrl!)

        }
    }
    
    
    @IBOutlet weak var userProfilePic: UIImageView!
    
    @IBOutlet weak var userUsername: UILabel!
    
    @IBOutlet weak var userScreenname: UILabel!
    
    @IBOutlet weak var userTweetCount: UILabel!
    
    @IBOutlet weak var userFollowerCount: UILabel!
    
    @IBOutlet weak var userFollowingCount: UILabel!
    
    @IBOutlet weak var userDescription: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.user = user
            print("CURRENT USER IS \(user.name)")
            print("CURRENT USER SCREENNAME is @\(user.screenname!)")
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        } )
        
        
       
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
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
