import SwiftUI

struct ErrandDetailsProfileView: View {
  @ObservedObject var usersViewModel: UsersViewModel = UsersViewModel()
  var errand: Errand

  var body: some View {
    let errandOwnerUser = usersViewModel.getUser(errand.owner.id)

    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    let timeDifference = calculateTimeDifference(from: errand.datePosted)

    return VStack(alignment: .leading) {
      Spacer()
      HStack {
        UserProfileImageView(pfp: errand.owner.pfp, size: 20)
  
        if (errandOwnerUser != nil) {
          NavigationLink(destination:
            UserProfileView(user: errandOwnerUser, isCurUser: false)
          ) {
            Text("\(errand.owner.first_name) \(errand.owner.last_name)")
              .font(.headline)
          }
          .accentColor(.black)
        }
        else {
          Text("\(errand.owner.first_name) \(errand.owner.last_name)")
          .font(.headline)
          .foregroundColor(.primary)
        }
      }

      HStack {
        // edit to calculate how far errand's location is from currUser location
        Text("\(errand.location.latitude), \(errand.location.longitude)")
        .font(.body)
        .foregroundColor(.secondary)
        Text(" | ").font(.body).foregroundColor(.secondary)
        Text(formatTimeDifference(timeDifference)).font(.body)
        .foregroundColor(.secondary)
    }
      
  }
}

  func calculateTimeDifference(from date: Date) -> TimeInterval {
    let currentTime = Date()
    return currentTime.timeIntervalSince(date)
  }

  func formatTimeDifference(_ timeDifference: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
    formatter.maximumUnitCount = 1
    formatter.unitsStyle = .abbreviated

    if let formattedString = formatter.string(from: timeDifference) {
      return formattedString + " ago"
    } else {
      return "Unknown"
    }
  }
  
}
