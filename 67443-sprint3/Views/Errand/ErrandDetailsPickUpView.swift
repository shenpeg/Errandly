//
//  ErrandDetailsPickUpView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//

import SwiftUI

struct ErrandDetailsPickUpView: View {
  @ObservedObject var viewModel: ErrandDetailsViewModel
  @State private var isPickUpAlertPresented = false
  @State private var isCompletionAlertPresented = false

  init(errand: Errand) {
      viewModel = ErrandDetailsViewModel(errand: errand)
  }

  var body: some View {
    let payFormat = String(format: "$%.2f", viewModel.errand.pay)
    
    VStack {
      // Horizontal separator line
      Rectangle()
        .frame(height: 1)
        .foregroundColor(darkBlue)
      
      HStack {
        Text(payFormat)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        if viewModel.errand.status == "new" {
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
                      // change status to in progress:
                      viewModel.markAsInProgress()
                      // add a new PickedUpErrand to the current user
                      // in the new PickedUpErrand, var owner: PickedUpErrandOwner should be the errand owner (viewModel.errand.owner)
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
        } else if viewModel.errand.status == "in progress" {
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
                    primaryButton: .default(Text("Yes, I've completed it!")) {
                        // Change status to completed
                        viewModel.markAsCompleted()
                    },
                    secondaryButton: .cancel(Text("No, Cancel"))
                )
            }
        } else if viewModel.errand.status == "completed" {
            // technically completed ones should only show up in profile not marketplace
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
