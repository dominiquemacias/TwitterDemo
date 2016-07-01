//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Dominique Macias on 6/29/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import MBProgressHUD


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
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        TwitterClient.sharedInstance.composePost(status, success: { (String) -> Void in
//            MBProgressHUD.hideHUDForView(self.view, animated: true)
//            self.tabBarController?.selectedIndex = 0
            }) { (NSError) -> () in
                
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        navigationController?.popToRootViewControllerAnimated(true)
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
