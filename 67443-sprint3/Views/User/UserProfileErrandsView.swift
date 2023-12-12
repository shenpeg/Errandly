// tutorial for custom tabs: https://blog.logrocket.com/build-swiftui-segmented-customizable-control/

import SwiftUI

struct UserProfileErrandsView: View {
  var user: User
  
  @EnvironmentObject var tabUtil: TabUtil

  let tabs: [String] = ["Posted Errands", "Picked Up Errands"]
  
  var body: some View {
    
    VStack (alignment: .leading) {
      CustomErrandTabs(tabs, selection: tabUtil.profileTabSelection) { tab in
        Text(tab)
          .font(.title3)
          .foregroundColor(tabUtil.profileTabSelection == tab ? black : .white)
          .padding(.vertical, 8)
          .padding(.horizontal, 8)
          .frame(maxWidth: .infinity)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.150)) {
              tabUtil.profileTabSelection = tab
            }
          }
      }
      .background(darkBlue)
      
      UserProfileErrandsListView(user: user)
    }
    
  }
}
