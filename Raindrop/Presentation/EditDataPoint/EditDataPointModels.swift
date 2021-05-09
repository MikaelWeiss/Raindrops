//
//  EditDataPointModels.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

extension EditDataPoint {
    
    enum FetchValues {
        struct Response {
            let dataPointValues: DataPointValues
        }
    }
    
    enum HandleError {
        struct Response {
            let error: Error
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Some title", comment: "The title for the scene")
        static let textFieldTitle = NSLocalizedString("Some title", comment: "The title for some text field")
    }
    
    class ViewModel: ObservableObject {
        @Published var title = ""
        @Published var textFieldTitle = ""
        @Published var textFieldValue = ""
        @Published var isShowingOtherScene = false
        @Published var isShowingSheet = false
    }
}
