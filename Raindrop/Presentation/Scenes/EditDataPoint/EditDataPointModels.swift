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
