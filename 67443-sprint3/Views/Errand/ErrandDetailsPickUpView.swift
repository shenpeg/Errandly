//
//  ErrandDetailsPickUpView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//

import SwiftUI

struct ErrandDetailsPickUpView: View {
    var errand: Errand
    //var pickUpAction: () -> Void

    var body: some View {
      let payFormat = String(format: "$%.2f", errand.pay)

      HStack {
        Text("Pay:")
        Text(payFormat)
            .font(.headline)
            .foregroundColor(.black)

        Spacer()

        Button(action: {
            // Your action when the button is tapped
        }) {
            Text("Pick up errand")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(darkBlue)
                .cornerRadius(40)
        }
        .disabled(true) // Disable the button
      }
      .padding()
      .background(Color.white)
    }
}


