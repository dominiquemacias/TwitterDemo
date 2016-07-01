//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/27/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import PrettyTimestamp

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var username: String?
    var screenname: String?
    var profileImageUrl: String?
    var time: String?
    var favorited: Bool?
    var retweeted: Bool?
    var idNumber: String?
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        time = timestamp?.prettyTimestampSinceNow()
        
        let user = dictionary["user"] as? NSDictionary
        username = user!["name"] as? String
        screenname = user!["screen_name"] as? String
        
        profileImageUrl = user!["profile_image_url"] as? String
        
        favorited = dictionary["favorited"] as? Bool
        
        retweeted = dictionary["retweeted"] as? Bool
        
        idNumber = dictionary["id_str"] as? String
        
    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
        
        
        return tweets
    }
    
    
    
}
