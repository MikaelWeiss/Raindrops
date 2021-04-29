//
//  RepositoryRoot.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/17/21.
//

import Foundation

typealias StorageReadable = DataPointRepositoryReadable
typealias StorageWritable = DataPointRepositoryWritable

class RepositoryRoot {
    static private var storage: CoreDataStorage {
        RaindropApp.storage
    }
    static private let storageRead = storage
    static private let storageWrite = storage
    
    static var shared = RepositoryRoot()
    
    var dataPointRepository = MainDataPointRepository(
        storageRead: storageRead,
        storageWrite: storageWrite)
}
