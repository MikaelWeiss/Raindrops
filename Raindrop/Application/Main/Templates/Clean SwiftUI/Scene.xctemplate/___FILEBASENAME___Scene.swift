//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum ___VARIABLE_sceneName___ {
    
    // MARK: - Build scene
    
    struct Scene {
        
        func view(preview: Bool = false) -> some View {
            let service: ___VARIABLE_sceneName___Service = preview ? PreviewService() : buildService()
            let presenter = Presenter()
            let router = Router()
            let interactor = Interactor(service: service, presenter: presenter, router: router)
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
