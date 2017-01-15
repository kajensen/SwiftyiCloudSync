//
//  SwiftyiCloudSync.swift
//  SwiftyiCloudSync
//
//  Created by Kurt Jensen on 1/15/17.
//  Copyright © 2017 Kurt Jensen. All rights reserved.
//

import Foundation

class SwiftyiCloudSync {
    
    static var prefix: String?
    
    class func shouldSyncKey(_ key: String) -> Bool {
        guard let prefix = prefix else { return true }
        return key.hasPrefix(prefix)
    }
    
    class func start(prefix: String?) {
        SwiftyiCloudSync.prefix = prefix
        addObservers()
    }
    
    @objc class func updateUserDefaultsFromiCloud(_ notification: NSNotification?) {
        removeObservers()
        let iCloudDictionary = NSUbiquitousKeyValueStore.default().dictionaryRepresentation
        let userDefaults = UserDefaults.standard
        for (key, value) in iCloudDictionary {
            if shouldSyncKey(key) {
                userDefaults.set(value, forKey: key)
                debugPrint("updateUserDefaults", (key, value))
            }
        }
        userDefaults.synchronize()
        addObservers()
    }
    
    @objc class func updateiCloudFromUserDefaults(_ notification: NSNotification?) {
        let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
        let cloudStore = NSUbiquitousKeyValueStore.default()
        for (key, value) in defaultsDictionary {
            if shouldSyncKey(key) {
                cloudStore.set(value, forKey: key)
                debugPrint("updateiCloud", (key, value))
            }
        }
        cloudStore.synchronize()
    }
    
    class func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(SwiftyiCloudSync.updateUserDefaultsFromiCloud(_:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SwiftyiCloudSync.updateiCloudFromUserDefaults(_:)), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    class func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
    }
    
}
