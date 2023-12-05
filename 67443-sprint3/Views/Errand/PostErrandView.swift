import Combine
import Foundation
import FirebaseFirestore
import SwiftUI

struct PostErrandView: View {
  
  // variables
  
  var user: User
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var tabUtil: TabUtil
  @Binding var profilePath: NavigationPath
  
  @State private var title = ""
  @State private var description =  ""
  @State private var selectedTags: [String] = []
  @State private var dateDue = Date()
  @State private var location = GeoPoint(latitude: 40.443336, longitude: -79.944023) //pittsburgh
  @State private var pay = 0.0
  @State private var payBool = true
  @State private var payString = ""
  @State private var errorMsg = ""
  @State private var showErrorAlert = false
  
  
  private func addErrand() async {
    //currently hardcoded: location
    let errandOwner = ErrandOwner(id: user.id!, first_name: user.first_name, last_name: user.last_name, pfp: user.pfp, phone_number: user.phone_number)
    
    let newErrand = Errand(
      dateDue: dateDue,
      datePosted: Date(),
      description: description,
      location: location,
      name: title,
      owner: errandOwner,
      runner: nil,
      pay: pay,
      status: "new",
      tags: selectedTags
    )
    
    let postedErrand = await errandsViewModel.create(newErrand)
    if (postedErrand.id != nil) {
      usersViewModel.addErrandToUser(userId: user.id!, errandId: postedErrand.id!, type: "posted_errands")
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        ErrandFormView(
          title: $title,
            description: $description,
            selectedTags: $selectedTags,
            dateDue: $dateDue,
            pay: $pay,
            payBool: $payBool,
            payString: $payString
        )
        
        Section {
          StyledButton(title: "Post") {
            
            if payBool == false {
              payString = "0.00"
            }
            let formFuncts = FormFunctions(
                              title: $title,
                              description: $description,
                              dateDue: $dateDue,
                              pay: $pay,
                              payBool: $payBool,
                              payString: $payString,
                              selectedTags: $selectedTags,
                              errorMsg: $errorMsg
                            )
            
            //string to Double
            formFuncts.payStringToPay()
            
            if formFuncts.isValidErrand() {
              Task {
                // necessary to avoid the following errors, as this will resign the text fields:
                // - AttributeGraph: cycle detected through attribute
                // - Modifying state during view update, this will cause undefined behavior.
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                await addErrand()
                formFuncts.clearFields()
                
                // redirect to user profile
                tabUtil.tabSelection = 3
                tabUtil.profileTabSelection = "Posted Errands"
                profilePath = NavigationPath()
              }
            }
            else {
              showErrorAlert = true
            }
          } //button
          .alert(isPresented: $showErrorAlert) {
            Alert(
              title: Text(errorMsg),
              dismissButton: .cancel(Text("OK")) {
              }
            )
          }

        } //section
      } //form
      .background(Color.white)
      .accentColor(darkBlue)
      .scrollContentBackground(.hidden)
      .gesture(DragGesture().onChanged({ _ in
                          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}))
    } //end vstack
    .listRowSeparator(.hidden)
  } //end of body
} //end of struct PostErrandView
