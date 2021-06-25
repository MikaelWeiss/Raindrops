//
//  ViewDataPointsOverviewScene.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/16/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum ViewDataPointsOverview {
    
    // MARK: - Build scene
    
    struct Scene {
        
        func view(preview: Bool = false, isPresented: Binding<Bool>) -> some View {
            let service: ViewDataPointsOverviewService = preview ? PreviewService() : buildService()
            let presenter = Presenter(viewModel: ViewModel(isPresented: isPresented))
            let interactor = Interactor(service: service, presenter: presenter)
            let view = ContentView(viewModel: presenter.viewModel, interactor: interactor)
            return view
        }
        
        private func buildService() -> Service {
//            guard let input = EditDataPoint.input
//            else { fatalError("Required input is missing (\(#file))") }
//            EditDataPoint.input = nil
            
            return Service()
        }
    }
    
    // MARK: - Scene input
    
    static func prepareIncomingRoute(with requiredThing: String) {
        input = Input(requiredThing: requiredThing)
    }
    struct Input {
        let requiredThing: String
    }
    static var input: Input?
}
