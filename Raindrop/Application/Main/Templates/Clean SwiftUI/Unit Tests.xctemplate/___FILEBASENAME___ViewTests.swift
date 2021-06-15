//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import ___PROJECTNAMEASIDENTIFIER___

class ___VARIABLE_sceneName___ViewTests: XCTestCase {
    private var interactor: ___VARIABLE_sceneName___InteractorDouble!
    private var viewModel: ___VARIABLE_sceneName___.ViewModel!
    private var view: ___VARIABLE_sceneName___View!
    
    func testDidChangeValue() {
        // When
        view.didChangeValue(to: "Some Value")
        
        // Then
        XCTAssertEqual(interactor.value, "Some Value")
    }
    
    func testPrepareRouteToSheet() {
        // When
        view.prepareRouteToSheet()
        
        // Then
        XCTAssertTrue(interactor.prepareRouteToSheetCalled)
    }
    
    func testPrepareRouteToOtherScene() {
        // When
        view.prepareRouteToOtherScene()
        
        // Then
        XCTAssertTrue(interactor.prepareRouteToOtherSceneCalled)
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        interactor = ___VARIABLE_sceneName___InteractorDouble()
        viewModel = ___VARIABLE_sceneName___.ViewModel()
        view = ___VARIABLE_sceneName___View(interactor: interactor, viewModel: viewModel)
    }
    
    // MARK: - Test Doubles
    
    class ___VARIABLE_sceneName___InteractorDouble: ___VARIABLE_sceneName___Requesting {
        var value: String?
        var updateThemeCalled = false
        var prepareRouteToSheetCalled = false
        var prepareRouteToOtherSceneCalled = false
        
        func didChangeValue(with request: ___VARIABLE_sceneName___.ValidateValue.Request) {
            value = request.value
        }
        
        func updateTheme() {
            updateThemeCalled = true
        }
        
        func prepareRouteToSheet() {
            prepareRouteToSheetCalled = true
        }
        
        func prepareRouteToOtherScene() {
            prepareRouteToOtherSceneCalled = true
        }
    }
}
