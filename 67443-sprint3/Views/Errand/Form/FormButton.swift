//
//  StyledButtonView.swift
//  67443-sprint3
//  Created by cd on 12/4/23.
//

import Combine
import Foundation
import SwiftUI

struct FormButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(white)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .padding(.init(top: 4, leading: 15, bottom: 5, trailing: 15))
            .background(RoundedRectangle(cornerRadius: 20)
              .fill(darkBlue))
    }
}
