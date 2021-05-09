////
////  EditDataPointViewTests.swift
////  Raindrop
////
////  Created by Mikael Weiss on 5/4/21.
////  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import XCTest
//@testable import Raindrop
//
//class EditDataPointViewTests: XCTestCase {
//    private var interactor: EditDataPointInteractorDouble!
//    private var viewModel: EditDataPoint.ViewModel!
//    private var view: EditDataPointView!
//    
//    func testDidChangeValue() {
//        // When
//        view.didChangeValue(to: "Some Value")
//        
//        // Then
//        XCTAssertEqual(interactor.value, "Some Value")
//    }
//    
//    func testPrepareRouteToSheet() {
//        // When
//        view.prepareRouteToSheet()
//        
//        // Then
//        XCTAssertTrue(interactor.prepareRouteToSheetCalled)
//    }
//    
//    func testPrepareRouteToOtherScene() {
//        // When
//        view.prepareRouteToOtherScene()
//        
//        // Then
//        XCTAssertTrue(interactor.prepareRouteToOtherSceneCalled)
//    }
//    
//    // MARK: - Test Setup
//    
//    override func setUp() {
//        super.setUp()
//        interactor = EditDataPointInteractorDouble()
//        viewModel = EditDataPoint.ViewModel()
//        view = EditDataPointView(interactor: interactor, viewModel: viewModel)
//    }
//    
//    // MARK: - Test Doubles
//    
//    class EditDataPointInteractorDouble: EditDataPointRequesting {
//        var value: String?
//        var updateThemeCalled = false
//        var prepareRouteToSheetCalled = false
//        var prepareRouteToOtherSceneCalled = false
//        
//        func didChangeValue(with request: EditDataPoint.ValidateValue.Request) {
//            value = request.value
//        }
//        
//        func updateTheme() {
//            updateThemeCalled = true
//        }
//        
//        func prepareRouteToSheet() {
//            prepareRouteToSheetCalled = true
//        }
//        
//        func prepareRouteToOtherScene() {
//            prepareRouteToOtherSceneCalled = true
//        }
//    }
//}
