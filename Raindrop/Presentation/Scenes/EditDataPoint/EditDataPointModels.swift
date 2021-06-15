//
//  EditDataPointModels.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditDataPoint {
    
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
