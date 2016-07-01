//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/29/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    
    @IBOutlet weak var composedTweetField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func postButtonPressed(sender: AnyObject) {
        let status = composedTweetField.text
        TwitterClient.sharedInstance.composePost(status, success: { (String) -> Void in
            
            }) { (NSError) -> () in
                
        }
        
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
