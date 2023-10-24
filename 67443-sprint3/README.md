#  Team 4 Sprint 3

This GitHub repo has 2 branches: **main** and **extra**

## main

This branch contains all relevant structs, shows ability to push/pull data to/from Firebase, and demonstrates log in functionality with Google OAuth.


## extra

This branch demonstrates extra functionality that our team will need for our project. Location functionality utilizes Apple's [CoreLocation Framework](https://developer.apple.com/documentation/corelocation). This includes:
- Redirecting to iMessages with a custom message that can be sent to a given phone number
  - Note that sending messages does NOT work on the simulator  
- Getting the user's current location
- Redirecting the user to the app's settings in Settings to change location preferences
  - Note that in XCode 15 on an iPhone 15 Pro (simulator), opening settings with cause it to crash
- Calculating distances between 2 locations
- Searching locations with autocomplete and natural input (ex: can search 'Carnegie Mellon University' or an address)
