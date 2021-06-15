//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import ___PROJECTNAMEASIDENTIFIER___

class ___VARIABLE_sceneName___PresenterTests: XCTestCase {
    
    // System under test
    var presenter: ___VARIABLE_sceneName___.Presenter!
    
    // MARK: - Test
    
    func testPresentSomething() throws {
        // Call presentSomething() on the presenter.
        // Then assert that the state of presenter.viewModel
        // matches your expectations
    }
    
    func testPresentDefaultError() throws {
        // When
        presenter.presentDefaultError()
        
        // Then
        XCTAssertEqual(presenter.viewModel.error?.title, DisplayError.default.title)
        XCTAssertEqual(presenter.viewModel.error?.body, DisplayError.default.body)
        XCTAssertEqual(presenter.viewModel.error?.dismissButtonTitle, DisplayError.default.dismissButtonTitle)
    }
    
    // MARK: - Setup
    
    override func setUp() {
        presenter = .init()
    }
}
