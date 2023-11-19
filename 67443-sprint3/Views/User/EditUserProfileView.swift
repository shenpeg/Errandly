import SwiftUI

struct EditUserProfileView: View {
  var user: User

  @Environment(\.dismiss) var dismiss
  
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var marketplaceViewModel: MarketplaceViewModel

  @State private var firstName = ""
  @State private var lastName = ""
  @State private var bio = ""
  @State private var schoolYear = ""
  @State private var phoneNumber = ""
  @State private var canHelpWith: [String] = []
  
  @State private var canHelpWithTags: [String] = ["on-campus", "off-campus", "house/dorm", "food/drink", "cleaning", "animals", "plants", "car", "laundry", "moving in/out"]
  
  init(user: User) {
    self.user = user
    self._firstName = State(wrappedValue: user.first_name)
    self._lastName = State(wrappedValue: user.last_name)
    self._bio = State(wrappedValue: user.bio)
    self._schoolYear = State(wrappedValue: user.school_year)
    self._phoneNumber = State(wrappedValue: self.formatPhoneNumber(phone: user.phone_number))
    self._canHelpWith = State(wrappedValue: user.can_help_with)
  }

  var body: some View {
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
              .overlay(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
          }
          .listRowSeparator(.hidden)
          
          // can help with tags
          VStack (alignment: .leading, spacing: 0) {
            Text("Can help with (select up to 3):")
              .padding(.bottom, 5)
            ForEach(0..<4) { row in
              HStack {
                ForEach(0..<3) { column in
                  if ((row * 3 + column) < 10) {
                    let tag = canHelpWithTags[row * 3 + column]
                      MultiSelectTag(
                        tag: tag,
                        isSelected: self.canHelpWith.contains(tag)
                      )
                    {
                      if self.canHelpWith.contains(tag) {
                        self.canHelpWith.removeAll(where: { $0 == tag })
                      }
                      else {
                        self.canHelpWith.append(tag)
                      }
                    }
                  }
                }
              }
              .padding(.bottom, 10)
            }
          }
          .listRowSeparator(.hidden)
          
          if self.isValidUser() {
            HStack {
              Spacer()
              Button("Save") {
                editUser()
                clearFields()
                dismiss()
              }
              .foregroundColor(.white)
              .padding(.horizontal, 10)
              .padding(.vertical, 5)
              .background(RoundedRectangle(cornerRadius: 10).fill(darkBlue))
              Spacer()
            }
          }
        }
        .background(.white)
        .scrollContentBackground(.hidden)
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
    
    if (!marketplaceViewModel.errands.isEmpty && !usersViewModel.users.isEmpty) {
      let updatedUser = User(uid: user.uid, bio: bio, can_help_with: canHelpWith, first_name: firstName, last_name: lastName, pfp: user.pfp, phone_number: intPhoneNumber, picked_up_errands: user.picked_up_errands, posted_errands: user.posted_errands, school_year: schoolYear)
      usersViewModel.updateUser(user: user, updatedUser: updatedUser)
            
      if (user.first_name != firstName || user.last_name != lastName || user.phone_number != intPhoneNumber) {
        marketplaceViewModel.updateUser(user: updatedUser, userId: user.id!, postedErrandsIds: user.posted_errands, pickedUpErrandsIds: user.picked_up_errands)
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
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(darkBlue, lineWidth: 1))
    }
    .listRowSeparator(.hidden)
  }
}

struct MultiSelectTag: View {
    var tag: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
          if self.isSelected {
            Text(self.tag)
              .font(.caption)
              .padding(.horizontal, 15)
              .foregroundColor(darkGray)
              .background(Capsule().fill(mint))
          }
          else {
            Text(self.tag)
              .font(.caption)
              .padding(.horizontal, 15)
              .foregroundColor(darkBlue)
              .background(Capsule().fill(lightGray))
          }
        }
        // https://www.hackingwithswift.com/forums/swiftui/tap-button-in-hstack-activates-all-button-actions-ios-14-swiftui-2/2952
        // why does work though??
          .buttonStyle(BorderlessButtonStyle())
    }
}
