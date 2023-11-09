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
  
  var user: User?
  var isCurUser: Bool
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  
  @State private var title = ""
  @State private var description =  ""
  @State private var dateDue = Date()
  @State private var location = ""
  @State private var pay = 0.0
  @State private var payBool = true
  @State private var payString = ""
  @State private var isErrandPosted = false
  
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

  private func addErrand() {
    //currently hardcoded: location, owner, tag
    let errandOwner = ErrandOwner(id: user!.id!, first_name: user!.first_name, last_name: user!.last_name, pfp: user!.pfp, phone_number: user!.phone_number)
    let newErrand = Errand(
      dateDue: dateDue,
      datePosted: Date(),
      description: description,
      location: GeoPoint(latitude: 10.20, longitude: 40.67),
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
    NavigationView {
      Form {
        Section {
          TextField("Errand Title", text: $title)
        }
        
        Section {
          TextField("What do you need help with?", text: $description)
            .frame(minHeight: 200)
            .background(Color.white)
            .cornerRadius(10) //Add rounded corners
            .overlay(RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.blue, lineWidth: 1)
            )
        }
        
//        Section {
//          TextField("Tags", text: $description)
//        }
        
        Section {
          DatePicker("Date needed by:", selection: $dateDue, displayedComponents: .date)
        }
        
        Section {
          TextField("Location", text: $location)
        }
        
        VStack{
          Text("Compensation?")
          HStack{
            Button(action: {
              pay = 20
            }) {
              Text(" ")
            }
            .frame(width: 20, height: 20)
//              .background(pay ? Color.white : Color.blue)
            .cornerRadius(100)
            .foregroundColor(Color.black)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 100)
              .stroke(Color.blue, lineWidth: 2)
              .scaleEffect(0.5))
            Text("Yes")
          }
          
          HStack{
            Button(action: {pay = 0}) {
              Text(" ")
            }
            .frame(width: 20, height: 20)
            //              .background(pay ? Color.blue : Color.white)
            .cornerRadius(100)
            .foregroundColor(Color.black)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 100)
              .stroke(Color.blue, lineWidth: 2)
              .scaleEffect(0.5))
            Text("No")
          }
        }
        
        Section {
//          NavigationLink(destination: MarketplaceView()) {
//            Button(action: {
//              addErrand()
//            }) {
//              Text("Post")
//            }
//            .foregroundColor(Color.white)
//            .font(.headline)
//            .foregroundColor(.white)
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
//          }
          
          Button("Post") {
            addErrand()
            clearFields()
            isErrandPosted = true
            //go to marketplaceView
          }
          .foregroundColor(Color.white)
          .font(.headline)
          .foregroundColor(.white)
          .padding()
          .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
          
        } //end of button section
        
      } //end of form
      .background(Color.white)
      .scrollContentBackground(.hidden)
      
      
    } // end of NavView
  } //end of body
  
} //end of struct PostErrandView
  




//struct PostErrandView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        PostErrandView()
//    }
//}
