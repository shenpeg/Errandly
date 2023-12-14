import SwiftUI

struct UserProfileErrandsListView: View {
  var user: User
  
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var tabUtil: TabUtil

  var body: some View {
    List {
      if (tabUtil.profileTabSelection == "Posted Errands") {
        postedErrandsSection(user: user)
      } else {
        pickedUpErrandsSection(user: user)
      }
    }
    .listStyle(.plain)
    .background(backgroundGray)
  }
  
  // UserProfileErrandsListView
  private func postedErrandsSection(user: User) -> some View {
    let postedErrands = errandsViewModel.getErrandsByStatus(user.posted_errands)
    
    return Group {
      if (postedErrands["new"]!.isEmpty && postedErrands["in progress"]!.isEmpty && postedErrands["completed"]!.isEmpty) {
        Section(header: Text("No posted errands").padding(.top, 30)) {
          EmptyView()
        }
      }
      else {
        if (!postedErrands["new"]!.isEmpty) {
          AnyView(PostedErrandList(
            user: user,
            postedErrands: postedErrands["new"]!,
            isCompleted: false,
            header: "Waiting for Runners"
          ))
        }
        if (!postedErrands["in progress"]!.isEmpty) {
          AnyView(PostedErrandList(
            user: user,
            postedErrands: postedErrands["in progress"]!,
            isCompleted: false,
            header: "In Progress"
          ))
        }
        if (!postedErrands["completed"]!.isEmpty) {
          AnyView(PostedErrandList(
            user: user,
            postedErrands: postedErrands["completed"]!,
            isCompleted: true,
            header: "Completed"
          ))
        }
      }
    }
  }

  // UserProfileErrandsListView
  private func pickedUpErrandsSection(user: User) -> some View {
    let pickedUpErrands = errandsViewModel.getErrandsByStatus(user.picked_up_errands)

    return Group {
      if (pickedUpErrands["in progress"]!.isEmpty && pickedUpErrands["completed"]!.isEmpty) {
        Section(header: Text("No picked up errands").padding(.top, 30)) {EmptyView()}
      }
      else {
        if (!pickedUpErrands["in progress"]!.isEmpty) {
          AnyView(PickedUpErrandList(
            user: user,
            pickedUpErrands: pickedUpErrands["in progress"]!,
            isCompleted: false,
            header: "In Progress"
          ))
        }
        if (pickedUpErrands["completed"]!.isEmpty) {
          AnyView(PickedUpErrandList(
            user: user,
            pickedUpErrands: pickedUpErrands["completed"]!,
            isCompleted: true,
            header: "Completed"
          ))
        }
      }
    }
  }
}

struct PostedErrandList: View {
  var user: User
  var postedErrands: [Errand]
  var isCompleted: Bool
  var header: String
  
  var body: some View {
    return Section(header: HeaderStyle(header: header)) {
      ForEach(postedErrands.sorted(by: {$0.datePosted > $1.datePosted})) { errand in
        if (isCompleted) {
          ErrandView(errand: errand, user: user, grayOut: true)
//            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(darkGray.opacity(0.2)))
            .padding(.bottom, 10)
//            .overlay(RoundedRectangle(cornerRadius: 10).fill(black.opacity(0.1)))
        }
         else {
           ErrandView(errand: errand, user: user, grayOut: false)
            .padding(.bottom, 10)
        }
      }
    }
  }
}

struct PickedUpErrandList: View {
  var user: User
  var pickedUpErrands: [Errand]
  var isCompleted: Bool
  var header: String
  
  var body: some View {
    Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(pickedUpErrands.sorted(by: {$0.datePosted > $1.datePosted})) { errand in
        if (isCompleted) {
          ErrandView(errand: errand, user: user, grayOut: true)
//            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(black.opacity(0.2)))
            .padding(.bottom, 10)
//            .overlay(RoundedRectangle(cornerRadius: 10).fill(black.opacity(0.2)))
        } else {
          ErrandView(errand: errand, user: user, grayOut: false)
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
      .background(backgroundGray)
      .padding(.vertical, 5)
  }
}
