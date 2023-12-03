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
        .foregroundColor(black)
      
      if (errandsViewModel.getErrand(errand.id!).status == "in progress" &&
          usersViewModel.getCurUser()!.id == errand.owner.id) {
        if (payViewModel.paymentSucess) {
          Text("Thanks for paying \(errand.runner!.first_name) \(errand.runner!.last_name)!")
        }
        else {
          PaymentButton(action: payViewModel.pay)
            .padding()
        }
      }
      
      HStack {
        Text(payFormat)
          .font(.system(size: 22))
          .foregroundColor(.black)
        
        Spacer()
        
        // note: instead of doing errand.status, 
        // .getErrand() will get the most up to date version of errand,
        // which will force the page to reload when the status gets updated
        if (errandsViewModel.getErrand(errand.id!).status == "new") {
          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
            VStack(alignment: .leading) {
              Text("Can't pick up your")
                .font(.footnote)
                .foregroundColor(darkBlue)
                .italic()
              Text("own errand!")
                .font(.footnote)
                .foregroundColor(darkBlue)
                .italic()
            }
            
          } else {
            Button(action: {
              // Show the pop-up
              isPickUpAlertPresented = true
            }) {
              Text("Pick up errand")
                .font(.system(size: 18).bold())
                .foregroundColor(.white)
                .padding(.init(top: 5, leading: 20, bottom: 7, trailing: 20))
                .background(darkBlue)
                .cornerRadius(20)
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
        else if (errandsViewModel.getErrand(errand.id!).status.contains("in progress")) {
          if (usersViewModel.getCurUser()!.id == errand.owner.id) {
              Button(action: {
                  isCompletionAlertPresented = true
              }) {
                    Text("Mark completed")
                      .font(.system(size: 18).bold())
                      .foregroundColor(darkBlue)
                      .padding(.init(top: 5, leading: 20, bottom: 7, trailing: 20))
                      .background(mint)
                      .cornerRadius(20)
                      .overlay(
                          RoundedRectangle(cornerRadius: 20)
                            .stroke(darkBlue, lineWidth: 1)
                      )

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
    .padding(.init(top: 4, leading: 30, bottom: 6, trailing: 25))
    .background(Color.white)
}
}
}
