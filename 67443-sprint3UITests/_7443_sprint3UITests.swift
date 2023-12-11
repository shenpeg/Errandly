//
//  _7443_sprint3UITests.swift
//  67443-sprint3UITests
//
//  Created by Ohnyoo Esther Bae on 12/7/23.
//

import XCTest

final class _7443_sprint3UITests: XCTestCase {
  let app = XCUIApplication()

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    app.launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testWelcome() throws {
    let welcome = app.staticTexts["Welcome!"]
    // Use XCTAssert and related functions to verify your tests produce welcome page
    if (welcome.exists) {
      let cont = app.buttons["Continue"]
      XCTAssert(cont.exists)
      cont.tap()
      
      let login = app.buttons["loginButton"]
      XCTAssert(login.exists)
      login.tap()
    }
  }
  
  func testTutorial() throws {
    let tutorial = app.staticTexts["Welcome to Errandly!"]
    if (tutorial.exists) {
      let next = app.buttons["Next"]
      XCTAssert(next.exists)
      next.tap()
      
      let skip = app.buttons["Skip"]
      XCTAssert(skip.exists)
      skip.tap()
      
      // marketplace view appears
      let sort = app.buttons["sort by"]
      XCTAssert(sort.exists)
    
      
      let tag = app.buttons["tag"]
      XCTAssert(tag.exists)
    }
  }
  
  func testPost() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let post = app.buttons["Post Errand"]
    XCTAssert(post.exists)
    post.tap()
    
    app.textFields["Errand Title"].tap()
    app.textFields["Errand Title"].typeText("Testing UITests")
    app.keyboards.buttons["Return"].tap()
    
    // post button should not be available until everything has been filled out
    // XCTAssertFalse(postButton.waitForExistence(timeout: 0.5))
    
    app.textFields["helpText"].tap()
    app.textFields["helpText"].typeText("how to write swiftui tests")
    app.keyboards.buttons["Return"].tap()
    
    // post button should not be available until everything has been filled out
    // XCTAssertFalse(postButton.waitForExistence(timeout: 0.5))
    
    let postButton = app.buttons["Post"]
    XCTAssert(postButton.exists)
    postButton.tap()
  }
  
  func testProfile() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    XCTAssert(app.buttons["Sign out"].exists)
  }
  
  func testErrandDetail() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    // let view = app.buttons["view details"]
//    XCTAssert(view.exists)
//    view.tap()
//
//    let date = app.staticTexts["Date Due:"]
//    XCTAssert(date.exists)
//
//    let pick = app.buttons["Pick up errrand"]
//    XCTAssert(pick.exists)
//    pick.tap()
//
//    let yes = app.staticTexts["Yes, I'm sure"]
//    XCTAssert(yes.exists)
//    yes.tap()
//
//    XCTAssert(app.staticTexts["Picked Up Errands"].exists)
  }

  func testMessage() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    // let view = app.buttons["view details"]
    // XCTAssert(view.exists)
    // view.tap()
    
    // let msg = app.buttons["message"]
    // XCTAssert(msg.exists)
    // msg.tap()
  }

  
  func testLaunchPerformance() throws {
      if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
          // This measures how long it takes to launch your application.
          measure(metrics: [XCTApplicationLaunchMetric()]) {
              XCUIApplication().launch()
          }
      }
  }
}