//
//  EditDataPointInteractorTests.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import Raindrop
import XCTest

class EditDataPointInteractorTests: XCTestCase {

    // System under test
    var interactor: EditDataPoint.Interactor!
    
    // Dependencies
    var serviceDouble: ServiceDouble!
    var presenterDouble: PresenterDouble!
    var routerDouble: RouterDouble!
    
    // MARK: - Test
    
    func testDismiss() {
        // When
        interactor.dismiss()
        
        // Then
        XCTAssertEqual(routerDouble.routeToPreviousCalled, true)
    }
    
    func testCreateDefaultError() {
        // When
        interactor.createDefaultError()
        
        // Then
        XCTAssertEqual(presenterDouble.presentDefaultErrorCalled, true)
    }
    
    // MARK: - Setup
    
    override func setUp() {
        serviceDouble = ServiceDouble()
        presenterDouble = PresenterDouble()
        routerDouble = RouterDouble()
        interactor = .init(
            service: serviceDouble,
            presenter: presenterDouble,
            router: routerDouble)
    }
    
    // MARK: - Helpers
    
    // MARK: - Doubles
    
    class ServiceDouble: EditDataPointService {
        
    }
    
    class PresenterDouble: EditDataPointPresenting {
        var presentErrorCalled: Bool?
        var presentDefaultErrorCalled: Bool?
        
        func present(error: EditDataPoint.ServiceError) {
            presentErrorCalled = true
        }
        
        func presentDefaultError() {
            presentDefaultErrorCalled = true
        }
    }
    
    class RouterDouble: EditDataPointRouting {
        var routeToPreviousCalled: Bool?
        
        func routeToPrevious() {
            routeToPreviousCalled = true
        }
    }
}
