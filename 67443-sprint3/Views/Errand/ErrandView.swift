//
//  ErrandView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI
import CoreLocation
//import GoogleSignIn

struct ErrandView: View {
  let errand: Errand
  let isCurUser: Bool
  var user: User
  
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  @ObservedObject var usersViewModel = UsersViewModel()
  @StateObject var locTimeViewModel = LocationTimeFormatViewModel()
  @State private var isAppeared: Bool = false
  @State private var isDeleteAlertPresented = false
  
  var body: some View {    
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    let timeDifference = locTimeViewModel.calculateTimeDifference(from: errand.datePosted)
    
    return ZStack {
      NavigationLink(destination:
        ErrandDetailsView(errand: errand, user: user)
      ) {
        EmptyView()
      }
      .opacity(0.0)
      
      VStack(alignment: .leading, spacing: 0, content: {
        HStack(alignment: .top) {
          Text(errand.name)
            .font(.title2)
          
//          if (isCurUser) {
//            // still need to get edit errand working
//            Image(systemName: "pencil")
//              .foregroundColor(.black)
//              .font(.system(size: 20))
//          }
          
          if (isCurUser && errand.status == "new") {
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
          if (isCurUser) {
            Text("your post")
          }
          else {
            Text("\(errand.owner.first_name) \(errand.owner.last_name.first!)." as String)
          }
          Text("|")
          if (locTimeViewModel.locationName != "") {
            Text(locTimeViewModel.locationName)
            Text("|")
          }
          Text(locTimeViewModel.formatTimeDifference(timeDifference))
        }
        .font(.footnote)
        .padding(.bottom, 10)
        
        HStack() {
          ForEach(errand.tags, id: \.self) {tag in
            Text(tag)
              .font(.footnote)
              .padding(.horizontal, 10)
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
      RoundedRectangle(cornerRadius: 10)
        .background(.clear)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
    )
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(darkBlue, lineWidth: 1))
    .listRowSeparator(.hidden)
    .onAppear {
      if (!isAppeared) {
        isAppeared = true
        locTimeViewModel.getLocationName(for: CLLocation(latitude: errand.location.latitude, longitude: errand.location.longitude))
      }
    }
    .onDisappear() {
      isAppeared = false
    }
  }
  
  func deleteErrand() {
    if (!marketplaceViewModel.errandViewModels.isEmpty && !usersViewModel.userViewModels.isEmpty) {
      if (errand.runner != nil) {
        let runner = usersViewModel.getUser(errand.runner!.id)!
        usersViewModel.destroyPickedUpErrand(runner: runner, errand: errand)
      }
      let owner = usersViewModel.getUser(errand.owner.id)!
      usersViewModel.destroyPostedErrand(owner: owner, errand: errand)
      marketplaceViewModel.destroy(errand)
    }
  }
}
