//
//  AppDelegate.swift
//  ToDoList
//
//  Created by einfochips on 18/05/18.
//  Copyright © 2018 einfochips. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
    
        
        do {
            _ = try Realm()
        } catch {
            print("Error Initialising new realm \(error)")
        }
        return true
    }

   
}

