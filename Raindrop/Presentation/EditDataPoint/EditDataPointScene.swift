//
//  EditDataPointScene.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum EditDataPoint {
    struct Scene {
        private(set) var view: EditDataPointView?
        
        init() {
            let service = buildService()
            let presenter = Presenter()
            let interactor = Interactor(service: service, presenter: presenter)
            view = EditDataPointView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private func buildService() -> EditDataPointService {
            guard let input = EditDataPoint.input else { fatalError("Missing input") }
            
            let repositories = RepositoryRoot.shared
            
            return EditDataPoint.Service(dataPointID: input.dataPointID, dataPointFetcher: repositories.dataPointRepository)
        }
    }
    
    struct Input {
        let dataPointID: UUID?
    }
    private(set) static var input: Input?
    static func prepareIncomingRoute(dataPointID: UUID?) {
        input = Input(dataPointID: dataPointID)
    }
}
