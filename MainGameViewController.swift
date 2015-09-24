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
import CoreData


class MainGameViewController: UIViewController {
    
    var friends:[person] = []
    var data: NSData?
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet var nameButtons: Array<UIButton> = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnUserData()


        // Do any additional setup after loading the view.
    }
    
    func returnUserData()
    {
        let requestParameters = ["fields": "name, picture.type(large), data, url"]
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/taggable_friends?", parameters: requestParameters)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                
                let resultdict = result as! NSDictionary
                let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let name = valueDict.objectForKey("name") as! String
                    let pictureDict = valueDict.objectForKey("picture") as! NSDictionary
                    let pictureData = pictureDict.objectForKey("data") as! NSDictionary
                    let pictureURL = pictureData.objectForKey("url") as! String
                    
                    let friend = person(name: name, pic: pictureURL)
                    
                    self.friends.append(friend)
                    
                }
                
            }
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        loadQuiz()
        
    }
    
    
    func loadQuiz(){
        
        //generate random numbers for pic
        var randArray: [Int] = []
        
        for var i = 0; i < 4; ++i{
            randArray.append(Int(arc4random_uniform(UInt32(self.friends.count))))
        }
        
        randArray.append(Int(arc4random_uniform(4)))
        
        for var i = 0; i < 4; ++i{
            for var j = i+1; j < 4; ++j{
                if (randArray[i] == randArray[j]){
                    loadQuiz()
                }
            }
        }
        
        //load ProfilePic
        let url = NSURL(string:self.friends[randArray[randArray[4]]].pic)
        data = NSData(contentsOfURL:url!)
        if data != nil {
            profilePic?.image = UIImage(data:data!)
        }
        
        //set button names
        for var i = 0; i < 4; ++i {
            nameButtons[i].tag = randArray[randArray[4]]
            nameButtons[i].setTitle(self.friends[randArray[i]].name, forState: .Normal)
            nameButtons[i].addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        }
        
    }
    
    func buttonPressed(sender: UIButton!) {
        
        if (sender.currentTitle! == self.friends[sender.tag].name){
            //correct
            loadQuiz()
            //TODO: correct Animation
        }
        else{
            loadQuiz()
            //Incorrect
            //TODO: Save Incorrect
            save(self.friends[sender.tag].name)
            //TODO: incorrect Animation
        }
        
    }
    
    //saves name of person
    func save(Name: String){
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newPerson = NSEntityDescription.insertNewObjectForEntityForName("Unknown", inManagedObjectContext: context) as NSManagedObject
        
        newPerson.setValue(Name, forKey: "name")
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        if data != nil {
            profilePic.image = UIImage(data:data!)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
