import SwiftUI

struct UserProfileErrandsListView: View {
  var user: User
  var isCurUser: Bool
  var isPostedErrands: Bool
  @EnvironmentObject var errandsViewModel: ErrandsViewModel

  var body: some View {
      List {
        
          if (isPostedErrands) {
            let postedErrands = errandsViewModel.getErrandsByStatus(user.posted_errands)
            if (postedErrands["new"]!.isEmpty && postedErrands["in progress"]!.isEmpty && postedErrands["completed"]!.isEmpty) {
              Section(header: Text("No posted errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!postedErrands["new"]!.isEmpty) {
                PostedErrandList(user: user, postedErrands: postedErrands["new"]!, isCompleted: false, header: "Waiting for Runners")
              }
              if (!postedErrands["in progress"]!.isEmpty) {
                PostedErrandList(user: user, postedErrands: postedErrands["in progress"]!, isCompleted: false, header: "In Progress")
              }
              if (!postedErrands["completed"]!.isEmpty) {
                PostedErrandList(user: user, postedErrands: postedErrands["completed"]!, isCompleted: true, header: "Completed")
              }
            }
          }
          else {
          // picked up errands
          // note: picked up errands never have a status of new
            let pickedUpErrands = errandsViewModel.getErrandsByStatus(user.picked_up_errands)
            if (pickedUpErrands["in progress"]!.isEmpty && pickedUpErrands["completed"]!.isEmpty) {
              Section(header: Text("No picked up errands").padding(.top, 30)) {EmptyView()}
            }
            else {
              if (!pickedUpErrands["in progress"]!.isEmpty) {
                PickedUpErrandList(user: user, pickedUpErrands: pickedUpErrands["in progress"]!, isCompleted: false, header: "In Progress")
              }
              if (!pickedUpErrands["completed"]!.isEmpty) {
                PickedUpErrandList(user: user, pickedUpErrands: pickedUpErrands["completed"]!, isCompleted: true, header: "Completed")
              }
            }
        }
        
      }
      .listStyle(.plain)
    
  }
}

struct PostedErrandList: View {
  var user: User
  var postedErrands: [Errand]
  var isCompleted: Bool
  var header: String

  var body: some View {
    return Section(header: HeaderStyle(header: header)
      .font(.title3)
      .italic()
      .foregroundColor(darkGray)
    ) {
      ForEach(postedErrands.sorted(by: {$0.datePosted > $1.datePosted})) { errand in
        if (isCompleted) {
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
