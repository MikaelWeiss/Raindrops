//
//  EditDataPointModels.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/15/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditDataPoint {
    
    class ViewModel: ObservableObject {
        let isPresented: Binding<Bool>
        @Published var canSave: Bool = false
        @Published var error: ErrorSheet.ViewModel?
        @Published var text: String = ""
        @Published var textFieldState = DataEntryCellState.normal
        @Published var textFieldInfoMessage: String?
        
        init(isPresented: Binding<Bool>) {
            self.isPresented = isPresented
        }
    }
    
    struct Theme {
        static let tintColor = Color.appTintColor
        static let sceneTitle = Strings.sceneTitle
        static let backButtonTitle = Strings.cancelButtonTitle
        static let saveButtonTitle = Strings.saveButtonTitle
        static let currencySymbol = Locale.current.currencySymbol ?? "$"
        static let textFieldTitle = Strings.textFieldTitle
    }
    
    enum Strings {
        static let sceneTitle = "Edit Data Point"
        static let cancelButtonTitle = "Cancel"
        static let saveButtonTitle = "Save"
        static let emptyErrorInfoMessage = "Field must not be empty"
        static let invalidErrorInfoMessage = "Entered value is invalid"
        static let textFieldTitle = "Something"
        
        static func displayError(for error: ServiceError) -> ErrorSheet.ViewModel {
            switch error {
            case .saveFailed:
                return .saveFailed
            }
        }
    }
}
