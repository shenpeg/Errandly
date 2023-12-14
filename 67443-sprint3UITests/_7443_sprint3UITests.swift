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

// test requirements:
// successfully logged into the app
// has posted at least errand

import XCTest

final class _7443_sprint3UITests: XCTestCase {
  let app = XCUIApplication()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    executionTimeAllowance = 120
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
    sleep(1)
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
    sleep(1)
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
    sleep(1)
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
    sleep(1)
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
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let onCampus = app.buttons["📚 on-campus"]
    XCTAssert(onCampus.exists)
    onCampus.tap()
    // tap again
    onCampus.tap()
    
    let offCampus = app.buttons["🏙️ off-campus"]
    XCTAssert(offCampus.exists)
    offCampus.tap()
    
    // tag that requires scrolling
    let car = app.buttons["🚗 car"]
    XCTAssert(car.exists)
    car.tap()
  }
  
  func testLocation() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    let location = app.buttons["location button"]
    XCTAssert(location.exists)
    location.tap()
  }
  
  func testErrandDetail() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    let view = app.otherElements.buttons["view details"]
    XCTAssert(view.exists)
    let firstErrand = view.firstMatch
    firstErrand.tap()
    
    let date = app.staticTexts["Date Due: "]
    XCTAssert(date.exists)
  }
  
  func testMessage() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    
    // navigate to errandDetailsView
    let errands = app.otherElements.buttons.matching(identifier: "view details")
    
    for i in 0...errands.count {
      let errand = errands.element(boundBy: i)
      if (!errand.staticTexts["your post"].exists) {
        // not your post
        errand.tap()
        let msg = app.buttons["message"]
        XCTAssert(msg.exists)
        msg.tap()
        break
      }
    }

  }
  
  func testErrandEditView() throws {
    sleep(1)
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
    sleep(1)
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
    
    app.swipeUp()
    let delete = app.buttons["delete errand"]
    XCTAssert(delete.exists)
    delete.tap()
    
    let deleteAlert = app.alerts["Delete this errand permanently?"]
    XCTAssert(deleteAlert.exists)
    let cancel = deleteAlert.buttons["No, cancel"]
    XCTAssert(cancel.exists)
    cancel.tap()
  }
  
  // post errand tab
  
  func testPostEditDelete() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    sleep(1)
    
    let postTab = app.buttons["Post Errand"]
    XCTAssert(postTab.exists)
    postTab.tap()
    
    app.swipeUp()
    let post = app.buttons["Post"]
    XCTAssert(post.exists)
    post.tap()
    
    let titlePostError = app.alerts["Please enter a title for your errand!"]
    XCTAssert(titlePostError.exists)
    let titlePostDismiss = titlePostError.buttons["OK"]
    XCTAssert(titlePostDismiss.exists)
    titlePostDismiss.tap()
    
    // errand title
    app.swipeDown()
    let titleInput = app.textFields["Errand Title"]
    XCTAssert(titleInput.exists)
    titleInput.tap()
    sleep(1)
    titleInput.typeText("Abc")
    sleep(1)
    
    app.swipeUp()
    XCTAssert(post.exists)
    post.tap()
    
    let detailsPostError = app.alerts["Please write some details on what you need help with"]
    XCTAssert(detailsPostError.exists)
    let detailsPostDismiss = detailsPostError.buttons["OK"]
    XCTAssert(detailsPostDismiss.exists)
    detailsPostDismiss.tap()

    // errand details
    app.swipeDown()
    let detailsInput = app.textViews["What do you need help with?"]
    XCTAssert(detailsInput.exists)
    detailsInput.tap()
    sleep(1)
    detailsInput.typeText("xyz")
    sleep(1)

    app.swipeUp()
    XCTAssert(post.exists)
    post.tap()
    
    let locationPostError = app.alerts["Please enter a location"]
    XCTAssert(locationPostError.exists)
    let locationPostDismiss = locationPostError.buttons["OK"]
    XCTAssert(locationPostDismiss.exists)
    locationPostDismiss.tap()
    
    // errand tags
    let onCampus = app.buttons["📚 on-campus"]
    XCTAssert(onCampus.exists)
    onCampus.tap()
    
    let car = app.buttons["🚗 car"]
    XCTAssert(car.exists)
    car.tap()
    
    // errand location
    let locationInput = app.textFields["location search"]
    XCTAssert(locationInput.exists)
    locationInput.tap()
    sleep(1)
    locationInput.typeText("Carnegie Mellon University")
    sleep(1)
    // dismiss keyboard (necessary to select the result)
    if app.keys.element(boundBy: 0).exists {
        app.typeText("\n")
    }
    
    let results = app.buttons["location result"]
    XCTAssert(results.exists)
    let firstResult = results.firstMatch
    firstResult.tap()
    sleep(1)
    
    // errand compensation
    var payInput = app.textFields["pay input"]
    XCTAssert(payInput.exists)
    payInput.tap()
    sleep(1)
