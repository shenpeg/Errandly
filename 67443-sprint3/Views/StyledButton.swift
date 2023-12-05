//
//  StyledButtonView.swift
//  67443-sprint3
//  Created by cd on 12/4/23.
//

import Combine
import Foundation
import SwiftUI

struct StyledButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(.white)
            .font(.headline)
            .padding(.init(top: 5, leading: 20, bottom: 8, trailing: 20))
            .background(RoundedRectangle(cornerRadius: 20).fill(darkBlue))
    }
}
