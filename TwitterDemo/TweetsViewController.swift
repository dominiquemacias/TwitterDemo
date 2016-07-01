//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/27/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet]!
    let refreshControl = UIRefreshControl()
//    var referenceCell: TweetsCell!
    var isMoreDataLoading = false
    var loadedPostNumber = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tweetsTableView.insertSubview(refreshControl, atIndex: 0)
        
        
        self.fetchPosts()

        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self

        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tweetsTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tweetsTableView.bounds.size.height
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tweetsTableView.dragging) {
                isMoreDataLoading = true
                print("print2")
                // Code to load more results
                loadedPostNumber += 10
                self.fetchPosts()
            }
            
        }
    }

    
    
    func fetchPosts() {
        
        TwitterClient.sharedInstance.homeTimeline(loadedPostNumber, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            self.tweetsTableView.reloadData()
            
            for tweet in tweets {
                print(tweet.text)
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })

        
        self.tweetsTableView.reloadData()
        self.refreshControl.endRefreshing()
        self.isMoreDataLoading = false
        
        }
    

    
    func refreshControlAction(refreshControl: UIRefreshControl) {
//        self.tweetsTableView.reloadData()
//        self.refreshControl.endRefreshing()
        fetchPosts()
        // Tell the refreshControl to stop spinning
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetsCell") as! TweetsCell
        
        let tweet = tweets[indexPath.row]
        
        cell.tweet = tweet
        cell.vc = self

        return cell
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    @IBAction func pressedAnyProfile(sender: AnyObject) {
//        let anyProfileViewController = segue.destinationViewController as! AnyProfileViewController
//        anyProfileViewController.tweet = tweet
      //  performSegueWithIdentifier("anyProfileSegue", sender: UIButton?)
    }
    
    
    @IBAction func tappedComposeButton(sender: AnyObject) {
        performSegueWithIdentifier("composeTweetSegue", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "anyProfileSegue"
        {
            let tweet = sender as! Tweet
            let anyProfileViewController = segue.destinationViewController as! AnyProfileViewController
            anyProfileViewController.tweet = tweet
        }
        
        else if segue.identifier == "homeViewSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPathForCell(cell)
            let tweet = tweets[indexPath!.row]
            
            let homeDetailViewController = segue.destinationViewController as! HomeDetailViewController
            homeDetailViewController.tweet = tweet
        }
        
    }
    

}
