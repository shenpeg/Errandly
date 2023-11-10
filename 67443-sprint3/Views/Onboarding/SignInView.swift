import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @ObservedObject var vm = GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)
  var information: String

  var body: some View {
    ZStack() {
      LinearGradient(
        gradient: Gradient(
          colors: [darkBlue, lightPurple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()
      
      VStack(alignment: .leading) {
        Text(information)
          .font(.title3)
          .foregroundColor(.white)
          .padding(.bottom, 20)
        
        GoogleSignInButton(viewModel: vm, action: authViewModel.signIn)
      }
      .padding(.all, 30)
      
    }
  }
}
