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
    
    return HStack {
      
      VStack{
        UserProfileImageView(pfp: errand.owner.pfp, size: 32)
      }
      
      VStack(alignment: .leading) {
        if (errandOwnerUser != nil) {
          NavigationLink(value: errand.owner) {
            Text("\(errand.owner.first_name) \(errand.owner.last_name)")
              .font(.headline)
          }
          .accentColor(.black)
        }
        else {
          Text("\(errand.owner.first_name) \(errand.owner.last_name)")
            .font(.headline)
            .foregroundColor(.primary)
        }
        
        HStack {
          if (locViewModel.authorized()) {
            Text(locViewModel.distanceFromErrand(geoPoint: errand.location))
              .font(.footnote)
              .foregroundColor(.secondary)
            Text("|").font(.footnote).foregroundColor(.secondary)
          }
          Text(timeViewModel.formatTimeDifference(timeDifference))
            .font(.footnote)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}
