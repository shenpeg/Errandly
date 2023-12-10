import SwiftUI

struct LocationSearchClearButton: View {
  
  @Binding var text: String
  
  var body: some View {
    if text.isEmpty == false {
      HStack {
        Spacer()
        Button {
          text = ""
        } label: {
          Image(systemName: "multiply.circle.fill")
            .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
        }
        .foregroundColor(.secondary)
      }
    }
    
    else {
      EmptyView()
    }
    
  }
}