//    payInput.typeText("0.01")
    payInput.typeText("0")
    sleep(1)
    
    XCTAssert(post.exists)
    post.tap()
    sleep(1)

    let payAmountError = app.alerts["If you choose to pay the runner, please enter an amount over $1.00"]
    XCTAssert(payAmountError.exists)
    let payAmountDismiss = payAmountError.buttons["OK"]
    XCTAssert(payAmountDismiss.exists)
    payAmountDismiss.tap()
    
    payInput = app.textFields["0"]
    XCTAssert(payInput.exists)
    payInput.tap()
    sleep(1)
    //\u{8} for deletion
    // https://stackoverflow.com/questions/40380176/how-to-clear-value-in-textfield-using-xcode-ui-tests
    payInput.typeText("\u{8}1.123")
    sleep(1)
    
    XCTAssert(post.exists)
    post.tap()
    sleep(1)

    let payFormatError = app.alerts["Please enter a valid amount with only up to two decimal places for compensation"]
    XCTAssert(payFormatError.exists)
    let payFormatDismiss = payFormatError.buttons["OK"]
    XCTAssert(payFormatDismiss.exists)
    payFormatDismiss.tap()
    
    payInput = app.textFields["1.123"]
    XCTAssert(payInput.exists)
    payInput.tap()
    payInput.typeText("\u{8}")
    sleep(1)
    
    // post errand and check if exists
    
    XCTAssert(post.exists)
    post.tap()
    sleep(2)
        
    let postedErrand = app.staticTexts["Abc"]
    XCTAssert(postedErrand.exists)
    
    // edit the posted errand
    
    postedErrand.tap()
    var editErrand = app.otherElements.buttons["edit errand"]
    XCTAssert(editErrand.exists)
    editErrand.tap()
    
    
    let editTitleEmpty = app.textFields["Abc"]
    XCTAssert(editTitleEmpty.exists)
    editTitleEmpty.tap()
    editTitleEmpty.typeText("\u{8}\u{8}\u{8}")
    
    app.swipeUp()
    let edit = app.buttons["Save edits"]
    XCTAssert(edit.exists)
    edit.tap()
    sleep(1)
    
    let titleSaveError = app.alerts["Please enter a title for your errand!"]
    XCTAssert(titleSaveError.exists)
    let titleSaveDismiss = titleSaveError.buttons["OK"]
    XCTAssert(titleSaveDismiss.exists)
    titleSaveDismiss.tap()
    sleep(1)
    
    app.swipeDown()
    let editTitle = app.textFields["Errand Title"]
    XCTAssert(editTitle.exists)
    editTitle.tap()
    editTitle.typeText("A")
    
    app.swipeUp()
    XCTAssert(edit.exists)
    edit.tap()
    sleep(2)
    
    let editedErrand = app.staticTexts["A"]
    XCTAssert(editedErrand.exists)
    
    // delete the posted errand
    
    editedErrand.tap()
    editErrand = app.otherElements.buttons["edit errand"]
    XCTAssert(editErrand.exists)
    editErrand.tap()
    
    app.swipeUp()
    let delete = app.buttons["Delete errand"]
    XCTAssert(delete.exists)
    delete.tap()
    sleep(1)
    
    let deleteAlert = app.alerts["Delete this errand permanently?"]
    XCTAssert(deleteAlert.exists)
    let confirm = deleteAlert.buttons["Yes, delete this errand"]
    XCTAssert(confirm.exists)
    confirm.tap()
    sleep(2)
    
    let deletedErrand = app.staticTexts["A"]
    XCTAssert(!deletedErrand.exists)
  }
  
  // profile tab
  
  func testProfile() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    sleep(1)
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    XCTAssert(app.buttons["Sign out"].exists)
  }
  
  func testProfileTabs() throws {
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    sleep(1)
    
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
    sleep(1)
    let skip = app.buttons["Skip"]
    XCTAssert(skip.exists)
    skip.tap()
    sleep(1)
    
    let profile = app.buttons["Profile"]
    XCTAssert(profile.exists)
    profile.tap()
    
    let name = (app.staticTexts["user profile name"].label).components(separatedBy: " ")
    let firstName = name[0]
    let lastName = name[1]
    
    let edit = app.otherElements.buttons["edit profile"]
    XCTAssert(edit.exists)
    edit.tap()
    
    let textInputs = app.textFields["form text section"]
    XCTAssert(textInputs.exists)
    let firstNameInput = textInputs.firstMatch
    XCTAssert(firstNameInput.exists)
    firstNameInput.tap()
    firstNameInput.typeText("!")
    
    let save = app.otherElements.buttons["Save"]
    XCTAssert(save.exists)
    save.tap()
    sleep(2)
    
    let updatedName = app.staticTexts["\(firstName)! \(lastName)"]
    XCTAssert(updatedName.exists)
    
    // change back to original
    
    XCTAssert(edit.exists)
    edit.tap()
    
    XCTAssert(textInputs.exists)
    let firstNameEdit = textInputs.firstMatch
    XCTAssert(firstNameEdit.exists)
    firstNameEdit.tap()
    firstNameEdit.typeText("\u{8}")
    
    XCTAssert(save.exists)
    save.tap()
    sleep(2)
    
    let originalName = app.staticTexts["\(firstName) \(lastName)"]
    XCTAssert(originalName.exists)
    
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
