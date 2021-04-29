//
//  DataPointRepository.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Combine

protocol DataPointRepository {
    func allDataPoints() throws -> [DataPoint]
    func dataPoint(withID: UUID) throws -> DataPoint?
    
    func addDataPoint(_ dataPoint: DataPoint) throws
    func updateDataPoint(_ dataPoint: DataPoint) throws
    func deleteDataPoint(_ id: UUID) throws
    
    var updatePublisher: RepositoryPublisher { get }
}

protocol DataPointRepositoryReadable {
    func getDataPoint(with id: UUID) throws -> Storage.DataPoint?
    func getAllDataPoints() throws -> [Storage.DataPoint]
}
protocol DataPointRepositoryWritable {
    func addDataPoint(_ storageDataPoint: Storage.DataPoint) throws
    func updateDataPoint(_ storageDataPoint: Storage.DataPoint) throws
    func deleteDataPoint(with id: UUID) throws
}

class MainDataPointRepository: DataPointRepository {
    
    private let subject = PassthroughSubject<RepositoryAction, Never>()
    var updatePublisher: RepositoryPublisher {
        subject.eraseToAnyPublisher()
    }
    
    private let storageRead: DataPointRepositoryReadable
    private let storageWrite: DataPointRepositoryWritable
    private let toDomain: StorageToDomainTransformer
    private let toStorage: DomainToStorageTransformer
    
    init(storageRead: DataPointRepositoryReadable,
         storageWrite: DataPointRepositoryWritable,
         toDomainTransformer: StorageToDomainTransformer = StorageToDomainFactory(),
         toStorageTransformer: DomainToStorageTransformer = DomainToStorageFactory()) {
        
        self.storageRead = storageRead
        self.storageWrite = storageWrite
        self.toDomain = toDomainTransformer
        self.toStorage = toStorageTransformer
    }
    
    func allDataPoints() throws -> [DataPoint] {
        guard let allDataPoints = try? storageRead.getAllDataPoints() else { return [] }
        return allDataPoints.compactMap { try? toDomain.dataPoint(from: $0) }
    }
    
    func dataPoint(withID: UUID) throws -> DataPoint? {
        guard let storageDataPoint = try storageRead.getDataPoint(with: withID) else { return nil }
        return try toDomain.dataPoint(from: storageDataPoint)
    }
    
    func addDataPoint(_ dataPoint: DataPoint) throws {
        let storageDataPoint = toStorage.dataPoint(from: dataPoint)
        try storageWrite.addDataPoint(storageDataPoint)
        subject.send(.add(dataPoint.id))
    }
    
    func updateDataPoint(_ dataPoint: DataPoint) throws {
        let storageDataPoint = toStorage.dataPoint(from: dataPoint)
        try storageWrite.updateDataPoint(storageDataPoint)
        subject.send(.update(dataPoint.id))
    }
    
    func deleteDataPoint(_ id: UUID) throws {
        try storageWrite.deleteDataPoint(with: id)
        subject.send(.delete(id))
    }
}
