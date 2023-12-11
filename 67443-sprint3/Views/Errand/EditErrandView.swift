//
//  EditPostedErrandView.swift
//  67443-sprint3
//
//  Created by cd on 12/2/23.
//

import Combine
import Foundation
import FirebaseFirestore
import SwiftUI

struct EditErrandView: View {
  
  // variables
  var errand: Errand
  var user: User
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath

  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var tabUtil: TabUtil
  
  
  @State private var title: String
  @State private var description: String
  @State private var selectedTags: [String]
  @State private var dateDue: Date = Date()
  @State private var location = GeoPoint(latitude: 0, longitude: 0)
  @State private var locationString: String = ""
  @State private var pay: Double
  @State private var payBool: Bool
  @State private var payString: String
  @State private var errorMsg: String
  @State private var showErrorAlert: Bool
  
  @State private var isDeleteAlertPresented = false
  
  init (
    errand: Errand,
    user: User,
    marketplacePath: Binding<NavigationPath>,
    profilePath: Binding<NavigationPath>
  ){
    self.errand = errand
    self.user = user
    self._marketplacePath = marketplacePath
    self._profilePath = profilePath
    
    self._title = State(wrappedValue: errand.name)
    self._description = State(wrappedValue: errand.description)
    self._selectedTags = State(wrappedValue: errand.tags)
    self._dateDue = State(wrappedValue: errand.dateDue)
    self._location = State(wrappedValue: errand.location)
    self._locationString = State(wrappedValue: "")
    self._pay = State(wrappedValue: errand.pay)
    self._errorMsg = State(wrappedValue: "")
    self._showErrorAlert = State(wrappedValue: false)
    
    if errand.pay >= 1.00 {
      self._payBool = State(wrappedValue: true)
    }
    else {
      self._payBool = State(wrappedValue: false)
    }
    
    let payStringTemp = String(errand.pay)
    self._payString = State(wrappedValue: payStringTemp )
    
  }
  
  //functions
  private func deleteErrand() {
    let owner = usersViewModel.getUser(userId: errand.owner.id)!
    usersViewModel.deletePostedErrand(owner: owner, errand: errand)
    errandsViewModel.delete(errand)
  }

  private func updateErrand() {
      let updatedErrand = Errand(
        dateDue: dateDue,
        datePosted: errand.datePosted,
        description: description,
        location: location,
        name: title,
        owner: errand.owner,
        runner: errand.runner,
        pay: pay,
        status: "new",
        tags: selectedTags
        )
      errandsViewModel.update(errand, updatedErrand: updatedErrand)
  }

  
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        
        ErrandFormView(
            title: $title,
            description: $description,
            selectedTags: $selectedTags,
            dateDue: $dateDue,
            location: $location,
            locationString: $locationString,
            pay: $pay,
            payBool: $payBool,
            payString: $payString
        )
        
        HStack() {
          //button 1
          FormButton(title: "Save edits") {
            
            
            if payBool == false {
              payString = "0.00"
            }
            
            let formFuncts = FormFunctions(
                              title: $title,
                              description: $description,
                              dateDue: $dateDue,
                              location: $location,
                              locationString: $locationString,
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
                
                updateErrand()
                formFuncts.clearFields()
                
                // redirect to user profile
                // and reset both the marketplace + profile paths
                tabUtil.tabSelection = 3
                tabUtil.profileTabSelection = "Posted Errands"
                marketplacePath = NavigationPath()
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
          
          //delete errand
          FormButton (title: "Delete errand") {
            isDeleteAlertPresented = true
          }
          .alert(isPresented: $isDeleteAlertPresented) {
            Alert(
              title: Text("Delete this errand permanently?"),
              primaryButton: .default(Text("Yes, delete this errand")) {
                self.deleteErrand()
                tabUtil.tabSelection = 3
                tabUtil.profileTabSelection = "Posted Errands"
                marketplacePath = NavigationPath()
                profilePath = NavigationPath()
              },
              secondaryButton: .cancel(Text("No, cancel"))
            )
          } //end of alert
        } //HStack
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
