//
//  AppDelegate.swift
//  string-from-date
//
//  Created by HASHIMOTO Wataru on 6/10/16.
//  Copyright © 2016 HASHIMOTO Wataru. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let date = NSDate()
        let locale = NSLocale.currentLocale()
        
        let format = NSDateFormatter.dateFormatFromTemplate("yyyyMMM",
                                                            options: 0,
                                                            locale: locale)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        print(dateFormatter.stringFromDate(date))
        
        
        return true
    }
}

