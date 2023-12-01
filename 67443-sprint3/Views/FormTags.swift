import SwiftUI

struct FormTags: View {
  
  @Binding var formTags: [String]
  
  var body: some View {
    
    // refactor?
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
      ForEach(3..<7) { col in
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
      ForEach(7..<10) { col in
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
        print("---------------appending--------")
      }
      else {
        formTags.removeAll(where: { $0 == tag })
      }
    } ) {
      Text(self.tag)
        .font(.footnote)
        .padding(.init(top: 2, leading: 6, bottom: 3, trailing: 6))
        .foregroundColor(darkBlue)
        .background(Capsule().fill(self.isSelected ? mint : lightGray))
    }
    // https://www.hackingwithswift.com/forums/swiftui/tap-button-in-hstack-activates-all-button-actions-ios-14-swiftui-2/2952
    // why does work though??
      .buttonStyle(BorderlessButtonStyle())
  }
}

