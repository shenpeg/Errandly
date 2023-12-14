import SwiftUI

struct LocationPermissionIconView: View {
  @EnvironmentObject var locViewModel: LocationViewModel

  var body: some View {
    Button {
      switch locViewModel.authorizationStatus {
      case .notDetermined:
        locViewModel.requestLocationPermission()
      default:
        // note: in XCode 15 on an iPhone 15 Pro (simulator), opening settings with cause it to crash
        // Create the URL that deep links to your app's custom settings.
        if let url = URL(string: UIApplication.openSettingsURLString) {
          // Ask the system to open that URL.
          UIApplication.shared.open(url)
        }
      }
    } label: {
      if (locViewModel.authorized()) {
        Image(systemName: "mappin.circle.fill")
          .foregroundColor(darkBlue)
          .font(.system(size: 16))
      }
      else {
        Image(systemName: "mappin.circle")
          .foregroundColor(darkBlue)
          .font(.system(size: 16))
      }
    }
    .accessibilityIdentifier("location button")
  }
}
