//
//  ViewController.swift
//  CRTouchIDWrapper
//
//  Created by CheeseRoot on 01/06/15.
//  Copyright (c) 2015 CheeseRoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authenticationButtonPressed(sender: UIButton) {
        
        //Authenticate using TouchId wrapper method
        //Eliminates the need to check for version, availability (If used at multiple places in the app)

        let localizedReason = "Authenticate for proceeding"
        let localizedFallbackTitle = ""
        
        TouchIDManager.presentTouchIdOptionForAuth(localizedReason, localizedFallbackTitle: localizedFallbackTitle, completion: { (isAuthSuccess:Bool, error:NSError!) -> Void in
            
            if isAuthSuccess {
                //Authentication successful
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = storyBoard.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
                self.presentViewController(newVC, animated: true, completion: nil)
            }
            else {
                println(error.code)
                println(error.description)
            }
        })
    }
}

