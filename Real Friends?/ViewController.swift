//
//  ViewController.swift
//  Real Friends?
//
//  Created by Tom Woudenberg on 2015-09-15.
//  Copyright © 2015 Smileydude. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var LoginButton: FBSDKLoginButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            //user not logged in
        }
        else
        {
            // User is already logged in
        }
        
        
        LoginButton.delegate = self
        LoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil){
            print(error.localizedDescription)
            return
        }
        if let userToken = result.token
        {
            let token:FBSDKAccessToken = result.token
            print("Token =\(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("User ID =\(FBSDKAccessToken.currentAccessToken().userID)")
            
            let mainMenu = self.storyboard?.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
            
            let mainMenuNavigationController = UINavigationController (rootViewController: mainMenu)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = mainMenuNavigationController
            
        }
        
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        //TODO: loggout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

