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
  @Binding var tabSelection: Int
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var marketplaceViewModel: MarketplaceViewModel
  
  @State private var title = ""
  @State private var description =  ""
  @State private var selectedTags: [String] = []
  @State private var dateDue = Date()
  @State private var location = ""
  @State private var pay = 0.0
  @State private var payBool = true
  @State private var payString = ""
  @State private var numOfTags = 0
  
  // tags: ["on-campus", "off-campus", "house/dorm", "food/drink", "cleaning", "animals", "plants", "car", "laundry", "moving in/out"]
  @State private var tagsList = [
    Tag(tid: 0, label: "on-campus"),
    Tag(tid: 1, label: "off-campus"),
    Tag(tid: 2, label: "house/dorm"),
    Tag(tid: 3, label: "food/drink"),
    Tag(tid: 4, label: "cleaning"),
    Tag(tid: 5, label: "animals"),
    Tag(tid: 6, label: "plants"),
    Tag(tid: 7, label: "car"),
    Tag(tid: 8, label: "laundry"),
    Tag(tid: 9, label: "moving in/out"),
    ]

  //functions
    private func clearFields(){
      title = ""
      description = ""
      dateDue = Date()
      //location = GeoPoint() stays in pgh for now
      payBool = true
      payString = ""
      pay = 0.0
//      for var tag in tagsList {
//        tag.isSelected = false
//      }
      tagsList = [
        Tag(tid: 0, label: "on-campus"),
        Tag(tid: 1, label: "off-campus"),
        Tag(tid: 2, label: "house/dorm"),
        Tag(tid: 3, label: "food/drink"),
        Tag(tid: 4, label: "cleaning"),
        Tag(tid: 5, label: "animals"),
        Tag(tid: 6, label: "plants"),
        Tag(tid: 7, label: "car"),
        Tag(tid: 8, label: "laundry"),
        Tag(tid: 9, label: "moving in/out"),
        ]
      selectedTags = []
      
    }
  
  private func isValidErrand() -> Bool {
    if title.isEmpty { return false}
    if description.isEmpty { return false}
    if pay > 10000.00 && pay <= 0.0 { return false }
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
  
  private func getSelectedTags() {
    self.tagsList.forEach { tag in
      if tag.isSelected {
        selectedTags.append(tag.label)
        print(tag.label)
      }
    }
  }

  private func countSelectedTags() {
    self.numOfTags = 0
    self.tagsList.forEach { tag in
      if tag.isSelected {
        self.numOfTags += 1
      }
    }
  }
  
  private func addErrand() async {
    //currently hardcoded: location
    
    payStringToDouble()
    getSelectedTags()
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
      tags: selectedTags
    )
    
    let postedErrand = await marketplaceViewModel.create(newErrand)
    print(postedErrand.id ?? "n/a")
    if (postedErrand.id != nil) {
      usersViewModel.addErrandToUser(userId: user.id!, errandId: postedErrand.id!, type: "posted_errands")
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        TextField("Errand Title", text: $title)
          .font(.system(size: 38))
          .underline(true)
          .foregroundColor(darkBlue)
          .listRowSeparator(.hidden)
        
        TextField("What do you need help with?", text: $description, axis: .vertical)
          .lineLimit(10, reservesSpace: true)
          .background(Color.white)
          .padding(5)
          .background(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
          .listRowSeparator(.hidden)
     
        DatePicker("Date needed by:", selection: $dateDue, displayedComponents: .date)
        //            .datePickerStyle(.compact)
        //            .background(Color.white)
        //            .overlay(RoundedRectangle(cornerRadius: 0)
        //              .stroke(Color.blue, lineWidth: 1))

        VStack(alignment: .leading) {
          Text("Tags (select up to five):")
          HStack {
            ForEach(0 ... 2, id: \.self ) { index in
              Button(tagsList[index].label) {
//                  TagButtonView(tag: tagsList[index], selectedBtn: self.$selectedTag)
                countSelectedTags()
                if numOfTags < 5 || tagsList[index].isSelected {
                  tagsList[index].isSelected = !tagsList[index].isSelected
                }
              }
              .font(.footnote)
              .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
              .background(tagsList[index].isSelected ? mint : lightGray)
              .foregroundColor(tagsList[index].isSelected ? darkBlue : Color.black)
              .cornerRadius(10)
              .buttonStyle(BorderlessButtonStyle())
            }
          } //Hstack 1
          HStack {
            ForEach(3 ... 6, id: \.self ) { index in
              Button(tagsList[index].label) {
                countSelectedTags()
                if numOfTags < 5 || tagsList[index].isSelected {
                  tagsList[index].isSelected = !tagsList[index].isSelected
                }
              }
              .font(.footnote)
              .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
              .background(tagsList[index].isSelected ? mint : lightGray)
              .foregroundColor(tagsList[index].isSelected ? darkBlue : Color.black)
              .cornerRadius(10)
              .buttonStyle(BorderlessButtonStyle())
            }
          }
//              .contentShape(Rectangle())
          HStack {
            ForEach(7 ... 9, id: \.self ) { index in
              Button(tagsList[index].label) {
                countSelectedTags()
                if numOfTags < 5 || tagsList[index].isSelected {
                  tagsList[index].isSelected = !tagsList[index].isSelected
                }
//                    print("---------------------------------")
//                    print(tagsList[index].label)
//                    print(String(tagsList[index].isSelected))
//
//                    print("---------------------------------")
              }
              .font(.footnote)
              .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
              .background(tagsList[index].isSelected ? mint : lightGray)
              .foregroundColor(tagsList[index].isSelected ? darkBlue : Color.black)
              .cornerRadius(10)
              .buttonStyle(BorderlessButtonStyle())
            }
          }
        } //Vstack
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
          if isValidErrand() {
            Button("Post") {
              Task {
                // necessary to avoid the following errors, as this will resign the text fields:
                // - AttributeGraph: cycle detected through attribute
                // - Modifying state during view update, this will cause undefined behavior.
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                await addErrand()
                clearFields()
                self.tabSelection = 1
              }
            }
            .foregroundColor(.white)
            .font(.headline)
            .padding(.init(top: 5, leading: 20, bottom: 8, trailing: 20))
            .background(RoundedRectangle(cornerRadius: 20).fill(darkBlue))
          }
        } //end of button section
        
      } //end of form
      .background(Color.white)
      .accentColor(darkBlue)
      .scrollContentBackground(.hidden)
  
    } //end vstack
    .listRowSeparator(.hidden)

  } //end of body
  
} //end of struct PostErrandView
