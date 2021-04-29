//
//  DomainToStorageTransformer.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol DomainToStorageTransformer {
    func dataPoint(from domainDataPoint: DataPoint) -> Storage.DataPoint
}

class DomainToStorageFactory: DomainToStorageTransformer {
    func dataPoint(from domainDataPoint: DataPoint) -> Storage.DataPoint {
        Storage.DataPoint(
            id: domainDataPoint.id,
            date: domainDataPoint.date,
            description: domainDataPoint.description,
            type: domainDataPoint.type.rawValue,
            category: domainDataPoint.category,
            value: domainDataPoint.value)
    }
}
