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
  var grayOut: Bool
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var locViewModel: LocationViewModel
  @StateObject var timeViewModel = TimeFormatViewModel()
  @State private var profilePath = NavigationPath()
  
  
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
            .font(.system(size: 25))
          
          Spacer()
          
          VStack(alignment: .trailing) {
            Text("due by")
            Text("\(dateFormat.string(from: errand.dateDue))")
          }
          .font(.system(size: 14))
        }
        
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
        .font(.system(size: 14))
        .padding(.bottom, 10)
        
        HStack() {
          ForEach(errand.tags, id: \.self) {tag in
            if grayOut {
              Text(tag)
                .font(.system(size: 14))
                .padding(.init(top: 2, leading: 7, bottom: 3, trailing: 7))
                .foregroundColor(black)
                .background(Capsule().fill(Color(red: 0.73, green: 0.73, blue: 0.73)))
            }
            else {
              TagView(tag: tag, viewOnly: true, isSelected: nil)
            }
          }
        }
        .padding(.bottom, 3)
        
        Rectangle()
          .frame(height: 30)
          .foregroundColor(grayOut ? grayOutGray : white)
          .padding(.horizontal, -10)
        Rectangle()
          .frame(height: 0.8)
          .foregroundColor(black)
          .padding(.horizontal, -20)
        
        HStack() {
          Text("$\(String(format: "%.2f", errand.pay)) ")
            .font(.system(size: 22))
          Spacer()
          
          
          if grayOut {
            Text("view details")
              .font(.system(size: 18).bold())
              .padding(.init(top: 4, leading: 15, bottom: 5, trailing: 15))
              .foregroundColor(.white)
              .background(Capsule().fill(Color(red: 0.177, green: 0.309, blue: 0.749)))
          }
          else {
              Text("view details")
              .font(.system(size: 18).bold())
              .padding(.init(top: 4, leading: 15, bottom: 5, trailing: 15))
              .foregroundColor(.white)
              .background(Capsule().fill(darkBlue))
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 0)
        
      })
      .padding(.vertical, 10)
      .padding(.horizontal, 20)
      
    }
    .listRowBackground(
      RoundedRectangle(cornerRadius: 10)
        .stroke(black, lineWidth: 0.8)
        .background(RoundedRectangle(cornerRadius: 10).fill(grayOut ? grayOutGray : white))
//        .offset(y: 5)
        .padding(.init(top: 10, leading: 20, bottom: 16, trailing: 20))

    )
    .listRowSeparator(.hidden)
  }
}
