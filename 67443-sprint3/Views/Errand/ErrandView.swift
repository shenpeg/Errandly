//
//  ErrandView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI
import CoreLocation
import GoogleSignIn

struct ErrandView: View {
  let errand: Errand
  var user: User
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var locViewModel: LocationViewModel
  @StateObject var timeViewModel = TimeFormatViewModel()
  
  @State private var isDeleteAlertPresented = false
  
  var body: some View {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    let timeDifference = timeViewModel.calculateTimeDifference(from: errand.datePosted)
    
    return ZStack {
      NavigationLink("", value: errand)
        .opacity(0.0)
      
      VStack(alignment: .leading, spacing: 0, content: {
        HStack(alignment: .top) {
          Text(errand.name)
            .font(.title2)
          
          //          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
          //            // still need to get edit errand working
          //            Image(systemName: "pencil")
          //              .foregroundColor(.black)
          //              .font(.system(size: 20))
          //          }
          
          if (usersViewModel.getCurUser()!.id == errand.owner.id && errand.status == "new") {
            Image(systemName: "trash")
              .foregroundColor(.black)
              .font(.system(size: 15))
              .padding(.top, 3)
              .onTapGesture {
                isDeleteAlertPresented = true
              }
              .alert(isPresented: $isDeleteAlertPresented) {
                Alert(
                  title: Text("Delete this errand permanently?"),
                  primaryButton: .default(Text("Yes, delete this errand")) {
                    self.deleteErrand()
                  },
                  secondaryButton: .cancel(Text("No, cancel"))
                )
              }
          }
          Spacer()
          
          VStack(alignment: .trailing) {
            Text("due by")
            Text("\(dateFormat.string(from: errand.dateDue))")
          }
          .font(.footnote)
          
        }
        .padding(.bottom, 3)
        
        HStack {
          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
            Text("your post")
          }
          else {
            Text("\(errand.owner.first_name) \(errand.owner.last_name.first!)." as String)
          }
          Text("|")
          if (locViewModel.authorized()) {
            Text(locViewModel.distanceFromErrand(geoPoint: errand.location))
            Text("|")
          }
          Text(timeViewModel.formatTimeDifference(timeDifference))
        }
        .font(.footnote)
        .padding(.bottom, 10)
        
        HStack() {
          ForEach(errand.tags, id: \.self) {tag in
            Text(tag)
              .font(.footnote)
              .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
              .foregroundColor(darkBlue)
              .background(Capsule().fill(lightGray))
          }
        }
        .padding(.bottom, 3)
        
        Spacer()
        Divider()
          .overlay(darkBlue)
          .opacity(1)
        
        HStack() {
          Text("$\(String(format: "%.2f", errand.pay)) ")
          Spacer()
          Text("view details")
            .font(.headline)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .foregroundColor(.white)
            .background(Capsule().fill(darkBlue))
        }
        .padding(.top, 10)
        
      })
      .padding(.vertical, 10)
      .padding(.horizontal, 20)
      
    }
    .listRowBackground(
      RoundedRectangle(cornerRadius: 20)
        .stroke(darkBlue, lineWidth: 1)
        .background(RoundedRectangle(cornerRadius: 20).fill(.white))
        .offset(y: -5)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    )
    .listRowSeparator(.hidden)
  }
  
  func deleteErrand() {
    // only delete 'new' errands so don't need to check/remove runner
//    if (!errandsViewModel.errandViewModels.isEmpty && !usersViewModel.userViewModels.isEmpty) {
//      if (errand.runner != nil) {
//        let runner = usersViewModel.getUser(errand.runner!.id)!
//        usersViewModel.destroyPickedUpErrand(runner: runner, errand: errand)
//      }
    let owner = usersViewModel.getUser(userId: errand.owner.id)!
    usersViewModel.deletePostedErrand(owner: owner, errand: errand)
    errandsViewModel.delete(errand)
//    }
  }
}
