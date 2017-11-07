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
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    //viewDidLoad() can't perform segueways
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    //segue needs to be in viewDidAppear in order to stay logged into the social app, not the viewDidLoad()
    override func viewDidAppear(_ animated: Bool) {
        //checking if the key exists
        //checking for the string of KEY_UID
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("Jess: Id found in keychain")
            //if key exists, perform segue
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
        }
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
                //checks to see if user exists, if so then you use it to get the id
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
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
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    //if do user doesn't exist then we create that account
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            //an error occured
                            print("Jess: Unable to authenticate with Firebase using email")
                        } else {
                            //it was a success
                            print("Jess: Successfully authenticated with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let KeychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Jess: Data saved to keychain \(KeychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
}

