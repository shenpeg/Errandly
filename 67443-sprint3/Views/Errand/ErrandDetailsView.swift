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
  @State private var isRemoveRunnerPresented = false

  
    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                      if (errandsViewModel.getErrand(errand.id!).status.contains("in progress") && (usersViewModel.getCurUser()!.id == errand.owner.id)) {
                        Text("in progress by \(errand.runner!.first_name) \(errand.runner!.last_name)")
                          .font(.headline)
                          .foregroundColor(darkBlue)
                          .italic()
                          .bold()
                      }
                      else if ((errandsViewModel.getErrand(errand.id!).status == "completed") && (usersViewModel.getCurUser()!.id == errand.owner.id)) {
                        Text("completed by \(errand.runner!.first_name) \(errand.runner!.last_name)")
                          .font(.headline)
                          .foregroundColor(darkBlue)
                          .italic()
                          .bold()
                      }
                      else if (errandsViewModel.getErrand(errand.id!).status.contains("in progress")) {
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
                      
                      if (usersViewModel.getCurUser()!.id == errand.owner.id && errandsViewModel.getErrand(errand.id!).status == "new") {
                        NavigationLink(value: errand.id) {
                          Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .padding(5)
                        }
                        .accessibilityIdentifier("edit errand")
                      }
                      
                      else if (usersViewModel.getCurUser()!.id == errand.owner.id && errandsViewModel.getErrand(errand.id!).status == "in progress") {
                        Button(action: {isRemoveRunnerPresented = true})
                        {
                          VStack (spacing: 0) {
                            Image(systemName: "person.crop.circle.badge.xmark")
                              .foregroundColor(Color.black)
                              .font(.system(size: 20))
                            Text("Remove\nrunner")
                              .foregroundColor(Color.black)
                              .font(.caption)
                          }
                        }
                        .alert(isPresented: $isRemoveRunnerPresented) {
                          Alert(
                            title: Text("Are you sure you want to remove the runner?"),
                            primaryButton: .default(Text("Yes, I'm sure")) {
                              errandsViewModel.removeRunnerFromErrand(errandId: errand.id!)
                              usersViewModel.deletePickedUpErrand(runner: usersViewModel.getUser(userId: errand.runner!.id)!, errand: errand)
                              errandsViewModel.updateErrandStatus(errandID: errand.id!, newStatus: "new")
                            },
                            secondaryButton: .cancel(Text("Cancel"))
                          )
                        }
                      }
                      
                      else if ((errand.runner != nil && usersViewModel.getCurUser()!.id == errand.runner!.id)
                        && errandsViewModel.getErrand(errand.id!).status == "in progress") {
                        Button(action: {isRemoveRunnerPresented = true})
                        {
                          VStack (spacing: 0) {
                            Image(systemName: "person.crop.circle.badge.xmark")
                              .foregroundColor(Color.black)
                              .font(.system(size: 20))
                            Text("Drop\nerrand")
                              .foregroundColor(Color.black)
                              .font(.caption)
                          }
                        }
                        .alert(isPresented: $isRemoveRunnerPresented) {
                          Alert(
                            title: Text("Are you sure you want to drop this errand?"),
                            primaryButton: .default(Text("Yes, I'm sure")) {
                              errandsViewModel.removeRunnerFromErrand(errandId: errand.id!)
                              usersViewModel.deletePickedUpErrand(runner: usersViewModel.getCurUser()!, errand: errand)
                              errandsViewModel.updateErrandStatus(errandID: errand.id!, newStatus: "new")
                              tabUtil.tabSelection = 3
                              tabUtil.profileTabSelection = "Picked Up Errands"
                              marketplacePath = NavigationPath()
                              profilePath = NavigationPath()
                            },
                            secondaryButton: .cancel(Text("Cancel"))
                          )
                        }
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
                        .font(.system(size: 18))
                    }
                    
                    // Horizontal separator line
                    Rectangle()
                    .frame(height: 1)
                      .foregroundColor(black)
                  
                    HStack {
                        Text("Date Due: ")
                        .font(.system(size: 18))
                        Text(dateFormat.string(from: errand.dateDue))
                        .font(.system(size: 18))
                    }
                }
                .padding(20)
            }
          
          ErrandDetailsPickUpView(errand: errand, user: user, payViewModel: PayViewModel(errandsViewModel: errandsViewModel, errand: errand), marketplacePath: $marketplacePath, profilePath: $profilePath)
        }
    }
  
}
