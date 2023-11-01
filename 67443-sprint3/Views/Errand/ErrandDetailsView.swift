//
//  ErrandDetailsView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

// custom colors
let darkBlue = Color(red: 0.09, green: 0.34, blue: 0.95)
let mint = Color(red: 0.84, green: 0.99, blue: 0.96)
let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)

struct ErrandDetailsView: View {
    var errand: Errand

    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(errand.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                  
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                    
                    ErrandDetailsProfileView(errand: errand)
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text(errand.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                  
                    // replacement description text to test formatting
                    Text("I have a cute cat that needs petsitting this weekend. Preferably you are a cat owner yourself otherwise I can teach u the basics.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    Text("I live at One on Centre. Please reach out to me before u pick up this errand and we can discuss details!!")
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text("Date Due:")
                        Text(dateFormat.string(from: errand.date_due))
                    }
                    
                    HStack {
                        Text("Status:")
                        Text(errand.status)
                    }
                }
                .padding(20)
                .navigationBarTitle("Errand Details", displayMode: .inline)
            }
            
            // Include the ErrandDetailsPickUpView here
            ErrandDetailsPickUpView(errand: errand)
        }
    }
}
