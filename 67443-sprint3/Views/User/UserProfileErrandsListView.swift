import SwiftUI

struct UserProfileErrandsListView: View {
  var user: User
  var isCurUser: Bool
  var isPostedErrands: Bool
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()

  var body: some View {
      List {
        
        // note: need to ensure that the errandViewModels have been initialized
        if (!marketplaceViewModel.errandViewModels.isEmpty) {
          if (isPostedErrands) {
            if (user.posted_errands.isEmpty) {
              Section(header: Text("No posted errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!user.getPostedErrandsByStatus(["new"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["new"], header: "Waiting for Runners")
              }
              if (!user.getPostedErrandsByStatus(["in progress"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["in progress"], header: "In Progress")
              }
              if (!user.getPostedErrandsByStatus(["completed"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["completed"], header: "Completed")
              }
            }
          }
          else { 
          // picked up errands
            if (user.picked_up_errands.isEmpty) {
              Section(header: Text("No picked up errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!user.getPickedUpErrandsByStatus(["new", "in progress"]).isEmpty) {
                PickedUpErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["new", "in progress"], header: "In Progress")
              }
              if (!user.getPickedUpErrandsByStatus(["completed"]).isEmpty) {
                PickedUpErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["completed"], header: "Completed")
              }
            }
          }
        }
        
      }
      .listStyle(.plain)
    
  }
}

struct PostedErrandList: View {
  var marketplaceViewModel: MarketplaceViewModel
  var user: User
  var status: [String]
  var header: String

  var body: some View {
    Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(user.getPostedErrandsByStatus(status)) { errand in
        if (status.contains("completed")) {
          ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: true)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
            .padding(.bottom, 10)
        }
        else {
          ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: true)
            .padding(.bottom, 10)
        }
      }
    }
  }
}

struct PickedUpErrandList: View {
  var marketplaceViewModel: MarketplaceViewModel
  var user: User
  var status: [String]
  var header: String

  var body: some View {
    Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(user.getPickedUpErrandsByStatus(status)) { errand in
        if (status.contains("completed")) {
          ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: false)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
            .padding(.bottom, 10)
        }
        else {
          ErrandView(errand: marketplaceViewModel.getErrand(errand.id), isCurUser: false)
            .padding(.bottom, 10)
        }
      }
    }
  }
}

struct HeaderStyle: View {
  var header: String

  var body: some View {
    Text(header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
      .padding(.vertical, 5)
  }
}
