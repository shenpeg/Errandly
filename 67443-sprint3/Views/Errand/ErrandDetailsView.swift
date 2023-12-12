//
//  ErrandDetailsView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandDetailsView: View {
  var errand: Errand
  var user: User
  
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var tabUtil: TabUtil
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath
  
  @State private var isDeleteAlertPresented = false

  
    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                      if (errandsViewModel.getErrand(errand.id!).status.contains("in progress")) {
                        Text("in progress")
                          .font(.headline)
                          .foregroundColor(darkBlue)
                          .italic()
                          .bold()
                      }
                      else {
                        Text(errandsViewModel.getErrand(errand.id!).status)
                          .font(.headline)
                          .foregroundColor(darkBlue)
                          .italic()
                          .bold()
                      }
                      
                      Spacer()
                      
                      if (usersViewModel.getCurUser()!.id == errand.owner.id && errand.status == "new") {
                        NavigationLink(value: errand.id) {
                          Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .padding(5)
                        }
                        .accessibilityIdentifier("edit errand")
                      }
                    }
                  
                    Text(errand.name)
                        .font(.largeTitle)
//                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                  
                    HStack() {
                      ForEach(errand.tags, id: \.self) {tag in
                        Text(tag)
                          .font(.system(size: 14))
                          .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                          .foregroundColor(black)
                          .background(Capsule().fill(lightGray))
                      }
                    }

                  ErrandDetailsProfileView(errand: errand, user: user)
                    .padding(.init(top: 5, leading: 0, bottom: 8, trailing: 0))
                    
                    // Horizontal separator line
                    Rectangle()
                    .frame(height: 1)
                      .foregroundColor(black)
                  
                    HStack {
                      Text(errand.description)
                        .font(.system(size: 20))
                    }
                    
                    // Horizontal separator line
                    Rectangle()
                    .frame(height: 1)
                      .foregroundColor(black)
                  
                    HStack {
                        Text("Date Due: \(dateFormat.string(from: errand.dateDue))")
                        .font(.system(size: 20))
                    }
                }
                .padding(20)
            }
          
          ErrandDetailsPickUpView(errand: errand, user: user, marketplacePath: $marketplacePath, profilePath: $profilePath)
        }
    }
  
}
