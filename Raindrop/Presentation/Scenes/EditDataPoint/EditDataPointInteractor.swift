//
//  EditDataPointInteractor.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditDataPointInteracting {
    func dismiss()
    func save()
    func updateText(_ value: String)
}

extension EditDataPoint {
    
    struct Interactor: EditDataPointInteracting {
        let service: EditDataPointService
        let presenter: EditDataPointPresenting
        let router: EditDataPointRouting
        
        func dismiss() {
            router.routeToPrevious()
        }
        
        func save() {
            do {
                try service.save()
            } catch {
                presenter.present(error: .saveFailed)
            }
        }
        
        func updateText(_ value: String) {
            do {
                try service.validateText(value)
                presenter.present(updatedText: value, error: nil)
            } catch {
                presenter.present(updatedText: value, error: error)
            }
            checkCanSave()
        }
        
        private func checkCanSave() {
            presenter.present(canSave: service.canSave())
        }
    }
}
