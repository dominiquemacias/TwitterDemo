//
//  User.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/27/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var idString: String?
    var idNumber: Int?
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: String?
    var followersCount: Int?
    var followingCount: Int?
    var tweetsCount: Int?
    
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        
        screenname = dictionary["screen_name"] as? String
        
        followersCount = dictionary["followers_count"] as? Int
        
        followingCount = dictionary["friends_count"] as? Int
        
        tweetsCount = dictionary["statuses_count"] as? Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        idString = dictionary["id_str"] as? String
        
        idNumber = dictionary["id"] as? Int
        
        tagline = dictionary["description"] as? String
        
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
        
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
            
            if let userData = userData {
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
                
            } else {
                    defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }

//    static var _anyUser: User?
//    
//    class var anyUser: User? {
//        get {
//            if _anyUser == nil {
//                let defaults = NSUserDefaults.standardUserDefaults()
//                
//                let userData = defaults.objectForKey("anyUserData") as? NSData
//                
//                if let userData = userData {
//                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
//                    _anyUser = User(dictionary: dictionary)
//                }
//            }
//            
//            return _currentUser
//        }
//        set(user) {
//            _anyUser = user
//            
//            let defaults = NSUserDefaults.standardUserDefaults()
//            
//            if let user = user {
//                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
//                defaults.setObject(data, forKey: "anyUserData")
//                
//            } else {
//                defaults.setObject(nil, forKey: "anyUserData")
//            }
//            
//            defaults.synchronize()
//        }
//    }

    
    
}
