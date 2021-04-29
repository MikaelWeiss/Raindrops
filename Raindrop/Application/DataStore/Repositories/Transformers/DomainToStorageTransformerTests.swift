//
//  DomainToStorageTransformerTests.swift
//  RaindropTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Raindrop

class DomainToStorageTransformerTests: XCTestCase {
    
    var factory = DomainToStorageFactory()
    
    // MARK: - DataPoint
    
    func testDataPoint() {
        // Given
        let id = UUID()
        let date = Date()
        let domainDataPoint = DataPoint(
            id: id,
            date: date,
            description: "some description",
            type: .income,
            category: "some category",
            value: 20)
        
        // When
        let dataPoint = factory.dataPoint(from: domainDataPoint)
        
        // Then
        XCTAssertEqual(dataPoint.id, id)
        XCTAssertEqual(dataPoint.date, date)
        XCTAssertEqual(dataPoint.description, "some description")
        XCTAssertEqual(dataPoint.type, "income")
        XCTAssertEqual(dataPoint.category, "some category")
        XCTAssertEqual(dataPoint.value, 20)
    }
}
