//
//  ErrandDetailsPickUpView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//

import SwiftUI

struct ErrandDetailsPickUpView: View {
  var errand: Errand
  @State private var isAlertPresented = false
  var errandStatusChanged: () -> Void // Callback to handle the status change


  var body: some View {
    let payFormat = String(format: "$%.2f", errand.pay)
    
    VStack {
      // Horizontal separator line
      Rectangle()
        .frame(height: 1)
        .foregroundColor(darkBlue)
      
      HStack {
        Text("Pay:")
        Text(payFormat)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        if errand.status == "new" {
            Button(action: {
                // Show the pop-up
                isAlertPresented = true
            }) {
                Text("Pick up errand")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(darkBlue)
                    .cornerRadius(40)
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("Are you sure you want to pick up this errand?"),
                    primaryButton: .default(Text("Yes, I'm sure")) {
                        // Handle the user's confirmation action
                        // need to change errand.status to in progress
                        errandStatusChanged()
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
        } else if errand.status == "in progress" {
            Button(action: {
              // handle the "Mark completed" action
              // basically change errand.status to completed
            }) {
              Text("Mark completed")
                .font(.headline)
                .foregroundColor(darkBlue)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(mint)
                .cornerRadius(40)
            }
        } else if errand.status == "completed" {
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
