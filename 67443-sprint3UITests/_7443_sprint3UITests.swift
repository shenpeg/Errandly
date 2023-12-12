//
//  _7443_sprint3UITests.swift
//  67443-sprint3UITests
//
//  Created by Ohnyoo Esther Bae on 12/7/23.
//

// note for deubugging:
// print(app.debugDescription)
// OR
// print(app.______.debugDescription)

import XCTest

final class _7443_sprint3UITests: XCTestCase {
  let app = XCUIApplication()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    executionTimeAllowance = 60
    continueAfterFailure = false
    app.launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  // welcome + tutorial
  
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
  
  func testFullTutorial() throws {
    let tutorial = app.staticTexts["Welcome to Errandly!"]
    if (tutorial.exists) {
      let welcomeNext = app.buttons["Next"]
      XCTAssert(welcomeNext.exists)
      welcomeNext.tap()
      
      let browseText = app.staticTexts["Here is where you browse errands posted by others"]
      XCTAssert(browseText.exists)
      let browseNext = app.buttons["Next"]
      XCTAssert(browseNext.exists)
      browseNext.tap()
      
      let postText = app.staticTexts["You can post an errand of your own for others to help you with"]
      XCTAssert(postText.exists)
      let postNext = app.buttons["Next"]
      XCTAssert(postNext.exists)
      postNext.tap()
      
      let profileText = app.staticTexts["Your posting history & info is saved in your profile, which you can edit there"]
      XCTAssert(profileText.exists)
      let profileNext = app.buttons["Next"]
      XCTAssert(profileNext.exists)
      profileNext.tap()
      
      let rewatchText = app.staticTexts["Rewatch the tutorial anytime up here!"]
      XCTAssert(rewatchText.exists)
      let rewatchNext = app.buttons["Next"]
      XCTAssert(rewatchNext.exists)
      rewatchNext.tap()
      
      let endText = app.staticTexts["You're ready to go :)"]
      XCTAssert(endText.exists)
      let endGo = app.buttons["Let's go!"]
      XCTAssert(endGo.exists)
      endGo.tap()
      
      // marketplace view appears
      let sort = app.buttons["sort by"]
      XCTAssert(sort.exists)
      
      let tag = app.buttons["tag"]
      XCTAssert(tag.exists)
    }
  }
  
  func testTutorialReplay() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let tutorial = app.buttons["tutorial replay button"]
    XCTAssert(tutorial.exists)
    tutorial.tap()
    
    let skipAgain = app.buttons["Skip"]
    XCTAssert(skipAgain.exists)
    skipAgain.tap()
  }
  
  // marketplace tab
  
  func testSort() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let sort = app.buttons["sort by"]
    XCTAssert(sort.exists)
    sort.tap()
    
    let recent = app.buttons["Recent"]
    XCTAssert(recent.exists)
    recent.tap()
    
    let dueDate = app.buttons["Due Date"]
    XCTAssert(dueDate.exists)
    dueDate.tap()
    
    let compensation = app.buttons["Compensation"]
    XCTAssert(compensation.exists)
    compensation.tap()
  }
  
  func testTags() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let onCampus = app.buttons["on-campus"]
    XCTAssert(onCampus.exists)
    onCampus.tap()
    // tap again
    onCampus.tap()
    
    let offCampus = app.buttons["off-campus"]
    XCTAssert(offCampus.exists)
    offCampus.tap()
    
    // tag that requires scrolling
    let car = app.buttons["car"]
    XCTAssert(car.exists)
    car.tap()
  }
  
  func testLocation() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let location = app.buttons["location button"]
    XCTAssert(location.exists)
    location.tap()
  }
  
  func testErrandDetail() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    let view = app.otherElements.buttons["view details"]
    XCTAssert(view.exists)
    let firstErrand = view.firstMatch
    firstErrand.tap()
    
    let date = app.staticTexts["Date Due:"]
    XCTAssert(date.exists)
  }
  
  func testMessage() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    let view = app.otherElements.buttons["view details"]
    XCTAssert(view.exists)
    let firstErrand = view.firstMatch
    firstErrand.tap()
    
    let msg = app.buttons["message"]
    XCTAssert(msg.exists)
    msg.tap()
  }
  
  func testErrandEdit() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    while (!app.staticTexts["your post"].exists) {
      app.swipeUp()
    }
    
    let yourErrands = app.staticTexts["your post"]
    XCTAssert(yourErrands.exists)
    let yourFirstErrand = yourErrands.firstMatch
    yourFirstErrand.tap()
    
    let editErrand = app.otherElements.buttons["edit errand"]
    XCTAssert(editErrand.exists)
    editErrand.tap()
  }
  
  func testErrandDeleteCancel() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    while (!app.staticTexts["your post"].exists) {
      app.swipeUp()
    }
    
    let yourErrands = app.staticTexts["your post"]
    XCTAssert(yourErrands.exists)
    let yourFirstErrand = yourErrands.firstMatch
    yourFirstErrand.tap()
    
    let editErrand = app.otherElements.buttons["edit errand"]
    XCTAssert(editErrand.exists)
    editErrand.tap()
    
    let delete = app.buttons["Delete errand"]
    XCTAssert(delete.exists)
    delete.tap()
    
    let deleteAlert = app.alerts["Delete this errand permanently?"]
    XCTAssert(deleteAlert.exists)
    let cancel = deleteAlert.buttons["No, cancel"]
    XCTAssert(cancel.exists)
    cancel.tap()
  }
  
  // post errand tab
  
  func testPost() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let postTab = app.buttons["Post Errand"]
    XCTAssert(postTab.exists)
    postTab.tap()
    
    app.swipeUp()
    let post = app.buttons["Post"]
    XCTAssert(post.exists)
    post.tap()
    
    let titlePostError = app.alerts["Please enter a title for your errand!"]
    XCTAssert(titlePostError.exists)
    let dismiss = titlePostError.buttons["OK"]
    XCTAssert(dismiss.exists)
    dismiss.tap()
    
    // errand title
    app.swipeDown()
    let titleInput = app.textFields["Errand Title"]
    XCTAssert(titleInput.exists)
    titleInput.tap()
    titleInput.typeText("UITests")
    
    app.swipeUp()
    XCTAssert(post.exists)
    post.tap()
    
    let detailsPostError = app.alerts["Please write some details on what you need help with"]
    XCTAssert(detailsPostError.exists)
    XCTAssert(dismiss.exists)
    dismiss.tap()

    // errand details
    app.swipeDown()
    let detailsInput = app.textViews["What do you need help with?"]
    XCTAssert(detailsInput.exists)
    detailsInput.tap()
    detailsInput.typeText("how to write swiftui tests")
  }
  
  // profile tab
  
  func testProfile() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    XCTAssert(app.buttons["Sign out"].exists)
  }
  
  func testProfileTabs() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    let pickedUpTab = app.staticTexts["Picked Up Errands"]
    XCTAssert(pickedUpTab.exists)
    pickedUpTab.tap()
    
    let postedTab = app.staticTexts["Posted Errands"]
    XCTAssert(postedTab.exists)
    postedTab.tap()
  }
  
  func testProfileEdit() throws {
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    let edit = app.otherElements.buttons["edit profile"]
    XCTAssert(edit.exists)
    edit.tap()
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
