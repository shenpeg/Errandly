import Foundation
import FirebaseFirestore

struct Location: Identifiable {
  let id = UUID()
  let title: String
  let subtitle: String
}
