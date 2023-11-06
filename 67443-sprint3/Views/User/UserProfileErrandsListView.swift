import SwiftUI

struct UserProfileErrandsListView: View {
  var user: User
  var isCurUser: Bool
  var isPostedErrands: Bool
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()

  var body: some View {
    NavigationView {
      List {
        
        // note: need to ensure that the errandViewModels have been initialized
        if (isPostedErrands && !marketplaceViewModel.errandViewModels.isEmpty && !user.getPostedErrandsByStatus(["new", "in progress"]).isEmpty) {
          Section() {
            ForEach(user.getPostedErrandsByStatus(["new", "in progress"])) { errand in
              ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: isCurUser)
                .padding(.bottom, 10)
            }
          }
          .padding(.top, 30)
        }
        else if (!isPostedErrands && !marketplaceViewModel.errandViewModels.isEmpty && !user.getPickedUpErrandsByStatus(["new", "in progress"]).isEmpty) {
          Section() {
            ForEach(user.getPickedUpErrandsByStatus(["new", "in progress"])) { errand in
              ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: false)
                .padding(.bottom, 10)
            }
          }
          .padding(.top, 30)
        }
    
        if (isPostedErrands && !marketplaceViewModel.errandViewModels.isEmpty && !user.getPostedErrandsByStatus(["completed"]).isEmpty) {
          Section(header: Text("Completed")
            .font(.title3)
            .italic()
            .foregroundColor(darkGray)
            .padding(.bottom, 20)
          ) {
            ForEach(user.getPostedErrandsByStatus(["completed"])) { errand in
              ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: isCurUser)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
                .padding(.bottom, 10)
            }
          }
        }
        else if (!isPostedErrands && !marketplaceViewModel.errandViewModels.isEmpty && !user.getPickedUpErrandsByStatus(["completed"]).isEmpty) {
          Section(header: Text("Completed")
            .font(.title3)
            .italic()
            .foregroundColor(darkGray)
            .padding(.bottom, 20)
          ) {
            ForEach(user.getPickedUpErrandsByStatus(["completed"])) { errand in
              ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: false)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
                .padding(.bottom, 10)
            }
          }
        }
        
      }
      .listStyle(.plain)
    }
    
  }
}
