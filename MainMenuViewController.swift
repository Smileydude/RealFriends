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
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var profilePic: FBSDKProfilePictureView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profile pic
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic.layer.borderWidth = 1.0;
        self.profilePic.clipsToBounds = true
        
        

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
