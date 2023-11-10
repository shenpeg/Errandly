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
  @ObservedObject var usersViewModel: UsersViewModel = UsersViewModel()
  var errand: Errand
  @StateObject private var viewModel = LocationTimeFormatViewModel()


  var body: some View {
    let errandOwnerUser = usersViewModel.getUser(errand.owner.id)

    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    let timeDifference = viewModel.calculateTimeDifference(from: errand.datePosted)

    return HStack {
      
      VStack{
          UserProfileImageView(pfp: errand.owner.pfp, size: 32)
      }
    
      VStack(alignment: .leading){
          if (errandOwnerUser != nil) {
            NavigationLink(destination:
                            UserProfileView(user: errandOwnerUser, isCurUser: false)
            ) {
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
          
          HStack{
            if (viewModel.locationName != "") {
                Text(viewModel.locationName)
                    .font(.footnote)
                      .foregroundColor(.secondary)
                Text("|").font(.footnote).foregroundColor(.secondary)
            }
            Text(viewModel.formatTimeDifference(timeDifference))
                .font(.footnote)
                .foregroundColor(.secondary)
          }
        }
      }
      .onAppear {
        viewModel.getLocationName(for: CLLocation(latitude: errand.location.latitude, longitude: errand.location.longitude))
      }
  }
}
