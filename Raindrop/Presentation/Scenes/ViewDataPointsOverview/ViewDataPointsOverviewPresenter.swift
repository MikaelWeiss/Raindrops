//
//  ViewDataPointsOverviewPresenter.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/16/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ViewDataPointsOverviewPresenting {
    func present(canSave: Bool)
    func present(updatedText: String, error: Error?)
    func present(error: ViewDataPointsOverview.ServiceError)
    func presentDismiss()
}

extension ViewDataPointsOverview {
    
    struct Presenter: ViewDataPointsOverviewPresenting {
        
        let viewModel: ViewModel
        
        func present(canSave: Bool) {
            viewModel.canSave = canSave
        }
        
        func present(updatedText: String, error: Error?) {
            viewModel.text = updatedText
            viewModel.textFieldState = error as? ValidationError
        }
        
        func present(error: ServiceError) {
            viewModel.error = Strings.displayError(for: error)
        }
        
        func presentDismiss() {
            viewModel.isPresented.wrappedValue = false
        }
    }
}
