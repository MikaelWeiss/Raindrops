//
//  CashflowDataPoint.swift
//  Raindrop
//
//  Created by Mikael Weiss on 4/29/21.
//

import Foundation

class CashflowDataPoint {
    let id: UUID
    
    private(set) var date: Date
    func set(date: Date) throws {
        self.date = date
    }
    
    private(set) var description: String
    func set(description: String) throws {
        self.description = description
    }
    
    private(set) var type: CashflowType
    func set(type: CashflowType) throws {
        self.type = type
    }
    
    private(set) var category: String
    func set(category: String) throws {
        self.category = category
    }
    
    private(set) var value: Decimal
    func set(value: Decimal) throws {
        self.value = value
    }
    
    init(id: UUID = UUID(),
         date: Date = Date(),
         description: String,
         type: CashflowType,
         category: String,
         value: Decimal) {
        
        self.id = id
        self.date = date
        self.description = description
        self.type = type
        self.category = category
        self.value = value
    }
}
