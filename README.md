# Errandly: College Errand Marketplace App
Errandly simplifies the lives of busy college students by providing a marketplace for students to post and fulfill errands. Whether you need someone to help you move into your dorm, petsit your cat over winter break, or help with any other task, Errandly connects you with trusted peers who are ready to assist.

## Sprint 6 Notes
Because using Apple pay requires a developer account (which not all members of the team have access to), payment functionality cannot be merged into main and is therefore on a seperate branch called 'pay'. Do note that the 'pay' branch contains everything that is in 'main' along with the payment flow. More specifically, payment flow includes the "External payment system" and "Fully functional 'mark as completed' flow" features in the sprint 6 plan. The payment flow is as follows:

1. A user chooses to pick up (and be a runner for) errand A. Let's assume errand A is a paid errand.
3. Once the errand runner has successfully completed the task, the errand owner can click the Apple pay button to pay the errand runner.
4. The errand runner can then click on the Apple pay button to accept the payment and transfer the money to their account. Once they accept the payment, the errand is automatically marked as completed. This flow ensures that both users, the owner and the runner, are involved in the process of completing an errand.
5. Let's assume a different errand, errand B, is not a paid errand. In that case, only the errand owner has to click on the button to mark the errand as completed. This is because the errand runner's approval is not needed if there are no payments involved.

Also note that when running the app on an actual phone, the only way to simulate the payment flow with fake credit cards is if the phone is logged into a Sandbox iCloud account. However, transfering money to the errand runner is not possible with a Sandbox account (as money transfers don't work with fake credit cards).

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

## Notes
View the README in the 67443-sprint3 folder for more information on this repository's branches. 
