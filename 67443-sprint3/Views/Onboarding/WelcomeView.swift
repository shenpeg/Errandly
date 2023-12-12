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
              colors: [lightPurple, darkerMint]),
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
            
            Text("Errandly is a marketplace where students help each other with daily errands, and earn a little cash along the way.")
              .font(.title3)
              .foregroundColor(.white)
              .padding(.bottom, 20)
            
            HStack(spacing: 0) {
              Spacer()
              Button(
                action: {self.showSignInView = true}, label: {
                  Text("Continue")
                    .font(.title3)
                    .foregroundColor(black)
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
