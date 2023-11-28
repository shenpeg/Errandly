//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct MarketplaceView: View {
  var user: User
  
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @EnvironmentObject var tabUtil: TabUtil
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath
  
  @State private var searchField = ""
  @State private var selectedTags = "" // : [String] = []
  @State private var tagIsClicked: Bool = false
  @State private var showingSheet = false
  @State private var isOnboardingPresented = false
  
  var body: some View {
    let searchFieldBinding = Binding<String>(get: {
      self.searchField
    }, set: {
      self.searchField = $0
      errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
    })
    
     return NavigationStack(path: $marketplacePath) {
      HStack {
        Spacer()
        Button {
          showingSheet.toggle()

        } label: {
          Text("sort by")
            .font(.footnote)
            .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
            .foregroundColor(darkBlue)
            .background(Capsule().fill(lightGray))
        }
        Text("|")
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            if (selectedTags != "") {
              Button {
                tagIsClicked = !tagIsClicked
                selectedTags = ""
                errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
              } label: {
                Text(selectedTags)
                  .font(.footnote)
                  .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                  .foregroundColor(darkBlue)
                  .background(Capsule().fill(mint))
              }
            }
            ForEach(tags.filter { $0 != selectedTags }, id: \.self) { tag in
              Button {
                tagIsClicked = !tagIsClicked
                if (tagIsClicked || selectedTags != "") {
                  selectedTags = tag
                } else {
                  selectedTags = ""
                }
                errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
              } label: {
                Text(tag)
                  .font(.footnote)
                  .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                  .foregroundColor(darkBlue)
                  .background(Capsule().fill(lightGray))
              }
            }
          }
        }
        
        Spacer()
        // tutorial button
        Button(action: {
            isOnboardingPresented.toggle()
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
                .font(.system(size: 24))
                .padding()
                .background(Circle().fill(Color.white))
                .shadow(radius: 2)
        }
        .sheet(isPresented: $isOnboardingPresented) {
            TutorialView(isOnboardingPresented: $isOnboardingPresented)
        }
        // ^ modify tutorial button
      }
      List {
        ForEach(errandsViewModel.filteredErrands) { errand in
          ErrandView(errand: errand, user: user)
            .padding(.bottom, 10)
        }
      }
      .navigationBarTitle("Marketplace", displayMode: .inline)
      .listStyle(.plain)
      .searchable(text: searchFieldBinding)
      .navigationDestination(for: Errand.self) { errand in
        ErrandDetailsView(errand: errand, user: user, marketplacePath: $marketplacePath, profilePath: $profilePath)
      }
      .navigationDestination(for: ErrandOwner.self) { errandOwner in
        let errandOwnerUser = usersViewModel.getUser(userId: errandOwner.id)
        UserProfileView(user: errandOwnerUser!)
      }
      .navigationDestination(for: User.self) { user in
        EditUserProfileView(user: user)
         .environmentObject(authViewModel)
      }
    }
    .accentColor(.black)
    .sheet(isPresented: $showingSheet) {
      SortSheet(searchField: $searchField, selectedTags: $selectedTags)
    }
  }
}
