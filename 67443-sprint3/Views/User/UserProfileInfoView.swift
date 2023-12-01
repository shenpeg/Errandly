import SwiftUI
import GoogleSignIn

struct UserProfileInfoView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @EnvironmentObject var usersViewModel: UsersViewModel
  var user: User
  func message() {
    MessagesService().sendMessage("\(user.phone_number)")
  }
  
  var body: some View {
    
    ZStack (alignment: .topLeading) {
      darkBlue
          .ignoresSafeArea()
      
      if (usersViewModel.getCurUser()!.id == user.id) {
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
            UserProfileImageView(pfp: user.pfp, size: 80)
          }
          .padding(.trailing, 5)
          
          VStack(alignment: .leading, spacing: 0) {
            
            HStack() {
              Text("\(user.first_name) \(user.last_name)")
                .font(.title)
              
              if (usersViewModel.getCurUser()!.id == user.id) {
                NavigationLink(value: user) {
                  Image(systemName: "square.and.pencil")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                }
              }
              
              if (usersViewModel.getCurUser()!.id != user.id) {
                  Button(action: message) {
                Image(systemName: "envelope")
                  .foregroundColor(Color.white)
                  .font(.system(size: 20))
              }
            }
            }
            .padding(.bottom, 5)
              
             
            if (user.school_year != "") {
              Text("\(user.school_year)")
                .font(.callout)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .foregroundColor(darkBlue)
                .background(Capsule().fill(Color.white))
            }
            if (user.bio != "") {
              Text("\(user.bio)")
                .font(.callout)
                .padding(.top, 5)
            }
          }
          
          Spacer()
          
        }
        .padding(.bottom, 10)
        
        if (user.can_help_with.count != 0) {
          HStack() {
            Text("CAN HELP WITH: ")
              .font(.callout)
            
            ForEach(user.can_help_with, id: \.self) {tag in
              Text(tag)
                .font(.caption)
                .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                .foregroundColor(darkGray)
                .background(Capsule().fill(mint))
            }
          }
        }
        
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
