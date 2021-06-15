//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ___VARIABLE_sceneName___Interacting {
    func dismiss()
    func save()
    func createDefaultError()
    func createServiceError()
}

protocol ___VARIABLE_sceneName___Interacting {
    func dismiss()
    func save()
    func updateText(_ value: String)
}

extension ___VARIABLE_sceneName___ {
    
    struct Interactor: ___VARIABLE_sceneName___Interacting {
        let service: ___VARIABLE_sceneName___Service
        let presenter: ___VARIABLE_sceneName___Presenting
        
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
