//
//  EditDataPointInteractor.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditDataPointRequesting {
    func fetchValues()
}

extension EditDataPoint {
    struct Interactor: EditDataPointRequesting {
        private let service: EditDataPointService
        private let presenter: EditDataPointPresenting
        
        init(service: EditDataPointService, presenter: EditDataPointPresenting) {
            self.service = service
            self.presenter = presenter
        }
        
        func fetchValues() {
            throwingCall {
                let dataPointValues = try service.fetchDataPointValues()
                let response = FetchValues.Response(dataPointValues: dataPointValues)
                presenter.presentFetchValues(with: response)
            }
        }
        
        private func throwingCall(_ call: () throws -> Void) {
            do {
                try call()
            } catch {
                
            }
        }
        
        private func handleError(_ error: Error) {
            let response = HandleError.Response(error: error)
            presenter.presentHandleError(with: response)
        }
    }
}
