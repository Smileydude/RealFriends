//
//  MainMenuViewController.swift
//  Real Friends?
//
//  Created by Tom Woudenberg on 2015-09-17.
//  Copyright © 2015 Smileydude. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MainMenuViewController: UIViewController {
    var facebookid: NSString = ""
    var userName: NSString = ""
    var userEmail: NSString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        var requestParameters = ["fields": "id, email, first_name, last_name"]
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if(error != nil)
            {
                print("\(error.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                
                let userId:String = result["id"] as! String
                let userFirstName:String? = result["first_name"] as? String
                let userLastName:String? = result["last_name"] as? String
                let userEmail:String? = result["email"] as? String
                
                
                print("\(userEmail)")
                
                let myUser:PFUser = PFUser.currentUser()!
                
                // Save first name
                if(userFirstName != nil)
                {
                    myUser.setObject(userFirstName!, forKey: "first_name")
                    
                }
                
                //Save last name
                if(userLastName != nil)
                {
                    myUser.setObject(userLastName!, forKey: "last_name")
                }
                
                // Save email address
                if(userEmail != nil)
                {
                    myUser.setObject(userEmail!, forKey: "email")
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    // Get Facebook profile picture
                    var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    let profilePictureUrl = NSURL(string: userProfile)
                    
                    let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                    
                    if(profilePictureData != nil)
                    {
                        let profileFileObject = PFFile(data:profilePictureData!)
                        myUser.setObject(profileFileObject, forKey: "profile_picture")
                    }
                    
                    
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            println("User details are now updated")
                        }
                        
                    })
                    
                }
                
            }
            
        }
        
        print("\(self.facebookid)")
        print("\(self.userName)")
        print("\(self.userEmail)")
        print("test")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logOut()
        
        //switch to login naviagtor
        changeNavLogin()
        
    }
    
    func changeNavLogin(){
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginPage") as! ViewController
        
        let loginPageNavigationController = UINavigationController (rootViewController: loginPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPageNavigationController
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
