//
//  AppEntry.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//

import SwiftUI

struct AppEntry: View {
    @State private var isShowingEditDataPoint = false
    
    var body: some View {
        Text("Tap Me")
            .background(isShowingEditDataPoint ? Color.blue : Color.red)
            .onTapGesture {
                EditDataPoint.prepareIncomingRoute(dataPointID: nil)
                isShowingEditDataPoint = true
            }
            .sheet(isPresented: $isShowingEditDataPoint) {
                EditDataPoint.Scene().view
            }
    }
}
