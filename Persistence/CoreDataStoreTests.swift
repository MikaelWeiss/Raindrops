//
//  CoreDataStoreTests.swift
//  Persistence
//
//  Created by Mikael Weiss on 2/18/21.
//

@testable import Persistence
import XCTest

class CoreDataStoreTests: XCTestCase {
    
    var store: CoreDataStore!
    
    override func setUp() {
        super.setUp()
        store = CoreDataStore(storageType: .inMemory)
        try! store.deleteAll()
    }
    
    override func tearDown() {
        try! store.deleteAll()
        super.tearDown()
    }
    
    // MARK: - Save
    
    func testSaveNoChanges() {
        // Given
        
        // When
        XCTAssertNoThrow(try store.save())
        
        // Then
    }
    
    func testSaveHasChanges() {
        // Given
        _ = store.newDataPoint()
        
        // When
        XCTAssertNoThrow(try store.save())
        
        // Then
    }
    
    // MARK: - Delete All
    
    func testDeleteAll() {
        // Given
        var result: Persistence.DataPoint?
        let id = UUID()
        let newEntity = store.newDataPoint()
        newEntity.id = id
        XCTAssertNoThrow(try store.save())
        
        // When
        XCTAssertNoThrow(try store.deleteAll())
        
        // Then
        XCTAssertNoThrow(result = try store.getDataPoint(with: id))
        XCTAssertNil(result)
    }
    
    // MARK: - DataPoint
    
    func testNewDataPoint() {
        // When
        let result = store.newDataPoint()
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func testGetDataPointWithUnknownID() {
        // Given
        var result: Persistence.DataPoint?
        let randomID = UUID()
        
        // When
        XCTAssertNoThrow(result = try store.getDataPoint(with: randomID))
        
        // Then
        XCTAssertNil(result)
    }
    
    func testGetDataPointWithKnownID() {
        // Given
        var result: Persistence.DataPoint?
        let id = UUID()
        let newEntity = store.newDataPoint()
        newEntity.id = id
        XCTAssertNoThrow(try store.save())
        
        // When
        XCTAssertNoThrow(result = try store.getDataPoint(with: id))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, id)
    }
    
    func testDeleteDataPoint() {
        // Given
        var result: Persistence.DataPoint?
        let id = UUID()
        let newEntity = store.newDataPoint()
        newEntity.id = id
        XCTAssertNoThrow(try store.save())
        
        // When
        XCTAssertNoThrow(try store.deleteDataPoint(with: id))
        
        // Then
        XCTAssertNoThrow(result = try store.getDataPoint(with: id))
        XCTAssertNil(result)
    }
    
    func testGetAllDataPoints() throws {
        // Given
        _ = store.newDataPoint()
        _ = store.newDataPoint()
        _ = store.newDataPoint()
        XCTAssertNoThrow(try store.save())
        
        // When
        let entities = try store.getAllDataPoints()
        
        XCTAssertEqual(entities.count, 3)
    }
}
