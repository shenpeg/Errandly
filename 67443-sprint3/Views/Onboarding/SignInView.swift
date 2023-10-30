//
//  SignInView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/11/23.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @ObservedObject var vm = GoogleSignInButtonViewModel()

  var body: some View {
    VStack {
      HStack {
        VStack {
          GoogleSignInButton(viewModel: vm, action: authViewModel.signIn)
            .accessibilityIdentifier("GoogleSignInButton")
            .accessibility(hint: Text("Sign in with Google button."))
            .padding()
          VStack {
            HStack {
              Text("Button style:")
                .padding(.leading)
              Picker("", selection: $vm.style) {
                ForEach(GoogleSignInButtonStyle.allCases) { style in
                  Text(style.rawValue.capitalized)
                    .tag(GoogleSignInButtonStyle(rawValue: style.rawValue)!)
                }
              }
              Spacer()
            }
            HStack {
              Text("Button color:")
                .padding(.leading)
              Picker("", selection: $vm.scheme) {
                ForEach(GoogleSignInButtonColorScheme.allCases) { scheme in
                  Text(scheme.rawValue.capitalized)
                    .tag(GoogleSignInButtonColorScheme(rawValue: scheme.rawValue)!)
                }
              }
              Spacer()
            }
            HStack {
              Text("Button state:")
                .padding(.leading)
              Picker("", selection: $vm.state) {
                ForEach(GoogleSignInButtonState.allCases) { state in
                  Text(state.rawValue.capitalized)
                    .tag(GoogleSignInButtonState(rawValue: state.rawValue)!)
                }
              }
              Spacer()
            }
          }
            .pickerStyle(.segmented)
        }
      }
      Spacer()
    }
  }
}

