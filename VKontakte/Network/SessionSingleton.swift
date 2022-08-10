//
//  Session.swift
//  VKontakte
//
//  Created by Valya on 05.08.2022.
//

import UIKit

class SessionSingleton {
    
    static var shared = SessionSingleton() 
    private init(){}
    var token: String = ""
    var userId: Int = 0
    
    func printUserId() {
        print(userId)
    }
    
    func initToken() {
        self.token = "SLOVO"
    }
}
