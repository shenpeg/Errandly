//
//  TutorialView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/27/23.
//
import SwiftUI

struct TutorialView: View {
    @Binding var isOnboardingPresented: Bool
    @State private var currentStep = 1

    var body: some View {
      ZStack {
        // Semi-transparent black background
        Color.black.opacity(0.2)
          .edgesIgnoringSafeArea(.all)

        Image("Tutorial\(currentStep)")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: imageSizeForStep().width, height: imageSizeForStep().height)
          .padding(.top, topPaddingForImage())
          .overlay(
            // Text and buttons overlay
            VStack {
              Spacer()

              VStack {
                Spacer()
                  if currentStep == 1 {
                      Text("Welcome to Errandly!")
                        .font(.headline.italic())
                        .foregroundColor(darkBlue)
                        .padding(.bottom, 3)
                  
                      Text("Let's begin with a tour!")
                        .font(.subheadline.italic())
                        .foregroundColor(darkBlue)
                        .padding(.bottom, 3)
                  } else {
                      Text(stepText())
                        .font(.headline.italic())
                        .foregroundColor(darkBlue)
                        .padding(.bottom, 2)
                        .frame(maxWidth: 200, alignment: .center)
                  }

                VStack {
                    if currentStep == 6 {
                        Button(action: {
                            // Handle "Let's go!" button action
                            isOnboardingPresented = false
                        }) {
                            Text("Let's go!")
                                .padding(.horizontal, 25)
                                .padding(.vertical, 6)
                                .padding(.bottom, 4)
                                .background(darkBlue)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                        }
                        .padding()

                        Button(action: {
                            // Handle "Replay tutorial" button action
                            currentStep = 1
                        }) {
                            Text("Replay tutorial")
                                .font(.system(size: 16).italic())
                                .underline(true, color: darkBlue)
                                .foregroundColor(darkBlue)
                        }
                        .padding(.top, -8)
                      } else {
                         Button(action: {
                             // Handle "Next" button action (e.g., move to the next tutorial step)
                             if currentStep < totalSteps {
                                 currentStep += 1
                             } else {
                                 isOnboardingPresented = false
                             }
                         }) {
                             Text("Next")
                                 .padding(.horizontal, 25)
                                 .padding(.vertical, 8)
                                 .padding(.bottom, 1)
                                 .background(darkBlue)
                                 .foregroundColor(.white)
                                 .cornerRadius(40)
                         }
                         .padding()

                         Button(action: {
                             // Handle "Skip" button action
                             isOnboardingPresented = false
                             // Add navigation logic to Marketplace view if needed
                         }) {
                             Text("Skip")
                                 .font(.system(size: 16).italic())
                                 .underline(true, color: darkBlue)
                                 .foregroundColor(darkBlue)
                         }
                         .padding(.top, -8)
                     }
                  }
                  Spacer()
                }
                .background(Color.clear)
                .padding(paddingForStep())
              }
          )
      }
      .onTapGesture {
          // Handle tap on the overlay (e.g., move to the next tutorial step)
          if currentStep < totalSteps {
              currentStep += 1
          } else {
              isOnboardingPresented = false
          }
      }
  }
  
    // CUSTOMIZATIONS FOR EACH TUTORIAL STEP

    func stepText() -> String {
        // Define the text for each step based on the current step
        switch currentStep {
        case 1:
            return "Welcome to Errandly!"
        case 2:
            return "Here is where you browse errands posted by others"
        case 3:
            return "You can post an errand of your own for others to help you with"
        case 4:
            return "Your posting history & info is saved in your profile, which you can edit there"
        case 5:
            return "Rewatch the tutorial anytime up here!"
        case 6:
            return "You're ready to go :)"
        default:
            return ""
        }
    }

  func paddingForStep() -> EdgeInsets {
      // location of text and buttons for each step
      var topPadding: CGFloat = 0
      var leadingPadding: CGFloat = 0
      var trailingPadding: CGFloat = 0

      switch currentStep {
      case 1, 6:
          topPadding = 40
      case 2:
          topPadding = 345
          leadingPadding = 55
      case 4:
          topPadding = 350
          trailingPadding = 75
      case 3:
          topPadding = 300
      case 5:
          topPadding = -350
          trailingPadding = 80
      default:
          break
      }

      return EdgeInsets(top: topPadding, leading: leadingPadding, bottom: 0, trailing: trailingPadding)
  }
  
    func horizontalPaddingForStep() -> CGFloat {
        // Left and right padding for each step (the text and buttons)
        switch currentStep {
        case 2:
            return 80
        case 4, 5:
            return -80
        default:
            return 0
        }
    }
  
    func topPaddingForImage() -> CGFloat {
        // Top padding for the image
        switch currentStep {
        case 1, 6:
            return 0
        case 2, 4:
            return 350
        case 3:
            return 230
        case 5:
            return -350
        default:
            return 0
        }
    }
  
    func imageSizeForStep() -> CGSize {
        switch currentStep {
        case 1, 6:
            return CGSize(width: 300, height: 300)
        case 2:
            return CGSize(width: 400, height: 400)
        case 3:
            return CGSize(width: 450, height: 450)
        case 4, 5:
          return CGSize(width: 350, height: 350)
        default:
            return CGSize(width: 300, height: 300)
        }
    }

    let totalSteps = 6
}
