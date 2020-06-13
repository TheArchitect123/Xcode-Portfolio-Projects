//
//  SWAPIConsumer_SwiftUITests.swift
//  SWAPIConsumer.SwiftUITests
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import XCTest
@testable import SWAPI;

class SWAPIConsumer_SwiftUITests: XCTestCase {

    func testRefreshItems() {
        //Find the refresh method
        let appRef = XCUIApplication.init();
        XCTAssertNoThrow(appRef.method(for: "SWAPIConsumer.Swift.RootTabBar.refreshItems"));
    }
    
    func testInitialiseSearch(){
        
        let appRef = XCUIApplication()
        appRef.navigationBars["SWAPIConsumer.Swift.RootTabBar"].buttons["Search"].tap()
        
        XCTAssertTrue(true, "Success");
    }
    
    func testActivateApp(){
        XCTAssertNoThrow(XCUIApplication.init().activate());
    }
    
    func testDialogueOutput(){
        XCTAssertNoThrow(DialogueHelper.showDialogWithSimpleMessage(message: "Successful Dialogue"));
    }
    
    func testSnackBar(){
        XCTAssertNoThrow(SnackbarHelper.showSnackBarWithMessage(message: "Successful Snack Bar Message"));
    }
}
