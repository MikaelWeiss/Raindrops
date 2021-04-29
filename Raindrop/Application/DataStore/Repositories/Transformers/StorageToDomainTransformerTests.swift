//
//  StorageToDomainTransformerTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Raindrop

class StorageToDomainTransformerTests: XCTestCase {
    
    var factory = StorageToDomainFactory()
    
    // MARK: - DataPoint
    func testDataPoint() throws {
        // Given
        let id = UUID()
        let givenDate = Date()
        let storageDataPoint = Storage.DataPoint(
            id: id,
            date: givenDate,
            description: "Some description",
            type: "income",
            category: "Some category",
            value: 23)
        
        // When
        let dataPoint = try factory.dataPoint(from: storageDataPoint)
        
        // Then
        XCTAssertEqual(dataPoint.id, id)
        XCTAssertEqual(dataPoint.date, givenDate)
        XCTAssertEqual(dataPoint.description, "Some description")
        XCTAssertEqual(dataPoint.type, .income)
        XCTAssertEqual(dataPoint.category, "Some category")
        XCTAssertEqual(dataPoint.value, 23)
    }
}
