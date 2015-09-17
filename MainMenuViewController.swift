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

    override func viewDidLoad() {
        super.viewDidLoad()

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
