//
//  ErrandDetailsView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandDetailsView: View {
  var errand: Errand
  var user: User
  
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath

    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(errandsViewModel.getErrand(errand.id!).status)
                            .font(.headline)
                            .foregroundColor(darkBlue)
                            .italic()
                            .bold()
                    }
                    Text(errand.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                  
                    HStack() {
                      ForEach(errand.tags, id: \.self) {tag in
                        Text(tag)
                          .font(.callout)
                          .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
                          .foregroundColor(darkBlue)
                          .background(Capsule().fill(lightGray))
                      }
                    }

                  ErrandDetailsProfileView(errand: errand)
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                      Text(errand.description)
                    }
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text("Date Due:")
                        Text(dateFormat.string(from: errand.dateDue))
                    }
                }
                .padding(20)
            }
          
          ErrandDetailsPickUpView(errand: errand, user: user, payViewModel: PayViewModel(errand: errand), marketplacePath: $marketplacePath, profilePath: $profilePath)
        }
    }
  
}
