//
//  MainGameViewController.swift
//  Real Friends?
//
//  Created by Tom Woudenberg on 2015-09-18.
//  Copyright © 2015 Smileydude. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MainGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestParameters = ["fields": "id, email, first_name, last_name"]
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if(error != nil)
            {
                print("\(error.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                
                let userId:String? = result["id"] as? String
                self.firstName.text = (result["first_name"] as? String)!
                self.lastName.text = (result["last_name"] as? String)!
                //self.userEmail = (result["email"] as? String)!
                
                self.profilePic.profileID = userId
                self.profilePic.setNeedsImageUpdate()
                
            }
            
        }


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
