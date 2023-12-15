# Errandly: College Errand Marketplace App
Errandly simplifies the lives of busy college students by providing a marketplace for students to post and fulfill errands. Whether you need someone to help you move into your dorm, petsit your cat over winter break, or help with any other task, Errandly connects you with trusted peers who are ready to assist.

### Features
1. Errand Management: Post your errands and receive help from reliable errand runners within your college community.
2. Errand Location: Allow the app to get your current location so that you can see which errands are close by.
3. Errand Finder: Easily sort errands by due date and compensation, and filter errands with thematic tags.
4. Profile History: View your history of posted and picked up errands and see what other users have accomplished.  
5. Real-Time Communication: Message errand helpers or errand posters through their profile.
6. Secure Transactions: Get paid for helpinig out fellow students, and securely handle payments with Apple Pay in the app.

## Notes on Design and Programming

### Fonts
For some reason, XCode sometimes will not download the font files correctly when the repo is cloned. If that is the case (the font files will be highlighted red), then manually Quicksand-Bold.ttf and Quicksand-VariableFont_wght.ttf, download Quicksand-Bold.ttf and Quicksand-VariableFont_wght.ttf from GitHub, and drag those files into the project.

### Location
Since location does require Settings, **do not use an iPhone 15 Pro simulator**, as it is a known issue that opening Settings will cause it to crash. See ["The simulator may crash when opening Settings or Action Button settings on iPhone 15 Pro devices. (115388496)"](https://developer.apple.com/documentation/xcode-release-notes/xcode-15-release-notes#Known-Issues). To setup location on the simulator, first build the app. Then, once the simulator is running, click on XCode and then go to Debug > Simulate Location > [pick a location]. Then, go back to the simulator and click on the 'pin' icon within the app (upper left hand corner of the Marketplace). When doing so the first time, you will be prompted to allow the app to use your location. Clicking the icon again will redirect to the app's Settings page, where location preferences can be changed. This permissions flow (aka redirecting to Settings) is required by Apple.

### Pay
Because using Apple pay requires a developer account (which not all members of the team have access to), payment functionality cannot be merged into main and is therefore on a seperate branch called 'pay'. Additionally, PKDisbursementRequest(), which is required for enabling the transfer of money from the app to the errand runner is only available in iOS 17. Do note that the 'pay' branch contains everything that is in 'main' along with the payment flow. More specifically, payment flow includes the "External payment system" and "Fully functional 'mark as completed' flow" features in the sprint 6 plan. The payment flow is as follows:

1. A user chooses to pick up (and be a runner for) errand A. Let's assume errand A is a paid errand.
2. Once the errand runner has successfully completed the task, the errand owner can click the Apple pay button to pay the errand runner. Do note that Apple restricts most customization to the design of the Apple pay button.
3. The errand runner can then click on the Apple pay button to accept the payment and transfer the money to their account. Once they accept the payment, the errand is automatically marked as completed. This flow ensures that both users, the owner and the runner, are involved in the process of completing an errand. Although the primary reason the errand owner does not pay the runner directly is because Apple Pay does not allow for Peer-to-peer payments (P2P), this limitation does ensure that the errand runner has to "confirm" that they recieved the payment.
4. Let's assume a different errand, errand B, is not a paid errand. In that case, only the errand owner has to click on the button to mark the errand as completed. This is because the errand runner's approval is not needed if there are no payments involved.

Also note that when running the app on an actual phone, the only way to simulate the payment flow with fake credit cards is if the phone is logged into a Sandbox iCloud account. However, transfering money to the errand runner is not possible with a Sandbox account (as money transfers don't work with fake credit cards).

### Testing
We focused mainly on testing our views and user interactive flows throughout the app. In general, we struggled testing features that were based on the external technologies used. We struggled with testing the login functionality because we could not figure out how to create and authenticate Google OAuth login mock data. This also meant that we could only test with one logged in user, so we could not test anything related to picking up/completing an errand. We could also not figure out how to best test enabling/updating location preferences. Finally, we could not figure out the best way to test payment, especially since StoreKit Testing (one way to test payments) assumes that the items/subscriptions that can be purchased have a set price, which is not the case for our app (users can create many different errands with any price). These issues are the primary reason for the lines of the code that are not covered by our tests.

Once you log in, all of the tests that were written should work. **Therefore, the tests should only be run AFTER building the app and logging in.** Do note that these UI tests are quite flacky and may fail unexpectedly. This seems to happen either because the app loaded too slowly or because the form .textType() function typed too fast and the text was not inputted correctly. For most tests, the test can simply be rerun and many tests will pass the second time. However, testPostEditDelete() and testProfileEdit() make changes to the database. More specifically, testPostEditDelete() tries to post a new errand called "ABC", then rename that errand to "A", then delete that errand. testProfileEdit() tries to add an "!" to the user's first name and then delete the "!". If either of these tests fail halfway (which can happen due to the flackiness of .textType()), it is possible that the test could not reset properly. If that happens, simply manually delete the posted errand named "ABC" or "A" or remove the "!" from the user's first name.

Additionally, do note that if all of the tests succeed, it is likely that the simulator will end up in dark mode (which does not work with our app). To go back to light mode, in the simulator, go to the Settings app > Developer > uncheck 'dark appearance'.

For more background regarding what we tried to test, for testing our view models (see testing_firestore for more details of our work), we tried setting up a -[Firestore emulator](https://cloud.google.com/firestore/docs/emulator#swift) to ensure that our primary database would not be affected by the tests. While the emulator did seem to work, there was no way we could find to clear the data in the emulator between tests (to ensure tests were seperate from one another). While we attempted to loop through all of the documents and delete them manually (which is [not advised by Firestore](https://firebase.google.com/docs/firestore/manage-data/delete-data)), since document.reference.delete() is not an async function, the deletions would not complete before the rest of the tests started running, breaking those tests. Furthermore, besides errandsViewModel.create(), which was forced to be async to get a part of our app to work, the rest of the functions are not async. This again causes problems with testing because the tests only work if we can await for the firestore/view model functions to finish running. Because of these issues, we only did UI tests.

## Contributions
Designed and coded by Esther Bae, Clarice Du, Julia Graham, Peggy Shen.
Made for CMU's 67-443 Mobile Application Development.
