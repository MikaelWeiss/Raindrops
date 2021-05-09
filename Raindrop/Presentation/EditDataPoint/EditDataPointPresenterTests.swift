////
////  EditDataPointPresenterTests.swift
////  Raindrop
////
////  Created by Mikael Weiss on 5/4/21.
////  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import XCTest
//@testable import Raindrop
//
//class EditDataPointPresenterTests: XCTestCase {
//    private var presenter: EditDataPointPresenter!
//    private var viewModel: EditDataPoint.ViewModel!
//    
//    func testPresentUpdateTheme() {
//        // When
//        presenter.presentUpdateTheme()
//        
//        // Then
//        XCTAssertEqual(viewModel.title, EditDataPoint.Strings.sceneTitle)
//        XCTAssertEqual(viewModel.textFieldTitle, EditDataPoint.Strings.textFieldTitle)
//    }
//    
//    func testPresentDidChangeValue() {
//        // Given
//        let response = EditDataPoint.ValidateValue.Response(value: "Some value")
//        
//        // When
//        presenter.presentDidChangeValue(with: response)
//        
//        // Then
//        XCTAssertEqual(viewModel.textFieldValue, "Some value")
//    }
//    
//    func testPresentPrepareRouteToSheet() {
//        // When
//        presenter.presentPrepareRouteToSheet()
//        
//        // Then
//        XCTAssertTrue(viewModel.isShowingSheet)
//    }
//    
//    func testPresentPrepareRouteToOtherScene() {
//        // When
//        presenter.presentPrepareRouteToOtherScene()
//        
//        // Then
//        XCTAssertTrue(viewModel.isShowingOtherScene)
//    }
//    
//    // MARK: - Test Setup
//    
//    override func setUp() {
//        super.setUp()
//        presenter = EditDataPointPresenter()
//        viewModel = presenter.viewModel
//    }
//}
//
//
//
