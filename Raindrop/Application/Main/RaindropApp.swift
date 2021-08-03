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
    
    var body: some Scene {
        WindowGroup {
            DataEntryCell()
        }
    }
}
