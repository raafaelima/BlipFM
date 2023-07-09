//
//  CacheManager.swift
//  BlipFM
//
//  Created by Lima, Rafael on 09/07/2023.
//

import Foundation

class CacheManager<Value> {

    private let cache = NSCache<NSString, AnyObject>()

    func setObject(_ object: Value, forKey key: CacheKeys) {
        cache.setObject(object as AnyObject, forKey: keyToString(key))
    }

    func getObject(forKey key: CacheKeys) -> Value? {
        return cache.object(forKey: keyToString(key)) as? Value
    }

    func removeObject(forKey key: CacheKeys) {
        cache.removeObject(forKey: keyToString(key))
    }

    func removeAllObjects() {
        cache.removeAllObjects()
    }

    private func keyToString(_ key: CacheKeys) -> NSString {
        return NSString(string: key.rawValue)
    }
}
