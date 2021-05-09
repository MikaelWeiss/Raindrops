//
//  EditDataPointService.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditDataPointService {
    func fetchDataPointValues() throws -> EditDataPoint.DataPointValues
    func set(date: Date)
    func set(description: String)
    func set(type: DataPointType)
    func set(category: String)
    func set(value: Decimal)
    func canSave() -> Bool
    func save() throws
    func delete() throws
}

protocol EditDataPointDataPointFetching {
    func dataPoint(withID: UUID) throws -> DataPoint?
    func addDataPoint(_ dataPoint: DataPoint) throws
    func updateDataPoint(_ dataPoint: DataPoint) throws
    func deleteDataPoint(_ id: UUID) throws
    
}
extension MainDataPointRepository: EditDataPointDataPointFetching { }

extension EditDataPoint {
    
    struct DataPointValues {
        var date: Date = .now
        var description: String = ""
        var type: DataPointType = .spending
        var category: String?
        var value: Decimal?
    }
    
    enum ServiceError: Error {
        case saveFailedCannotSave
        case saveFailedMissingRequiredFields
        case deleteFailedMustHaveDataPoint
    }
    
    class Service: EditDataPointService {
        
        private let dataPointFetcher: EditDataPointDataPointFetching
        private let dataPointID: UUID?
        private var dataPoint: DataPoint?
        private var dataPointValues: DataPointValues = DataPointValues()
        
        init(dataPointID: UUID?, dataPointFetcher: EditDataPointDataPointFetching) {
            self.dataPointID = dataPointID
            self.dataPointFetcher = dataPointFetcher
            self.dataPoint = nil
            self.dataPointValues = DataPointValues()
            
            if let dataPointID = dataPointID, let dataPoint = dataPoint(for: dataPointID) {
                self.dataPoint = dataPoint
                dataPointValues = DataPointValues(
                    date: dataPoint.date,
                    description: dataPoint.description,
                    type: dataPoint.type,
                    category: dataPoint.category,
                    value: dataPoint.value)
            }
        }
        
        private func dataPoint(for id: UUID) -> DataPoint? {
            try? dataPointFetcher.dataPoint(withID: id)
        }
        
        func fetchDataPointValues() throws -> DataPointValues {
            dataPointValues
        }
        
        func set(date: Date) {
            dataPointValues.date = date
        }
        
        func set(description: String) {
            dataPointValues.description = description
        }
        
        func set(type: DataPointType) {
            dataPointValues.type = type
        }
        
        func set(category: String) {
            dataPointValues.category = category
        }
        
        func set(value: Decimal) {
            dataPointValues.value = value
        }
        
        func canSave() -> Bool {
            dataPointValues.category != nil
                && dataPointValues.value != nil
                && hasChanges
        }
        
        private var hasChanges: Bool {
            guard let dataPoint = dataPoint else { return true }
            return dataPoint.date != dataPointValues.date
                && dataPoint.description != dataPointValues.description
                && dataPoint.type != dataPointValues.type
                && dataPoint.category != dataPointValues.category
                && dataPoint.value != dataPointValues.value
        }
        
        func save() throws {
            guard canSave() else { throw ServiceError.saveFailedCannotSave }
            guard let category = dataPointValues.category, let value = dataPointValues.value else {
                throw ServiceError.saveFailedMissingRequiredFields
            }
            
            if let dataPoint = dataPoint {
                try dataPoint.set(date: dataPointValues.date)
                try dataPoint.set(description: dataPointValues.description)
                try dataPoint.set(type: dataPointValues.type)
                try dataPoint.set(category: category)
                try dataPoint.set(value: value)
                
                try dataPointFetcher.updateDataPoint(dataPoint)
            } else {
                let dataPoint = DataPoint(
                    date: dataPointValues.date,
                    description: dataPointValues.description,
                    type: dataPointValues.type,
                    category: category,
                    value: value)
                self.dataPoint = dataPoint
                try dataPointFetcher.addDataPoint(dataPoint)
            }
        }
        
        func delete() throws {
            guard let dataPoint = dataPoint else { throw ServiceError.deleteFailedMustHaveDataPoint }
            try dataPointFetcher.deleteDataPoint(dataPoint.id)
        }
    }
}
