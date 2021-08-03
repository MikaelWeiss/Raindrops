//
//  EditDataPointPresenter.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/15/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditDataPointPresenting {
    func present(canSave: Bool)
    func present(updatedText: String, error: Error?)
    func present(error: EditDataPoint.ServiceError)
    func presentDismiss()
}

extension EditDataPoint {
    
    struct Presenter: EditDataPointPresenting {
        
        let viewModel: ViewModel
        
        func present(canSave: Bool) {
            viewModel.canSave = canSave
        }
        
        func present(updatedText: String, error: Error?) {
            viewModel.text = updatedText
            if let error = error as? ValidationError {
                switch error {
                case .empty: viewModel.textFieldInfoMessage = Strings.emptyErrorInfoMessage
                case .invalid: viewModel.textFieldInfoMessage = Strings.invalidErrorInfoMessage
                }
                viewModel.textFieldState = .error
            }
        }
        
        func present(error: ServiceError) {
            viewModel.error = Strings.displayError(for: error)
        }
        
        func presentDismiss() {
            viewModel.isPresented.wrappedValue = false
        }
    }
}
