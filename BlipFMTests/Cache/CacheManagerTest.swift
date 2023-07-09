//
//  CacheManagerTest.swift
//  BlipFMTests
//
//  Created by Lima, Rafael on 09/07/2023.
//

import XCTest
@testable import BlipFM

class CacheManagerTests: XCTestCase {
    
    func testSetObject() {
        let cacheManager = CacheManager<ExampleStruct>()
        
        let structInstance = ExampleStruct(name: "John", age: 30)
        cacheManager.setObject(structInstance, forKey: .topAlbunsResponse)
        
        let cachedStruct = cacheManager.getObject(forKey: .topAlbunsResponse)
        
        XCTAssertEqual(cachedStruct, structInstance)
    }
    
    func testGetObject() {
        let cacheManager = CacheManager<ExampleStruct>()
        
        let structInstance = ExampleStruct(name: "John", age: 30)
        cacheManager.setObject(structInstance, forKey: .topAlbunsResponse)
        
        let cachedStruct = cacheManager.getObject(forKey: .topAlbunsResponse)
        
        XCTAssertEqual(cachedStruct, structInstance)
    }
    
    func testRemoveObject() {
        let cacheManager = CacheManager<ExampleStruct>()
        
        let structInstance = ExampleStruct(name: "John", age: 30)
        cacheManager.setObject(structInstance, forKey: .topAlbunsResponse)
        
        cacheManager.removeObject(forKey: .topAlbunsResponse)
        
        let cachedStruct = cacheManager.getObject(forKey: .topAlbunsResponse)
        
        XCTAssertNil(cachedStruct)
    }
    
    func testRemoveAllObjects() {
        let cacheManager = CacheManager<ExampleStruct>()
        
        let structInstance1 = ExampleStruct(name: "John", age: 30)
        let structInstance2 = ExampleStruct(name: "Jane", age: 25)
        
        cacheManager.setObject(structInstance1, forKey: .topAlbunsResponse)
        cacheManager.setObject(structInstance2, forKey: .topAlbunsResponse)
        
        cacheManager.removeAllObjects()
        
        let cachedStruct1 = cacheManager.getObject(forKey: .topAlbunsResponse)
        let cachedStruct2 = cacheManager.getObject(forKey: .topAlbunsResponse)
        
        XCTAssertNil(cachedStruct1)
        XCTAssertNil(cachedStruct2)
    }
}

struct ExampleStruct: Equatable {
    let name: String
    let age: Int
}
