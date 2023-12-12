//
//  _7443_sprint3UITestsLaunchTests.swift
//  67443-sprint3UITests
//
//  Created by Ohnyoo Esther Bae on 12/7/23.
//

import XCTest

final class _7443_sprint3UITestsLaunchTests: XCTestCase {
  
  override class var runsForEachTargetApplicationUIConfiguration: Bool {
    true
  }
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
  }
  
  func testLaunch() throws {
    let app = XCUIApplication()
    app.launch()
    
    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app
    
    let attachment = XCTAttachment(screenshot: app.screenshot())
    attachment.name = "Launch Screen"
    attachment.lifetime = .keepAlways
    add(attachment)
  }
}
