//
//  DataService.swift
//  social
//
//  Created by Mickaele Perez on 11/7/17.
//  Copyright © 2017 Code. All rights reserved.
//

import Foundation
import Firebase

//singleton is an instance of a class thats globally accessible thats only one instance
//ex: could be in view controller 146 and you can still reference this


//want to reference base and make it global
//will contain the url of the root of our database
let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    //creates a singleton
    static let ds = DataService()
    
    //all global since they're a singleton
    private var _REF_BASE = DB_BASE     //url to database
    private var _REF_POST = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")

    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POST: FIRDatabaseReference {
        return _REF_POST
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        //if not in firebase, it will create the id automatically
        //also adds/updates the child values of the id, likes post and provider
        REF_USERS.child(uid).updateChildValues(userData)
        
        
        
    }
}










