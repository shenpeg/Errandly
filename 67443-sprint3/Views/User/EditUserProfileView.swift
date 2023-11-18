import SwiftUI

struct EditUserProfileView: View {
  var user: User

  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @ObservedObject var usersViewModel = UsersViewModel()
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  @State var showUserProfile: Bool = false

  @State private var firstName = ""
  @State private var lastName = ""
  @State private var bio = ""
  @State private var schoolYear = ""
  @State private var phoneNumber = ""
  @State private var canHelpWith: [String] = []
    
  init(user: User) {
    self.user = user
    self.showUserProfile = false
    self._firstName = State(wrappedValue: user.first_name)
    self._lastName = State(wrappedValue: user.last_name)
    self._bio = State(wrappedValue: user.bio)
    self._schoolYear = State(wrappedValue: user.school_year)
    self._phoneNumber = State(wrappedValue: self.formatPhoneNumber(phone: user.phone_number))
    self._canHelpWith = State(wrappedValue: user.can_help_with)
  }

  var body: some View {
    
    switch showUserProfile {
    case true:
      UserProfileView(user: user, isCurUser: true)
        .environmentObject(authViewModel)
        .navigationBarBackButtonHidden(true)
      
    case false:
      ZStack (alignment: .topLeading) {
        darkBlue
          .ignoresSafeArea()
        
        VStack (spacing: 0) {
          Text("Edit Profile")
            .font(.title)
            .foregroundColor(.white)
            .padding(.bottom, 5)
          
          Form {
            FormTextSection(text: "First name", input: $firstName)
            FormTextSection(text: "Last name", input: $lastName)
            FormTextSection(text: "Bio", input: $bio)
            FormTextSection(text: "School year", input: $schoolYear)
            
            // phone number
            VStack (alignment: .leading, spacing: 0) {
              Text("Phone number:")
                .padding(.bottom, 5)
              TextField("###-###-####", text: $phoneNumber)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(darkBlue, lineWidth: 1))
            }
            .listRowSeparator(.hidden)
            
            // can help with tags
            VStack (alignment: .leading, spacing: 0) {
              Text("Can help with (select up to 3):")
                .padding(.bottom, 5)
              FormTags(formTags: $canHelpWith)
            }
            .listRowSeparator(.hidden)
            
            if self.isValidUser() {
              HStack {
                Spacer()
                Button("Save") {
                  editUser()
                  clearFields()
                  showUserProfile = true
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 20).fill(darkBlue))
                Spacer()
              }
            }
          }
          .background(.white)
          .scrollContentBackground(.hidden)
        }
      }
    }
  }

  private func isValidUser() -> Bool {
    // only name is required
    if firstName.isEmpty { return false }
    if lastName.isEmpty { return false }
    
    // only 3 can help with tags
    if canHelpWith.count > 3 { return false }
    
    // phone number validation if inputted
    let phonePattern = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
    let phoneResult = phoneNumber.range(
        of: phonePattern,
        options: .regularExpression
    )
    if (String(phoneNumber) != "") {
      if (phoneResult == nil) { return false }
    }
    
    return true
  }
  
  private func editUser() {
    let intPhoneNumber = Int(phoneNumber.filter("0123456789".contains)) ?? 0
    
    if (!marketplaceViewModel.errandViewModels.isEmpty && !usersViewModel.userViewModels.isEmpty) {
      let updatedUser = User(uid: user.uid, bio: bio, can_help_with: canHelpWith, first_name: firstName, last_name: lastName, pfp: user.pfp, phone_number: intPhoneNumber, picked_up_errands: user.picked_up_errands, posted_errands: user.posted_errands, school_year: schoolYear)
      usersViewModel.editUser(user: user, updatedUser: updatedUser)
      
      if (user.first_name != firstName || user.last_name != lastName || user.phone_number != intPhoneNumber) {
        let updatedErrandOwner = ErrandOwner(id: user.id!, first_name: firstName, last_name: lastName, pfp: user.pfp, phone_number: intPhoneNumber)
        let updatedErrandRunner = ErrandRunner(id: user.id!, first_name: firstName, last_name: lastName)
        marketplaceViewModel.editUser(owner: updatedErrandOwner, runner: updatedErrandRunner)
      }
    }
  }

  private func clearFields() {
    firstName = ""
    lastName = ""
    bio = ""
    schoolYear = ""
    phoneNumber = ""
    canHelpWith = []
  }
  
  private func formatPhoneNumber(phone: Int) -> String {
    if (phone == 0) {
      return ""
    }
    let numbers = String(phone).replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    let mask = "XXX-XXX-XXXX"
    var index = numbers.startIndex

    for ch in mask where index < numbers.endIndex {
      if ch == "X" {
        result.append(numbers[index])
        index = numbers.index(after: index)
      } 
      else {
        result.append(ch)
      }
    }
    return result
  }
  
}

struct FormTextSection: View {
  var text: String
  var input: Binding<String>
  
  var body: some View {
    VStack (alignment: .leading, spacing: 0) {
      Text("\(text):")
        .padding(.bottom, 5)
      TextField(text, text: input)
        .padding(5)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(darkBlue, lineWidth: 1))
    }
    .listRowSeparator(.hidden)
  }
}
