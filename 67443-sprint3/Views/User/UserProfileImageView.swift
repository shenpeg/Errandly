import SwiftUI

struct UserProfileImageView: View {
  var pfp: String
  var size: CGFloat

  var body: some View {
    AsyncImage(url: URL(string: pfp)) { phase in
      switch phase {
      case .success(let image):
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size, height: size, alignment: .center)
          .scaledToFit()
          .clipShape(Circle())
      default:
        Image(systemName: "person.circle")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size, height: size, alignment: .center)
          .scaledToFit()
          .clipShape(Circle())
      }
    }
  }
}
