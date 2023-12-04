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
  var user: User
  var errand: Errand
  @Binding var profilePath: NavigationPath
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var tabUtil: TabUtil
  
  
  @State private var title: String
  @State private var description: String
  @State private var selectedTags: [String]
  @State private var dateDue: Date = Date()
  @State private var location = GeoPoint(latitude: 40.443336, longitude: -79.944023) //pittsburgh
  @State private var pay: Double
  @State private var payBool: Bool = true
  
  @State private var payString: String
  @State private var errorMsg: String
  @State private var showErrorAlert: Bool
  
  
  
  init (user: User, errand: Errand, profilePath: Binding<NavigationPath>) {
    self.errand = errand
    self._title = State(wrappedValue: errand.name)
    self._description = State(wrappedValue: errand.description)
    self._selectedTags = State(wrappedValue: errand.tags)
    self._dateDue = State(wrappedValue: errand.dateDue)
    self._location = State(wrappedValue: errand.location)
    self._pay = State(wrappedValue: errand.pay)
    self._payBool = State(wrappedValue: false)
    self._payString = State(wrappedValue: "")
    self._errorMsg = State(wrappedValue: "")
    self._showErrorAlert = State(wrappedValue: false)
    
    self.user = user
    self._profilePath = profilePath
  }
  
  //functions
    private func clearFields(){
      title = ""
      description = ""
      dateDue = Date()
      //location = GeoPoint() stays in pgh for now
      payBool = true
      payString = ""
      pay = 0.0
      selectedTags = []
      
    }
  
  private func isValidErrand() -> Bool {
    
    if title.isEmpty {
      errorMsg = "Please enter a title for your errand!"
      return false
    }
    if description.isEmpty {
      errorMsg = "Please write some details on what you need help with"
      return false
    }
    if (payBool == true && pay < 1.00) {
      errorMsg = "If you choose to offer compensation, please enter an amount over $1.00"
      return false
    }
    //checking date has not already passed, from: riptutorial.com/ios/example/4884/date-comparison
    let calendar = Calendar.current
    let today = Date()
    let result = calendar.compare(dateDue, to: today, toGranularity: .day)
    if result == .orderedAscending {
      errorMsg = "You can only enter a due date that's in the future!"
      return false
    }
    return true
  }

  private func payStringToDouble() {
    if let payNum = Double(payString) {
      pay = payNum
    }
  }
  
  private func updateErrand() {
    
    if isValidErrand() {
      let updatedErrand = Errand(
        dateDue: dateDue,
        datePosted: errand.datePosted,
        description: description,
        location: GeoPoint(latitude: 40.443336, longitude: -79.944023),
        name: title,
        owner: errand.owner,
        runner: nil,
        pay: pay,
        status: "new",
        tags: selectedTags
        )
      errandsViewModel.update(errand, updatedErrand: updatedErrand)
    }
  }
  
  
  
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        TextField(title, text: $title)
          .font(.system(size: 38))
          .underline(true)
          .foregroundColor(darkBlue)
          .listRowSeparator(.hidden)
        
        TextField(description, text: $description, axis: .vertical)
          .lineLimit(10, reservesSpace: true)
          .background(Color.white)
          .padding(5)
          .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
          .listRowSeparator(.hidden)
     
        DatePicker("Date needed by:", selection: $dateDue, displayedComponents: .date)

        VStack(alignment: .leading, spacing: 0) {
          Text("Tags (select up to five):")
            .padding(.bottom, 10)
          FormTags(formTags: $selectedTags)
        }
        .listRowSeparator(.hidden)

//            VStack(alignment: .leading) {
//              Text("Location:")
//              TextField("", text: $location)
//                .padding(5)
//                .background(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
//            }
//            .listRowSeparator(.hidden)

        VStack(alignment: .leading) {
            Text("Compensation?")
            HStack{
              Button(action: {payString = "1"; payBool = true}) {
                    Text(" ")
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 20, height: 20)
                .background(payBool ? darkBlue : Color.white)
                .cornerRadius(100)
                .foregroundColor(Color.black)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 100)
                    .stroke(darkBlue, lineWidth: 2)
                    .scaleEffect(0.5))
                Text("Yes     ")
                
                // Show the TextField only if payBool is true
                if payBool {
                    TextField("How much?", text: $payString)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
                        .keyboardType(.decimalPad)
                }
            }
            
            HStack{
                Button(action: {payString = "0"; payBool = false}) {
                    Text(" ")
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 20, height: 20)
                .background(payBool ? Color.white : darkBlue)
                .cornerRadius(100)
                .foregroundColor(darkBlue)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 100)
                    .stroke(darkBlue, lineWidth: 2)
                    .scaleEffect(0.5))
                Text("No      ")
            }
        }.listRowSeparator(.hidden)
        
        Section {
          Button("Save edits") {
            
            payStringToDouble()
           
            if isValidErrand() {
              Task {
                // necessary to avoid the following errors, as this will resign the text fields:
                // - AttributeGraph: cycle detected through attribute
                // - Modifying state during view update, this will cause undefined behavior.
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                updateErrand()
                clearFields()
                
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
          .foregroundColor(.white)
          .font(.headline)
          .padding(.init(top: 5, leading: 20, bottom: 8, trailing: 20))
          .background(RoundedRectangle(cornerRadius: 20).fill(darkBlue))
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
