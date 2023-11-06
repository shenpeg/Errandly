import SwiftUI

struct UserProfileInfoView: View {
  var user: User
  var isCurUser: Bool
  
  var body: some View {
    ZStack (alignment: .topLeading) {
      darkBlue
          .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        HStack() {
          
          VStack(alignment: .leading) {
            // temporary, will replace with user profile picture
            Circle()
              .background(Circle())
              .frame(width: 80, height: 80)
          }
          .padding(.trailing, 5)
          
          VStack(alignment: .leading, spacing: 0) {
            
            HStack() {
              Text("\(user.first_name) \(user.last_name)")
                .font(.title)
              
              // this edit icon will need to become a button
              // that redirects to an edit user page
              if (isCurUser) {
                Image(systemName: "pencil")
                  .foregroundColor(Color.white)
                  .font(.system(size: 20))
              }
            }
            .padding(.bottom, 5)
            
            Text("\(user.school_year)")
              .font(.callout)
              .padding(.horizontal, 8)
              .padding(.vertical, 3)
              .foregroundColor(darkBlue)
              .background(Capsule().fill(Color.white))
            
            Text("\(user.bio)")
              .font(.callout)
              .padding(.top, 5)
          }
          
          Spacer()
          
        }
        .padding(.bottom, 10)
        
        HStack() {
          Text("CAN HELP WITH: ")
            .font(.callout)
          
          ForEach(user.can_help_with, id: \.self) {tag in
            Text(tag)
              .font(.callout)
              .padding(.horizontal, 15)
              .foregroundColor(darkGray)
              .background(Capsule().fill(mint))
          }
        }
        
      }
      .padding(30)
      .foregroundColor(.white)
    }
    
    .fixedSize(horizontal: false, vertical: true)
  }
}
