//
//  CoreDataStorageFactory.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

protocol CoreDataStoreStorage {
    // Core Data Store -> Storage
    func dataPoint(from storeDataPoint: Persistence.DataPoint) -> Storage.DataPoint
    
    // Storage -> Core Data Store
    // The store does the actual creation. We just copy values here.
    func copyDataPointValues(from dataPoint: Storage.DataPoint, to storeDataPoint: Persistence.DataPoint)
}

class CoreDataStoreStorageFactory: CoreDataStoreStorage {
    // MARK: - Core Data Store - Storage
    
    func dataPoint(from storeDataPoint: Persistence.DataPoint) -> Storage.DataPoint {
        Storage.DataPoint(
            id: storeDataPoint.id,
            date: storeDataPoint.date,
            description: storeDataPoint.explanation,
            type: storeDataPoint.type,
            category: storeDataPoint.category,
            value: storeDataPoint.value as Decimal?)
    }
    
    // MARK: - Storage -> Core Data Store
    func copyDataPointValues(from dataPoint: Storage.DataPoint, to storeDataPoint: Persistence.DataPoint) {
        storeDataPoint.id = dataPoint.id
        storeDataPoint.date = dataPoint.date
        storeDataPoint.explanation = dataPoint.description
        storeDataPoint.type = dataPoint.type
        storeDataPoint.category = dataPoint.category
        storeDataPoint.value = dataPoint.value as NSDecimalNumber?
    }
}
