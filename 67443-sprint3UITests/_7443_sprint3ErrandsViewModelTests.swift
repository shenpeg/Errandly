//
//  ErrandsViewModelTests.swift
//  67443-sprint3UITests
//
//  Created by Julia Graham on 12/10/23.
//

import XCTest
import FirebaseFirestore
import FirebaseCore
import FirebaseDatabase

final class _7443_sprint3ErrandsViewModelTests: XCTestCase {
  var errandsViewModel: ErrandsViewModel!
  
//  override class func setUp() {
//    super.setUp()
//    // Called once before all tests are run
//    
//    FirebaseApp.configure()
//
//    let settings = Firestore.firestore().settings
//    settings.host = "[::1]:8156"
//    settings.isPersistenceEnabled = false
//    settings.isSSLEnabled = false
//    Firestore.firestore().settings = settings
//    
//    Firestore.firestore().collection("errands").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Error getting documents: \(err)")
//      }
//      else {
//        if (querySnapshot != nil && !querySnapshot!.isEmpty) {
//          for document in querySnapshot!.documents {
//            print("------------------------------------")
//            print(document.reference.documentID)
//            document.reference.delete() { err in
//              if let err = err {
//                print("Error removing document: \(err)")
//              } else {
//                print("Document successfully removed!")
//              }
//            }
//          }
//        }
//      }
//    }
//  }
  
  override func setUp() async throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.errandsViewModel = ErrandsViewModel()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.errandsViewModel = nil
  }
  
//  private func createTempErrand() -> Errand {
//    let errandOwner = ErrandOwner(
//      id: "id",
//      first_name: "First",
//      last_name: "Last",
//      pfp: "pfp",
//      phone_number: 1234567890
//    )
//    
//    return Errand(
//      dateDue: Date(),
//      datePosted: Date(),
//      description: "description",
//      location: GeoPoint(latitude: 0, longitude: 0),
//      name: "name",
//      owner: errandOwner,
//      runner: nil,
//      pay: 10,
//      status: "new",
//      tags: ["tag1", "tag2"]
//    )
//  }
  
//  func testCreateErrand() async throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    // Any test you write for XCTest can be annotated as throws and async.
//    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    
//    let errandOwner = ErrandOwner(
//      id: "id",
//      first_name: "First",
//      last_name: "Last",
//      pfp: "pfp",
//      phone_number: 1234567890
//    )
//    let errand = Errand(
//      dateDue: Date(),
//      datePosted: Date(),
//      description: "description",
//      location: GeoPoint(latitude: 0, longitude: 0),
//      name: "name",
//      owner: errandOwner,
//      runner: nil,
//      pay: 10,
//      status: "new",
//      tags: ["tag1", "tag2"]
//    )
//
//    let createdErrand = await errandsViewModel.create(errand)
//    XCTAssertEqual(createdErrand.name, "name")
//    let gottenErrand = errandsViewModel.getErrand(createdErrand.id!)
//    XCTAssertEqual(gottenErrand.id, createdErrand.id)
////    XCTAssertEqual(errandsViewModel.errands.count, 1)
////    XCTAssertEqual(errandsViewModel.errands.first!.name, "name")
////    XCTAssertEqual(errandsViewModel.errands.count, 1)
//  }
  
//  func testDeleteErrand() async throws {
//    XCTAssertEqual(1, 1)
//    
//    let errandOwner = ErrandOwner(
//      id: "id",
//      first_name: "First",
//      last_name: "Last",
//      pfp: "pfp",
//      phone_number: 1234567890
//    )
//    let errand = Errand(
//      dateDue: Date(),
//      datePosted: Date(),
//      description: "description",
//      location: GeoPoint(latitude: 0, longitude: 0),
//      name: "name",
//      owner: errandOwner,
//      runner: nil,
//      pay: 10,
//      status: "new",
//      tags: ["tag1", "tag2"]
//    )
//
//    let createdErrand = await errandsViewModel.create(errand)
////    XCTAssertEqual(errandsViewModel.errands.count, 1)
////    XCTAssertEqual(errandsViewModel.errands.first!.name, "name")
//    errandsViewModel.delete(errand)
//    let gottenErrand = errandsViewModel.getErrand(createdErrand.id!)
//    print(gottenErrand)
////    XCTAssertThrowsError(errandsViewModel.getErrand(createdErrand.id!), "Unable to find the corresponding errand.")
//  }
  
}
