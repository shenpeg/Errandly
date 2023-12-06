//
//  SortSheet.swift
//  Errandly
//

import Foundation
import SwiftUI
import UIKit

struct SortSheet: View {
    @EnvironmentObject var errandsViewModel: ErrandsViewModel
    @Environment(\.dismiss) var dismiss

    @Binding var searchField: String
    @Binding var selectedTags: String // : [String] = []

    @State private var isRecentClicked = false
    @State private var isDueDateClicked = false
    @State private var isCompensationClicked = false

    var body: some View {
        let errands = errandsViewModel.errands

        VStack {
            Text("Sort Errands By:")
                .font(.title2)
                .padding()
            Divider()

            Button {
                isRecentClicked.toggle()
                isDueDateClicked = false
                isCompensationClicked = false

                errandsViewModel.errands = errands.sorted(by: { $0.datePosted > $1.datePosted })
                errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
            } label: {
                Text("Recent")
                    .fontWeight(isRecentClicked ? .bold : .regular)
            }
            .padding()

            Button {
                isRecentClicked = false
                isDueDateClicked.toggle()
                isCompensationClicked = false

                errandsViewModel.errands = errands.sorted(by: { $0.dateDue < $1.dateDue })
                errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
            } label: {
                Text("Due Date")
                    .fontWeight(isDueDateClicked ? .bold : .regular)
            }
            .padding()

            Button {
                isRecentClicked = false
                isDueDateClicked = false
                isCompensationClicked.toggle()

                errandsViewModel.errands = errands.sorted(by: { $0.pay > $1.pay })
                errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
            } label: {
                Text("Compensation")
                    .fontWeight(isCompensationClicked ? .bold : .regular)
            }
            .padding()
        }
        .presentationDetents([.height(300)])
    }
}
