import SwiftUI

struct UserProfileErrandsListView: View {
  var user: User
  var isCurUser: Bool
  var isPostedErrands: Bool
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()

  var body: some View {
    List {
      if !marketplaceViewModel.errandViewModels.isEmpty {
        if isPostedErrands {
          postedErrandsSection(user: user)
        } else {
          pickedUpErrandsSection(user: user)
        }
      }
    }
    .listStyle(.plain)
  }
  
  // UserProfileErrandsListView
  private func postedErrandsSection(user: User) -> some View {
    let newPostedErrands = marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["new"])
    let inProgressPostedErrands = marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["in progress"])
    let completedPostedErrands = marketplaceViewModel.getPostedErrandsByStatus(user: user, statuses: ["completed"])

      return Group {
          if !newPostedErrands.isEmpty {
              AnyView(PostedErrandList(
                  marketplaceViewModel: marketplaceViewModel,
                  user: user,
                  status: ["new"],
                  header: "Waiting for Runners"
              ))
          }
          if !inProgressPostedErrands.isEmpty {
              AnyView(PostedErrandList(
                  marketplaceViewModel: marketplaceViewModel,
                  user: user,
                  status: ["in progress"],
                  header: "In Progress"
              ))
          }
          if !completedPostedErrands.isEmpty {
              AnyView(PostedErrandList(
                  marketplaceViewModel: marketplaceViewModel,
                  user: user,
                  status: ["completed"],
                  header: "Completed"
              ))
          }
      }
  }

  // UserProfileErrandsListView
  private func pickedUpErrandsSection(user: User) -> some View {
      let newInProgressErrands = marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: ["new", "in progress"])
      let completedPickedUpErrands = marketplaceViewModel.getPickedUpErrandsByStatus(user: user, statuses: ["completed"])

      return Group {
          if !newInProgressErrands.isEmpty {
              AnyView(PickedUpErrandList(
                  marketplaceViewModel: marketplaceViewModel,
                  user: user,
                  status: ["new", "in progress"],
                  header: "In Progress"
              ))
          }
          if !completedPickedUpErrands.isEmpty {
              AnyView(PickedUpErrandList(
                  marketplaceViewModel: marketplaceViewModel,
                  user: user,
                  status: ["completed"],
                  header: "Completed"
              ))
          }
      }
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
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                  .fill(darkGray.opacity(0.2)))
                .frame(width: 340)
                .offset(y: -5)
                .padding(8)
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
