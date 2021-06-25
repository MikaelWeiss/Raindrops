//
//  ViewDataPointsOverviewInteractor.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/16/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ViewDataPointsOverviewInteracting {
    func dismiss()
    func save()
    func updateText(_ value: String)
}

extension ViewDataPointsOverview {
    
    struct Interactor: ViewDataPointsOverviewInteracting {
        let service: ViewDataPointsOverviewService
        let presenter: ViewDataPointsOverviewPresenting
        
        func dismiss() {
            presenter.presentDismiss()
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
