//
//  ErrandDetailsView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandDetailsView: View {
    @ObservedObject var viewModel: ErrandDetailsViewModel

    init(errand: Errand, user: User) {
        viewModel = ErrandDetailsViewModel(errand: errand, user: user)
    }

    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(viewModel.errand.status)
                            .font(.headline)
                            .foregroundColor(darkBlue)
                            .italic()
                            .bold()
                    }
                    Text(viewModel.errand.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                  
                    HStack() {
                      ForEach(viewModel.errand.tags, id: \.self) {tag in
                        Text(tag)
                          .font(.callout)
                          .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                          .foregroundColor(darkBlue)
                          .background(Capsule().fill(lightGray))
                      }
                    }

                    ErrandDetailsProfileView(errand: viewModel.errand)
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                      Text(viewModel.errand.description)
                    }
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text("Date Due:")
                        Text(dateFormat.string(from: viewModel.errand.dateDue))
                    }
                }
                .padding(20)
            }
          
          ErrandDetailsPickUpView(errand: viewModel.errand, user: viewModel.user)
        }
    }
  
}
