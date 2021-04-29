//
//  StorageToDomainTransformer.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import SwiftUI

enum ReconstitutionError: Error {
    case missingRequiredFields
    case invalidOption(String)
}

protocol StorageToDomainTransformer {
    func dataPoint(from storageDataPoint: Storage.DataPoint) throws -> DataPoint
}

class StorageToDomainFactory: StorageToDomainTransformer {
    func dataPoint(from storageDataPoint: Storage.DataPoint) throws -> DataPoint {
        guard let id = storageDataPoint.id,
              let date = storageDataPoint.date,
              let description = storageDataPoint.description,
              let type = storageDataPoint.type,
              let category = storageDataPoint.category,
              let value = storageDataPoint.value
        else { throw ReconstitutionError.missingRequiredFields }
        
        let dataPointInfo = DataPoint.ReconstitutionInfo(
            id: id,
            date: date,
            description: description,
            type: type,
            category: category,
            value: value)
        
        return try DataPoint(with: dataPointInfo)
    }
}
