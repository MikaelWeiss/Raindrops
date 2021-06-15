//
//  EditDataPointPresenter.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
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
