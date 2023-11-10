//
//  PostErrandView.swift
//  67443-sprint3
//
//  Created by cd on 11/1/23.
//

import Combine
import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

struct PostErrandView: View {
  
  // variables
  
  var user: User
  var isCurUser: Bool
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  
  @State private var title = ""
  @State private var description =  ""
  @State private var dateDue = Date()
  @State private var location = ""
  @State private var pay = 0.0
  @State private var payBool = true
  @State private var payString = ""
  @State private var showMarketplaceView: Bool = false
  
  init(user: User, isCurUser: Bool) {
    self.user = user
    self.isCurUser = isCurUser
    self.showMarketplaceView = false
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
    }
  
  private func isValidErrand() -> Bool {
    if title.isEmpty { return false }
    if description.isEmpty { return false}
    if pay < 0.0 { return false }
    
    //checking date has not already passed, from: riptutorial.com/ios/example/4884/date-comparison
    let calendar = Calendar.current
    let today = Date()
    let result = calendar.compare(dateDue, to: today, toGranularity: .day)
    if result == .orderedAscending { return false }
    return true
  }

  private func payStringToDouble() {
    if let payNum = Double(payString) {
      pay = payNum
    }
  }
  private func addErrand() {
    //currently hardcoded: location, tags
    
    payStringToDouble()
    let errandOwner = ErrandOwner(id: user.id!, first_name: user.first_name, last_name: user.last_name, pfp: user.pfp, phone_number: user.phone_number)
    
    let newErrand = Errand(
      dateDue: dateDue,
      datePosted: Date(),
      description: description,
      location: GeoPoint(latitude: 40.443336, longitude: -79.944023),
      name: title,
      owner: errandOwner,
      runner: nil,
      pay: pay,
      status: "new",
      tags: ["tag1", "tag2"])
    if isValidErrand() {
      marketplaceViewModel.add(newErrand)
    }
  }
  
  var body: some View {
    switch showMarketplaceView {
      
    case true: ContentView()
      
    case false:
      NavigationView {
        VStack(alignment: .leading) {
          Form {
            TextField("Errand Title", text: $title)
              .font(.system(size: 38))
              .underline(true)
              .foregroundColor(darkBlue)
              .listRowSeparator(.hidden)
          
            TextField("What do you need help with?", text: $description, axis: .vertical)
              .lineLimit(8, reservesSpace: true)
              .background(Color.white)
              .padding(5)
              .background(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
              .listRowSeparator(.hidden)
            
         
            //        Section {
            //          TextField("Tags", text: $description)
            //        }
          
            DatePicker("Date needed by:", selection: $dateDue, displayedComponents: .date)
            //            .datePickerStyle(.compact)
            //            .background(Color.white)
            //            .overlay(RoundedRectangle(cornerRadius: 0)
            //              .stroke(Color.blue, lineWidth: 1))
          
            
            
            VStack(alignment: .leading) {
              Text("Location:")
              TextField("", text: $location)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
            }.listRowSeparator(.hidden)
      
            
            
            VStack(alignment: .leading) {
              Text("Compensation?")
              HStack{
                Button(action: {payBool = true}) {
                  Text(" ")
                }
                .frame(width: 20, height: 20)
                .background(payBool ? darkBlue : Color.white)
                .cornerRadius(100)
                .foregroundColor(Color.black)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 100)
                  .stroke(darkBlue, lineWidth: 2)
                  .scaleEffect(0.5))
                Text("Yes     ")
                TextField("how much?", text: $payString)
                  .padding(5)
                  .background(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
                  .keyboardType(.decimalPad)
              }
              HStack{
                Button(action: {payString = "0"; payBool = false}) {
                  Text(" ")
                }
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
              Button("Post") {
                addErrand()
                clearFields()
                
                self.showMarketplaceView = true
              }
              .foregroundColor(.white)
              .font(.headline)
              .padding(.init(top: 5, leading: 20, bottom: 8, trailing: 20))
              .background(RoundedRectangle(cornerRadius: 20).fill(darkBlue))
              
            } //end of button section
          } //end of form
          .background(Color.white)
          .accentColor(darkBlue)
          .scrollContentBackground(.hidden)
      
        } //end vstack
        .listRowSeparator(.hidden)
        
        
      } // end of NavView
    } // end of switch
  } //end of body
  
} //end of struct PostErrandView
  




//struct PostErrandView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        PostErrandView()
//    }
//}
