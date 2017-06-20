//
//  ViewController.swift
//  social
//
//  Created by Mickaele Perez on 5/31/17.
//  Copyright © 2017 Code. All rights reserved.
//

import UIKit
//steps to invoke the login dialoge
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //steps to invoke the login dialoge using the LoginManager class for custom btn
    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        //requesting read permission from the email address
        //Facebook code
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (results, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Facebook - \(error)")
            }
            //if user doesn't give permission
            else if results?.isCancelled == true {
                print("User cancelled Facebook authentication")
            } else {
                
                //if successful, using token to get the credential
                //firebase authentication credential
                //producting this credential to communicate with firebase
                print("Jess: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    //pure firebase authentication method
    //authenticate with firebase using our fb credentials
    //in completion handler, user and error should be coming back
    func firebaseAuth(_ credential: FIRAuthCredential) {
        //authenticate with firebase
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Firebase - \(error)")
            } else {
                print("Jess: Successfully authenticated with Firebsae")
            }
        })
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            //attempts to sign in with email the user provided
            //authenticate right awar cause its just email and password
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JESS: Email user authenticated with Firebase")
                } else {
                    //if do user doesn't exist then we create that account
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            //an error occured
                            print("Jess: Unable to authenticate with Firebase using email")
                        } else {
                            //it was a success
                            print("Jess: Successfully authenticated with Firebase")
                        }
                    })
                    
                }
            })
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

