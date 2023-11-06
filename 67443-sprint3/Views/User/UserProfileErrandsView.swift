// tutorial for custom tabs: https://blog.logrocket.com/build-swiftui-segmented-customizable-control/

import SwiftUI

struct UserProfileErrandsView: View {
  var user: User
  var isCurUser: Bool
  
  let tabs = ["Posted Errands", "Picked Up Errands"]
  @State var selectedTab: String = "Posted Errands"
  
  var body: some View {
    
    VStack (alignment: .leading) {
      CustomErrandTabs(tabs, selection: selectedTab) { tab in
        Text(tab)
          .font(.title3)
          .foregroundColor(selectedTab == tab ? darkGray : .white)
          .padding(.vertical, 8)
          .padding(.horizontal, 8)
          .frame(maxWidth: .infinity)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.150)) {
              selectedTab = tab
            }
          }
      }
      
      UserProfileErrandsListView(user: user, isCurUser: isCurUser, isPostedErrands: (selectedTab == "Posted Errands"))
    }
    
  }
}
