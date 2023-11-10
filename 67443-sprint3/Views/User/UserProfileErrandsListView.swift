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
            if (marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["new", "in progress", "completed"])
                  .isEmpty) {
              Section(header: Text("No posted errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["new"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["new"], header: "Waiting for Runners")
              }
              if (!marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["in progress"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["in progress"], header: "In Progress")
              }
              if (!marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["completed"]).isEmpty) {
                PostedErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["completed"], header: "Completed")
              }
            }
          }
          else {
          // picked up errands
            if (marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: ["new", "in progress", "completed"])
                  .isEmpty) {
              Section(header: Text("No picked up errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: ["new", "in progress"])
                    .isEmpty) {
                PickedUpErrandList(marketplaceViewModel: marketplaceViewModel, user: user, status: ["new", "in progress"], header: "In Progress")
              }
              if (!marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: ["completed"]).isEmpty) {
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
  @ObservedObject var marketplaceViewModel: MarketplaceViewModel
  var user: User
  var status: [String]
  var header: String

  var body: some View {
    let postedErrands: [Errand] = marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: status)
    
    return Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(postedErrands) { e in
        let errand = marketplaceViewModel.getErrand(e.id!)
        if status.contains("completed") {
          ErrandView(errand: errand, isCurUser: true, user: user)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
                .padding(.bottom, 10)
        }
         else {
           ErrandView(errand: errand, isCurUser: true, user: user)
                .padding(.bottom, 10)
        }
      }
    }
  }
}

struct PickedUpErrandList: View {
  @ObservedObject var marketplaceViewModel: MarketplaceViewModel
  var user: User
  var status: [String]
  var header: String

  var body: some View {
    let pickedUpErrands: [Errand] = marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: status)

    Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(pickedUpErrands) { e in
        let errand = marketplaceViewModel.getErrand(e.id!)
        if status.contains("completed") {
          ErrandView(errand: errand, isCurUser: false, user: user)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(darkGray.opacity(0.2)))
                .padding(.bottom, 10)
        } else {
          ErrandView(errand: errand, isCurUser: false, user: user)
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
