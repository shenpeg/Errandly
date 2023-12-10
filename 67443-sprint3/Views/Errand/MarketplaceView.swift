import SwiftUI

struct MarketplaceView: View {
    var user: User
    
    @EnvironmentObject var errandsViewModel: ErrandsViewModel
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var tabUtil: TabUtil
    @EnvironmentObject var locViewModel: LocationViewModel
    @Binding var marketplacePath: NavigationPath
    @Binding var profilePath: NavigationPath
    
    @State private var searchField = ""
    @State private var selectedTags = ""
    @State private var tagIsClicked: Bool = false
    @State private var showingSheet = false
    @State private var isOnboardingPresented = false
    
    var body: some View {
      ZStack {
        
        NavigationStack(path: $marketplacePath) {
          HStack {
            Spacer()
            Button {
                showingSheet.toggle()
            } label: {
                Text("sort by")
                    .font(.footnote)
                    .padding(.init(top: 4, leading: 7, bottom: 4, trailing: 7))
                    .foregroundColor(black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                          .stroke(Color.black, lineWidth: 1)
                    )
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
                      .padding(.init(top: 4, leading: 7, bottom: 4, trailing: 7))
                      .foregroundColor(black)
                      .background(Capsule().fill(mint))
                      .overlay(
                          RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                      )
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
                            .foregroundColor(black)
                            .background(Capsule().fill(white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                  .stroke(Color.black, lineWidth: 1)
                            )
                      }
                    }
                  }
                }
                Spacer()
            }
            
            List {              
                ForEach(errandsViewModel.filteredErrands) { errand in
                    ErrandView(errand: errand, user: user)
                        .padding(.bottom, 10)
                }
            }
            .background(backgroundGray)
            .navigationBarTitle("Errandly Marketplace", displayMode: .inline)
            
//            .font(Font.custom("Quicksand-VariableFont_wght", size: 30).weight(.bold))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LocationPermissionIconView()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isOnboardingPresented.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(darkBlue)
                            .font(.system(size: 16))
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchField)
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
            .navigationDestination(for: String.self) { id in
              let errand = errandsViewModel.getErrand(id)
              EditErrandView(errand: errand, user: user, marketplacePath: $marketplacePath, profilePath: $profilePath)
            }
        }
        .accentColor(black)
        .sheet(isPresented: $showingSheet) {
            SortSheet(searchField: $searchField, selectedTags: $selectedTags)
        }
        .overlay(
            Group {
                if errandsViewModel.errands.isEmpty {
                    // Display an error message when errands are not available
                    Text("Failed to retrieve errands. Please try again.")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
          
            // Overlay the TutorialView directly on top
            if isOnboardingPresented {
                TutorialView(isOnboardingPresented: $isOnboardingPresented)
                    //.background(Color.white.edgesIgnoringSafeArea(.all))
                    .transition(.opacity)
            }
        }
    }
}
