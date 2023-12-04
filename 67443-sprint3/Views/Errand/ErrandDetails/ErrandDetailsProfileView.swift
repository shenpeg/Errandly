//
//  ErrandDetailsProfileView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//
// This view is for displaying the author of an errand post

import SwiftUI
import CoreLocation

struct ErrandDetailsProfileView: View {
  var errand: Errand
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var locViewModel: LocationViewModel
  @StateObject private var timeViewModel = TimeFormatViewModel()
  
  var body: some View {
    let errandOwnerUser = usersViewModel.getUser(userId: errand.owner.id)
    
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    let timeDifference = timeViewModel.calculateTimeDifference(from: errand.datePosted)
    func message() {
      MessagesService().sendMessage("\(errand.owner.phone_number)")
    }
    
    return HStack {
      
      VStack{
        UserProfileImageView(pfp: errand.owner.pfp, size: 36)
      }
      
      VStack(alignment: .leading) {
        if (errandOwnerUser != nil) {
          HStack() {
            NavigationLink(value: errand.owner) {
              Text("\(errand.owner.first_name) \(errand.owner.last_name)")
                .font(.headline)
            }
            .accentColor(.black)
            
            Spacer()
            Button(action: message) {
              Image(systemName: "envelope")
                .foregroundColor(Color.black)
                .font(.system(size: 20))
            }
            Text("   ")
          }
        }
        else {
          Text("\(errand.owner.first_name) \(errand.owner.last_name)")
            .font(.system(size: 15))
            .foregroundColor(.primary)
        }
        
        Text(" ") //just adding space between, padding looks off no matter how I tried it
          .font(.system(size: 2))
        
        HStack {
          if (locViewModel.authorized()) {
            Text("\(locViewModel.distanceFromErrand(geoPoint: errand.location)) | \(timeViewModel.formatTimeDifference(timeDifference))")
              .font(.system(size: 15))
              .foregroundColor(.secondary)
          }
        }
      }
    } // end of returned HStack
  }
}
