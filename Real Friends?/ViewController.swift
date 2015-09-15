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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() == nil){
            //TODO: Not Logged In
        }
        else{
            //TODO: Logged In
            self.performSegueWithIdentifier("ShowNew", sender: self)
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error == nil){
            //TODO: login complete
        }
        else{
            //TODO: error
            // error = error.localizedDescription
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

