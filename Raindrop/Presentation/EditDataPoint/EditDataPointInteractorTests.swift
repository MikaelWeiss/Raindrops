////
////  EditDataPointInteractorTests.swift
////  Raindrop
////
////  Created by Mikael Weiss on 5/4/21.
////  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import XCTest
//@testable import Raindrop
//
//class EditDataPointInteractorTests: XCTestCase {
//    private var service: EditDataPointServiceDouble!
//    private var presenter: EditDataPointPresenterDouble!
//    private var interactor: EditDataPointInteractor!
//    
//    func testUpdateTheme() {
//        // When
//        interactor.updateTheme()
//        
//        // Then
//        XCTAssertTrue(presenter.presentUpdateThemeCalled)
//    }
//    
//    func testDidChangeValue() {
//        // Given
//        let request = EditDataPoint.ValidateValue.Request(value: "Some new value")
//        
//        // When
//        interactor.didChangeValue(with: request)
//        
//        // Then
//        XCTAssertEqual(presenter.value, "Some new value")
//    }
//    
//    func testPrepareRouteToSheet() {
//        // When
//        interactor.prepareRouteToSheet()
//        
//        // Then
//        XCTAssertTrue(presenter.presentPrepareRouteToSheetCalled)
//    }
//    
//    func testPrepareRouteToOtherScene() {
//        // When
//        interactor.prepareRouteToOtherScene()
//        
//        // Then
//        XCTAssertTrue(presenter.presentPrepareRouteToOtherSceneCalled)
//    }
//    
//    // MARK: - Test Setup
//    
//    override func setUp() {
//        super.setUp()
//        service = EditDataPointServiceDouble()
//        presenter = EditDataPointPresenterDouble()
//        interactor = EditDataPointInteractor(service: service, presenter: presenter)
//    }
//    
//    // MARK: - Test Doubles
//    
//    // Either class, or struct with mutating functions
//    class EditDataPointPresenterDouble: EditDataPointPresenting {
//        var value: String?
//        var presentUpdateThemeCalled = false
//        var presentPrepareRouteToSheetCalled = false
//        var presentPrepareRouteToOtherSceneCalled = false
//        
//        func presentDidChangeValue(with response: EditDataPoint.ValidateValue.Response) {
//            value = response.value
//        }
//        
//        func presentUpdateTheme() {
//            presentUpdateThemeCalled = true
//        }
//        
//        func presentPrepareRouteToSheet() {
//            presentPrepareRouteToSheetCalled = true
//        }
//        
//        func presentPrepareRouteToOtherScene() {
//            presentPrepareRouteToOtherSceneCalled = true
//        }
//    }
//    
//    class EditDataPointServiceDouble: EditDataPointService {
//    }
//}
