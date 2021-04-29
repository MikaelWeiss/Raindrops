//
//  CoreDataStorage+WriteTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/17/21.
//

import XCTest
@testable import Raindrop
import Persistence

class CoreDataStorageWriteTests: XCTestCase {
    
    var store: CoreDataStore!
    var storage: CoreDataStorage!
    
    // MARK: - DataPoints
    
    func testAddDataPoint() throws {
        // Given
        let id = UUID()
        let date = Date()
        let storageDataPoint = makeStorageDataPoint(
            id: id,
            date: date,
            description: "Something",
            type: "Some type",
            category: "Some category",
            value: 54)
        
        // When
        try storage.addDataPoint(storageDataPoint)
        
        // Then
        let storeDataPoints = try store.getAllDataPoints()
        let storeDataPoint = try store.getDataPoint(with: id)
        XCTAssertEqual(storeDataPoint?.id, id)
        XCTAssertEqual(storeDataPoint?.date, date)
        XCTAssertEqual(storeDataPoint?.explanation, "Something")
        XCTAssertEqual(storeDataPoint?.type, "Some type")
        XCTAssertEqual(storeDataPoint?.category, "Some category")
        XCTAssertEqual(storeDataPoint?.value, 54)
        XCTAssertEqual(storeDataPoints.count, 1)
    }
    
    func testUpdateDataPointMissingID() {
        // Given
        let storageDataPoint = makeStorageDataPoint(id: nil)
        
        // When/Then
        XCTAssertThrowsError(try storage.updateDataPoint(storageDataPoint))
    }
    
    // MARK: - Helpers
    func makeStorageDataPoint(
        id: UUID? = nil,
        date: Date? = nil,
        description: String? = nil,
        type: String? = nil,
        category: String? = nil,
        value: Decimal? = nil) -> Storage.DataPoint {
        
        Storage.DataPoint(
            id: id,
            date: date,
            description: description,
            type: type,
            category: category,
            value: value)
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
