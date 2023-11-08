import SwiftUI
import GoogleSignIn

// note: commented all user profile features
// that rely on the ability to edit a user

struct UserProfileInfoView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  var user: User
  var isCurUser: Bool
  
  var body: some View {
    ZStack (alignment: .topLeading) {
      darkBlue
          .ignoresSafeArea()
      
      if (isCurUser) {
        HStack {
          Spacer()
          Button(action: signOut)
          {
            VStack (spacing: 0) {
              Image(systemName: "rectangle.portrait.and.arrow.forward")
                .foregroundColor(Color.white)
                .font(.system(size: 15))
              Text("Sign out")
                .foregroundColor(Color.white)
                .font(.caption)
            }
          }
        }
        .padding(.init(top: 60, leading: 0, bottom: 0, trailing: 20))
        .ignoresSafeArea()
      }
      
      VStack (alignment: .leading) {
        
        HStack() {
          
          VStack(alignment: .leading) {
            if let userProfile = GIDSignIn.sharedInstance.currentUser?.profile {
              UserProfileImageView(userProfile: userProfile)
            }
          }
          .padding(.trailing, 5)
          
          VStack(alignment: .leading, spacing: 0) {
            
            HStack() {
              Text("\(user.first_name) \(user.last_name)")
                .font(.title)
              
              // this edit icon will need to become a button
              // that redirects to an edit user page
//              if (isCurUser) {
//                Image(systemName: "pencil")
//                  .foregroundColor(Color.white)
//                  .font(.system(size: 20))
//              }
            }
            .padding(.bottom, 5)
            
//            Text("\(user.school_year)")
//              .font(.callout)
//              .padding(.horizontal, 8)
//              .padding(.vertical, 3)
//              .foregroundColor(darkBlue)
//              .background(Capsule().fill(Color.white))
//            
//            Text("\(user.bio)")
//              .font(.callout)
//              .padding(.top, 5)
          }
          
          Spacer()
          
        }
        .padding(.bottom, 10)
        
//        HStack() {
//          Text("CAN HELP WITH: ")
//            .font(.callout)
//          
//          ForEach(user.can_help_with, id: \.self) {tag in
//            Text(tag)
//              .font(.callout)
//              .padding(.horizontal, 15)
//              .foregroundColor(darkGray)
//              .background(Capsule().fill(mint))
//          }
//        }
        
      }
      .padding(30)
      .foregroundColor(.white)
    }
    
    .fixedSize(horizontal: false, vertical: true)
  }
  
  func signOut() {
    authViewModel.signOut()
  }
}
