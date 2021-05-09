//
//  EditDataPointPresenter.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol EditDataPointPresenting {
    func presentHandleError(with response: EditDataPoint.HandleError.Response)
    func presentFetchValues(with response: EditDataPoint.FetchValues.Response)
}

extension EditDataPoint {
    struct Presenter: EditDataPointPresenting {
        let viewModel = EditDataPoint.ViewModel()
        
        func presentHandleError(with response: HandleError.Response) {
            
        }
        
        func presentFetchValues(with response: EditDataPoint.FetchValues.Response) {
            
        }
    }
}
