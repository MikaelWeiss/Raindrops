//
//  CoreDataStorage+Write.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

extension CoreDataStorage: StorageWritable {
    
    // MARK: - DataPoints
    
    func addDataPoint(_ storageDataPoint: Storage.DataPoint) throws {
        let storeDataPoint = store.newDataPoint()
        factory.copyDataPointValues(from: storageDataPoint, to: storeDataPoint)
        try store.save()
    }
    
    func updateDataPoint(_ storageDataPoint: Storage.DataPoint) throws {
        guard let dataPointID = storageDataPoint.id else {
            throw StorageError.missingID
        }
        
        guard let storeDataPoint = try store.getDataPoint(with: dataPointID) else {
            throw StorageError.objectNotFound(dataPointID.uuidString)
        }
        
        factory.copyDataPointValues(from: storageDataPoint, to: storeDataPoint)
        try store.save()
    }
    
    func deleteDataPoint(with id: UUID) throws {
        try store.deleteDataPoint(with: id)
        try store.save()
    }
}
