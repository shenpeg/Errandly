#  Team 4 Sprint 3

This GitHub repo has 2 branches: **sprint3** and **extra**

## sprint3

This branch contains all relevant structs, shows ability to pull data from Firestore, and demonstrates log in functionality with Google OAuth.

### Structs:
- Errand
  - ErrandOwner
- User
  - PickedUpErrand
    - PickedUpErrandOwner
  - PostedErrand
    - PostedErrandOwner

### Pulling data from Firestore:
- The ErrandRepository contain the logic for pulling errands from Firestore and storing them an an array as [Errand]. UserRepository does the same for users.
- ErrandDetailsView and UserView display the data that was pulled from Firestore.

### Google Oauth:
- Google Oauth is used for authentication. We primarily utilized the [offical example code](https://github.com/google/GoogleSignIn-iOS/tree/main/Samples/Swift/DaysUntilBirthday#google-sign-in-swift-sample-app) to implement authentication. The following files contain at least some logic necessary for Google Oauth:
  - _7443_sprint3App 
  - ContentView
  - SignInView
  - UserProfileImageView
  - UserProfileView
  - AuthenticationViewModel



## extra

This branch demonstrates extra functionality that our team will need for our project. Location functionality utilizes Apple's [CoreLocation Framework](https://developer.apple.com/documentation/corelocation). This includes:
- Redirecting to iMessages with a custom message that can be sent to a given phone number
  - Note that sending messages does NOT work on the simulator  
- Getting the user's current location
- Redirecting the user to the app's settings in Settings to change location preferences
  - Note that in XCode 15 on an iPhone 15 Pro (simulator), opening settings with cause it to crash
- Calculating distances between 2 locations
- Searching locations with autocomplete and natural input (ex: can search 'Carnegie Mellon University' or an address)
