//
//  DataPointRepositoryTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Raindrop
import Combine

class DataPointRepositoryTests: XCTestCase {
    
    var repository: DataPointRepository!
    var storageRead: DataPointRepositoryReadableDouble!
    var storageWrite: DataPointRepositoryWritableDouble!
    var toDomain: StorageToDomainTransformer!
    var toStorage: DomainToStorageTransformer!
    
    func testFetchAllDataPoints() throws {
        // Given
        let id = UUID()
        let date = Date()
        let storageDataPoint = makeStorageDataPoint(
            id: id,
            date: date,
            description: "Something",
            type: "income",
            category: "Some category",
            value: 55)
        storageRead.dataPointsToReturn = [storageDataPoint]
        
        // When
        let allDataPoints = try? repository.allDataPoints()
        
        // Then
        let dataPoint = allDataPoints?.first
        XCTAssertEqual(dataPoint?.id, id)
        XCTAssertEqual(dataPoint?.date, date)
        XCTAssertEqual(dataPoint?.description, "Something")
        XCTAssertEqual(dataPoint?.type, .income)
        XCTAssertEqual(dataPoint?.category, "Some category")
        XCTAssertEqual(dataPoint?.value, 55)
        XCTAssertEqual(allDataPoints?.count, 1)
    }
    
    func testFetchDataPoint() throws {
        // Given
        let id = UUID()
        storageRead.dataPointToReturn = makeStorageDataPoint(id: id, description: "Something")
        
        // When
        let dataPoint = try? repository.dataPoint(withID: id)
        
        // Then
        XCTAssertEqual(dataPoint?.id, id)
        XCTAssertEqual(dataPoint?.description, "Something")
    }
    
    func testAddDataPoint() throws {
        // Given
        let id = UUID()
        let dataPoint = makeDataPoint(id: id)
        
        // When
        try repository.addDataPoint(dataPoint)
        
        // Then
        let storageDataPoint = storageWrite.addDataPointDataPoint
        XCTAssertEqual(storageDataPoint?.id, id)
    }
    
    func testAddDataPointPublishes() throws {
        // Given
        let expectation = self.expectation(description: "Publisher called")
        let id = UUID()
        let dataPoint = makeDataPoint(id: id)
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .add(let dataPointID) = action {
                    XCTAssertEqual(dataPointID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.addDataPoint(dataPoint)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    
    func testUpdateDataPoint() throws {
        // Given
        let id = UUID()
        storageWrite.updateDataPointDataPoint = makeStorageDataPoint(id: id, description: "Some old description")
        let dataPoint = makeDataPoint(id: id, description: "Some new description")
        
        // When
        try repository.updateDataPoint(dataPoint)
        
        // Then
        let storageDataPoint = storageWrite.updateDataPointDataPoint
        XCTAssertEqual(storageDataPoint?.id, id)
        XCTAssertEqual(storageDataPoint?.description, "Some new description")
    }
    
    func testUpdateDataPointPublishes() throws {
        // Given
        let expectation = self.expectation(description: "Publisher called")
        let id = UUID()
        let dataPoint = makeDataPoint(id: id)
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .update(let dataPointID) = action {
                    XCTAssertEqual(dataPointID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.updateDataPoint(dataPoint)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    func testDeleteDataPoint() throws {
        // Given
        let id = UUID()
        
        // When
        try repository.deleteDataPoint(id)
        
        // Then
        XCTAssertEqual(storageWrite.deleteDataPointID, id)
    }
    
    func testDeleteDataPointPublishes() throws {
        // Given
        let id = UUID()
        let expectation = self.expectation(description: "Publisher called")
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .update(let dataPointID) = action {
                    XCTAssertEqual(dataPointID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.deleteDataPoint(id)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    private func makeStorageDataPoint(
        id: UUID = UUID(),
        date: Date = Date(),
        description: String = "",
        type: String = "income",
        category: String = "",
        value: Decimal = .nan) -> Storage.DataPoint {
        
        Storage.DataPoint(
            id: id,
            date: date,
            description: description,
            type: type,
            category: category,
            value: value)
    }
    
    private func makeDataPoint(
        id: UUID = UUID(),
        date: Date = Date(),
        description: String = "",
        type: DataPointType = .income,
        category: String = "",
        value: Decimal = .nan) -> DataPoint {
        
        DataPoint(
            id: id,
            date: date,
            description: description,
            type: type,
            category: category,
            value: value)
    }
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        toDomain = StorageToDomainFactory()
        toStorage = DomainToStorageFactory()
        storageRead = DataPointRepositoryReadableDouble()
        storageWrite = DataPointRepositoryWritableDouble()
        repository = MainDataPointRepository(
            storageRead: storageRead,
            storageWrite: storageWrite,
            toDomainTransformer: toDomain,
            toStorageTransformer: toStorage)
    }
    
    // MARK: - Doubles
    class DataPointRepositoryReadableDouble: DataPointRepositoryReadable {
        var getDataPointID: UUID?
        
        var dataPointToReturn: Storage.DataPoint?
        var dataPointsToReturn = [Storage.DataPoint]()
        
        func getDataPoint(with id: UUID) throws -> Storage.DataPoint? {
            dataPointToReturn
        }
        
        func getAllDataPoints() throws -> [Storage.DataPoint] {
            dataPointsToReturn
        }
    }
    
    class DataPointRepositoryWritableDouble: DataPointRepositoryWritable {
        var addDataPointDataPoint: Storage.DataPoint?
        var updateDataPointDataPoint: Storage.DataPoint?
        var deleteDataPointID: UUID?
        
        func addDataPoint(_ storageDataPoint: Storage.DataPoint) throws {
            addDataPointDataPoint = storageDataPoint
        }
        
        func updateDataPoint(_ storageDataPoint: Storage.DataPoint) throws {
            updateDataPointDataPoint = storageDataPoint
        }
        
        func deleteDataPoint(with id: UUID) throws {
            deleteDataPointID = id
        }
    }
}
