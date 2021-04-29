//
//  CoreDataStorage+Read.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

extension CoreDataStorage: StorageReadable {
    
    // MARK: - DataPoints
    
    func getDataPoint(with id: UUID) throws -> Storage.DataPoint? {
        guard let persistenceDataPoint = try? store.getDataPoint(with: id)
        else {
            throw StorageError.objectNotFound(id.uuidString)
        }
        return factory.dataPoint(from: persistenceDataPoint)
    }
    
    func getAllDataPoints() throws -> [Storage.DataPoint] {
        let storeDataPoints = try store.getAllDataPoints()
        return storeDataPoints.map { factory.dataPoint(from: $0) }
    }
}
