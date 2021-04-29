//
//  CoreDataStorage+ReadTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/17/21.
//

import XCTest
@testable import Raindrop
import Persistence

class CoreDataStorageReadTests: XCTestCase {
    
    var store: CoreDataStore!
    var storage: CoreDataStorage!
    
    // MARK: - DataPoints
    
    func testGetDataPoint() throws {
        // Given
        let id = UUID()
        let dataPoint = store.newDataPoint()
        dataPoint.id = id
        
        // When
        let storageDataPoint = try storage.getDataPoint(with: id)
        
        // Then
        XCTAssertEqual(storageDataPoint?.id, id)
    }
    
    func testGetDataPointObjectNotFound() throws {
        // When/Then
        XCTAssertThrowsError(try storage.getDataPoint(with: UUID()))
    }
    
    func testGetAllDataPoint() throws {
        // Given
        _ = store.newDataPoint()
        _ = store.newDataPoint()
        _ = store.newDataPoint()
        
        // When
        let storageDataPoints = try storage.getAllDataPoints()
        
        // Then
        XCTAssertEqual(storageDataPoints.count, 3)
    }
    
    // MARK: - setUp / tearDown
    
    override func setUp() {
        super.setUp()
        store = CoreDataStore(storageType: .inMemory)
        storage = CoreDataStorage(store: store)
        try? store.deleteAll()
    }
    
    override func tearDown() {
        try? store.deleteAll()
        super.tearDown()
    }
}
