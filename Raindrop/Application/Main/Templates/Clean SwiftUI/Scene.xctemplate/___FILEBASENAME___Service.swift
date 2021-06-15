//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ___VARIABLE_sceneName___Service {
    func validateText(_ value: String) throws
    func canSave() -> Bool
    func save() throws
}

extension ___VARIABLE_sceneName___ {
    
    enum ServiceError: Swift.Error {
        case saveFailed
    }
    
    enum ValidationError: Swift.Error {
        case empty
        case invalid
    }
    
    class Service: ___VARIABLE_sceneName___Service {
        private var text: String?
        
        func validateText(_ value: String) throws {
            if value.isEmpty { throw ValidationError.empty }
            text = value
        }
        
        func canSave() -> Bool {
            guard let text = text else { return false }
            return !text.isEmpty
        }
        
        func save() throws {
            throw ServiceError.saveFailed
        }
    }
    
    class PreviewService: ___VARIABLE_sceneName___Service {
        private var text: String?
        
        func validateText(_ value: String) throws {
            if value.isEmpty { throw ValidationError.empty }
            text = value
        }
        
        func canSave() -> Bool {
            guard let text = text else { return false }
            return !text.isEmpty
        }
        
        func save() throws {
            throw ServiceError.saveFailed
        }
    }
}
