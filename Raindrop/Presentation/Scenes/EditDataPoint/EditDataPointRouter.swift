//
//  EditDataPointRouter.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditDataPointRouting {
    func routeToPrevious()
}

extension EditDataPoint {
    
    class Router: EditDataPointRouting {
        weak var hostingController: UIViewController?
        
        func routeToPrevious() {
            hostingController?.dismiss(animated: true, completion: nil)
        }
    }
}
