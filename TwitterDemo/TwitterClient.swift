//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/27/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "HgJjB0dqhyLbJS3P2WGbYDv0w", consumerSecret: "aSB2VmogTIqidjP97ksLbg7BwvYun4x6msyPV4w8SfCTVpUSj5")
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
        
    }

    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
    }
    
    
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func homeTimeline(count: Int, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: ["count": count], progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        homeTimeline(20, success: success, failure: failure)
    }

    
    
    func userTimeline(screenname: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/user_timeline.json", parameters: screenname, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    
    func anyAccount(screenname: String!, success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/users/lookup.json?screen_name=" + String(screenname), parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! [NSDictionary]
            let user = User(dictionary: userDictionary[0])
            success(user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
                
        })
        
    }
    

    func composePost(status: String!, success: (String) -> (), failure: (NSError) -> ())
    {
        let para = ["status": status]
        POST("1.1/statuses/update.json", parameters: para, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("compose url is: 1.1/statuses/update.json?")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
                failure(error)
                
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:
            NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })

    }
    
    
    func retweet(ID: String?, success: (Tweet) -> (), failure :(NSError) -> ()) {
        print("1.1/statuses/retweet/\(ID!).json")
        POST("1.1/statuses/retweet/\(ID!).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
    
//            let tweetDictionary = response as! NSDictionary
//            let tweet = Tweet(dictionary: tweetDictionary)
//            success(tweet)

            
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        }
    }
    
    func favorite(ID: String?, success: (Tweet) -> (), failure :(NSError) -> ()) {
        print("1.1/favorites/create.json?id=\(ID!)")
        POST("1.1/favorites/create.json?id=\(ID!)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
        print("yay, favorited")
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        }
    }

}