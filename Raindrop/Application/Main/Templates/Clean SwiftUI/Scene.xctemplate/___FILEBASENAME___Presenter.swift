//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ___VARIABLE_sceneName___Presenting {
    func present(canSave: Bool)
    func present(updatedText: String, error: Error?)
    func present(error: ___VARIABLE_sceneName___.ServiceError)
}

extension ___VARIABLE_sceneName___ {
    
    struct Presenter: ___VARIABLE_sceneName___Presenting {
        
        let viewModel = ViewModel()
        
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
    }
}
