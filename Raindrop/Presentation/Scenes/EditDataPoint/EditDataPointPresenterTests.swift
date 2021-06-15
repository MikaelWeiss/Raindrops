//
//  EditDataPointPresenterTests.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import Raindrop
import XCTest

class EditDataPointPresenterTests: XCTestCase {

    // System under test
    var presenter: EditDataPoint.Presenter!
    
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
