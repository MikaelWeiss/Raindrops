//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension ___VARIABLE_sceneName___ {
    
    class ViewModel: ObservableObject {
        let theme = Theme()
        @Published var canSave: Bool = false
        @Published var error: ErrorSheet.ViewModel?
        @Published var text: String = ""
        @Published var textFieldState: ValidationError?
    }
    
    // MARK: - Theme: non-changing visual information that should be accessible to view via ViewModel
    
    struct Theme {
        let tintColor = Color.appTintColor
        let sceneTitle = Strings.sceneTitle
        let backButtonTitle = Strings.cancelButtonTitle
        let saveButtonTitle = Strings.saveButtonTitle
    }
    
    enum Strings {
        static let sceneTitle = "Edit Data Point"
        static let cancelButtonTitle = "Cancel"
        static let saveButtonTitle = "Save"
        
        static func displayError(for error: ServiceError) -> ErrorSheet.ViewModel {
            switch error {
            case .saveFailed:
                return .saveFailed
            }
        }
    }
}

