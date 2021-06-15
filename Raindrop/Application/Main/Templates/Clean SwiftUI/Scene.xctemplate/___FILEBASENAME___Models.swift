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
        let isPresented: Binding<Bool>
        @Published var canSave: Bool = false
        @Published var error: ErrorSheet.ViewModel?
        @Published var text: String = ""
        @Published var textFieldState: ValidationError?
        
        init(isPresented: Binding<Bool>) {
            self.isPresented = isPresented
        }
    }
    
    struct Theme {
        static let tintColor = Color.appTintColor
        static let sceneTitle = Strings.sceneTitle
        static let backButtonTitle = Strings.cancelButtonTitle
        static let saveButtonTitle = Strings.saveButtonTitle
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

