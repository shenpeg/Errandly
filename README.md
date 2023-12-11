# Errandly: College Errand Marketplace App
Errandly simplifies the lives of busy college students by providing a marketplace for students to post and fulfill errands. Whether you need someone to help you move into your dorm, petsit your cat over winter break, or help with any other task, Errandly connects you with trusted peers who are ready to assist.

## Sprint 6 Notes
Because using Apple pay requires a developer account (which not all members of the team have access to), payment functionality cannot be merged into main and is therefore on a seperate branch called 'pay'. Do note that the 'pay' branch contains everything that is in 'main' along with the payment flow. More specifically, payment flow includes the "External payment system" and "Fully functional 'mark as completed' flow" features in the sprint 6 plan. The payment flow is as follows:

1. A user chooses to pick up (and be a runner for) errand A. Let's assume errand A is a paid errand.
2. Once the errand runner has successfully completed the task, the errand owner can click the Apple pay button to pay the errand runner.
3. The errand runner can then click on the Apple pay button to accept the payment and transfer the money to their account. Once they accept the payment, the errand is automatically marked as completed. This flow ensures that both users, the owner and the runner, are involved in the process of completing an errand.
4. Let's assume a different errand, errand B, is not a paid errand. In that case, only the errand owner has to click on the button to mark the errand as completed. This is because the errand runner's approval is not needed if there are no payments involved.

Also note that when running the app on an actual phone, the only way to simulate the payment flow with fake credit cards is if the phone is logged into a Sandbox iCloud account. However, transfering money to the errand runner is not possible with a Sandbox account (as money transfers don't work with fake credit cards).

### Testing
We focused mainly on testing our views and user interactive flows throughout the app. We struggled with testing the login functionality because we could not figure out how to create and authenticate Google OAuth login mock data. However, once you log in, most of the tests will work. Another issue we ran into was figuring out how to test and imitate navigating throughout the app. 

Additionally, for testing our view models (see testing_firestore for more details of our work), we tried setting up a Firestore emulator to ensure that our primary database would not be affected by the tests (https://cloud.google.com/firestore/docs/emulator#swift). While the emulator did seem to work, there was no way we could find to clear the data in the emulator between tests (to ensure tests were seperate from one another). While we attempted to loop through all of the documents and delete them manually (which is not advised by Firestore (https://firebase.google.com/docs/firestore/manage-data/delete-data)), since document.reference.delete() is not an async function, the deletions would not complete before the rest of the tests started running, breaking those tests. Furthermore, besides errandsViewModel.create(), which was forced to be async to get a part of our app to work, the rest of the functions are not async. This again causes problems with testing because the tests only work if we can await for the firestore/errandsViewModel functions to finish running.

## Features
1. Errand Management: Post your errands and receive help from reliable errand runners within your college community.
2. Errand Finder: Easily sort errands by distance and time, and filter errands with thematic tags. 
4. Communicate in Real-Time: Message errand helpers or errand posters through their profile.
5. Secure Transactions: Get paid for helpinig out fellow students, and securely handle payments with Apple Pay in the app.
6. And more! (descriptions TBD)

## Design and Programming Decisions
TBD.

## Contributions
Designed and coded by Esther Bae, Clarice Du, Julia Graham, Peggy Shen.
Made for CMU's 67-443 Mobile Application Development.
