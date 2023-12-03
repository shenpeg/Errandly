import SwiftUI

struct ErrandDetailsPickUpView: View {
  var errand: Errand
  var user: User
  
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var tabUtil: TabUtil
  @StateObject var payViewModel: PayViewModel
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath
  
  @State private var isPickUpAlertPresented = false
  @State private var isCompletionAlertPresented = false

  var body: some View {
    let payFormat = String(format: "$%.2f", errand.pay)
    
    VStack {
      // Horizontal separator line
      Rectangle()
        .frame(height: 1)
        .foregroundColor(darkBlue)
      
      if (errandsViewModel.getErrand(errand.id!).status == "in progress" &&
          usersViewModel.getCurUser()!.id == errand.owner.id) {
        if (payViewModel.paymentSucess) {
          Text("Thanks for paying \(errand.runner!.first_name) \(errand.runner!.last_name)!")
        }
        else {
          PaymentButton(action: payViewModel.pay)
            .padding(.horizontal, 10)
        }
      }
      
      // note: need to check that the owner has actually paid first!
      if (errandsViewModel.getErrand(errand.id!).status == "in progress" &&
          usersViewModel.getCurUser()!.id == errand.runner!.id) {
        if (payViewModel.paymentTransferSucess) {
          Text("\(errand.owner.first_name) \(errand.owner.last_name) has paid you!")
        }
        else {
          Text("Use Transfer Funds with Apple Pay to get your payment")
          PaymentButton(action: payViewModel.payTransfer)
            .padding(.horizontal, 10)
        }
      }
      
      HStack {
        Text(payFormat)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        // note: instead of doing errand.status, 
        // .getErrand() will get the most up to date version of errand,
        // which will force the page to reload when the status gets updated
        if (errandsViewModel.getErrand(errand.id!).status == "new") {
          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
            Text("Can't pick up own errand!")
              .font(.headline)
              .foregroundColor(darkBlue)
              .italic()
          } else {
            Button(action: {
              // Show the pop-up
              isPickUpAlertPresented = true
            }) {
              Text("Pick up errand")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(darkBlue)
                .cornerRadius(40)
            }
            .alert(isPresented: $isPickUpAlertPresented) {
              Alert(
                title: Text("Are you sure you want to pick up this errand?"),
                primaryButton: .default(Text("Yes, I'm sure")) {
                  // change status to in progress and assign runner
                  errandsViewModel.updateErrandStatus(errandID: errand.id!, newStatus: "in progress")
                  usersViewModel.addErrandToUser(userId: user.id!, errandId: errand.id!, type: "picked_up_errands")
                  errandsViewModel.addUserAsRunner(user: user, errand: errand)
                  // redirect to user profile
                  tabUtil.tabSelection = 3
                  tabUtil.profileTabSelection = "Picked Up Errands"
                  marketplacePath = NavigationPath()
                  profilePath = NavigationPath()
                },
                secondaryButton: .cancel(Text("Cancel"))
              )
            }
          }
        }
        else if (errandsViewModel.getErrand(errand.id!).status == "in progress") {
          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
              Button(action: {
                  isCompletionAlertPresented = true
              }) {
                    Text("Mark completed")
                      .font(.headline)
                      .foregroundColor(darkBlue)
                      .padding(.vertical, 8)
                      .padding(.horizontal, 16)
                      .background(mint)
                      .cornerRadius(40)
                  }
                  .alert(isPresented: $isCompletionAlertPresented) {
                      Alert(
                          title: Text("Mark this errand as complete?"),
                          primaryButton: .default(Text("Yes, it's completed!")) {
                            // Change status to completed
                            errandsViewModel.updateErrandStatus(errandID: errand.id!, newStatus: "completed")
                            // redirect to user profile
                            tabUtil.tabSelection = 3
                            tabUtil.profileTabSelection = "Posted Errands"
                            profilePath = NavigationPath()
                          },
                          secondaryButton: .cancel(Text("No, Cancel"))
                      )
                  }
            } else {
               Text("In progress")
                   .font(.headline)
                   .foregroundColor(darkBlue)
                   .italic()
            }
        }
        else if (errandsViewModel.getErrand(errand.id!).status == "completed") {
            Text("Completed")
                .font(.headline)
                .foregroundColor(darkBlue)
                .italic()
        }
    }
    .padding()
    .background(Color.white)
}
}
}
