import SwiftUI

struct FormTags: View {
  
  @Binding var formTags: [String]
  
  var body: some View {
    HStack {
      ForEach(0..<3) { col in
        let tag = tags[col]
        SelectTag(
          formTags: $formTags,
          tag: tag,
          isSelected: formTags.contains(tag)
        )
      }
    }
    .padding(.bottom, 10)
    
    HStack {
      ForEach(3..<6) { col in
        let tag = tags[col]
        SelectTag(
          formTags: $formTags,
          tag: tag,
          isSelected: formTags.contains(tag)
        )
      }
    }
    .padding(.bottom, 10)
    
    HStack {
      ForEach(6..<9) { col in
        let tag = tags[col]
        SelectTag(
          formTags: $formTags,
          tag: tag,
          isSelected: formTags.contains(tag)
        )
      }
    }
    .padding(.bottom, 10)
    
    HStack {
      ForEach(9..<11) { col in
        let tag = tags[col]
        SelectTag(
          formTags: $formTags,
          tag: tag,
          isSelected: formTags.contains(tag)
        )
      }
    }
    .padding(.bottom, 10)
  }
}

struct SelectTag: View {
  @Binding var formTags: [String]
  var tag: String
  var isSelected: Bool

  var body: some View {
    Button(action: {
      if formTags.count < 3 && !formTags.contains(tag) {
        formTags.append(tag)
      }
      else {
        formTags.removeAll(where: { $0 == tag })
      }
    } ) {
      TagView(tag: self.tag, viewOnly: false, isSelected: self.isSelected)
    }
    // https://www.hackingwithswift.com/forums/swiftui/tap-button-in-hstack-activates-all-button-actions-ios-14-swiftui-2/2952
    // why does work though??
      .buttonStyle(BorderlessButtonStyle())
      
  }
}

