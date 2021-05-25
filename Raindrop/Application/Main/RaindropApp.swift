//
//  RaindropApp.swift
//  Raindrop
//
//  Created by Mikael Weiss on 4/29/21.
//

import SwiftUI

@main
struct RaindropApp: App {
    static let storage = CoreDataStorage.shared
    @State private var value: Decimal? = 5
    
    var body: some Scene {
        WindowGroup {
            DecimalEntryCell(value: value, onValueChanged: { value = $0 })
        }
    }
}
