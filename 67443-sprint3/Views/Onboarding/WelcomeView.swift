import SwiftUI

struct WelcomeView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @State var showSignInView: Bool = false
  
  var body: some View {
    switch authViewModel.state {
    case .signedIn:
      ContentView()
        .environmentObject(authViewModel)
    
    case .signedOutBtn:
      SignInView(information: "Sign back in with your college email address.")
        .environmentObject(authViewModel)
    
    case .signedOut:
      switch showSignInView {
      case true:
          SignInView(information: "Sign in with your college email address to get started.")
            .environmentObject(authViewModel)
      
      case false:
        ZStack() {
          LinearGradient(
            gradient: Gradient(
              colors: [darkBlue, Color(red: 0.87, green: 0.67, blue: 0.18)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
          .ignoresSafeArea()
          
          VStack(alignment: .leading) {
            Text("Welcome!")
              .font(.title)
              .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
              .foregroundColor(mint)
              .padding(.bottom, 10)
            
            Text("NexTask is a marketplace where students to help out each other with overwhelming daily tasks, and earn a little cash along the way.")
              .font(.title3)
              .foregroundColor(.white)
              .padding(.bottom, 20)
            
            HStack(spacing: 0) {
              Spacer()
              Button(
                action: {self.showSignInView = true}, label: {
                  Text("Continue")
                    .font(.title3)
                    .foregroundColor(darkBlue)
                    .frame(maxWidth: .infinity)
                })
              .padding(.vertical, 10)
              .background(mint)
              .clipShape(Capsule())
              Spacer()
            }
          }
          .padding(.all, 30)
          
        }
      }
    }
  }
}
