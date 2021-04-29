//
//  Storage.swift
//  Raindrop
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

enum Storage {
    struct DataPoint: Codable {
        let id: UUID?
        let date: Date?
        let description: String?
        let type: String?
        let category: String?
        let value: Decimal?
    }
}
