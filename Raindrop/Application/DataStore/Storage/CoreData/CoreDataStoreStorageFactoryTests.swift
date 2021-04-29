//
//  CoreDataStoreStorageFactoryTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Raindrop
import Persistence

class CoreDataStoreStorageFactoryTests: XCTestCase {
    
    var factory = CoreDataStoreStorageFactory()
    var store = CoreDataStore(storageType: .inMemory)
    
    func testDataPoint() {
        // Given
        let givenDate = Date()
        
        let storeDataPoint = store.newDataPoint()
        storeDataPoint.id = UUID(uuidString: "123E4567-E89B-12D3-A456-426655440000")
        storeDataPoint.date = givenDate
        storeDataPoint.explanation = "Something"
        storeDataPoint.type = "income"
        storeDataPoint.category = "Something else"
        storeDataPoint.value = 45
        
        // When
        let storageDataPoint = factory.dataPoint(from: storeDataPoint)
        
        XCTAssertEqual(storageDataPoint.id, UUID(uuidString: "123E4567-E89B-12D3-A456-426655440000"))
        XCTAssertEqual(storageDataPoint.date, givenDate)
        XCTAssertEqual(storageDataPoint.description, "Something")
        XCTAssertEqual(storageDataPoint.type, "income")
        XCTAssertEqual(storageDataPoint.category, "Something else")
        XCTAssertEqual(storageDataPoint.value, 45)
    }
}
