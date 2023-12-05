//
//  FormFunctions.swift
//  67443-sprint3
//
//  Created by cd on 12/4/23.
//

import SwiftUI

struct FormFunctions {
  @Binding var title: String
  @Binding var description: String
  @Binding var dateDue: Date
  @Binding var pay: Double
  @Binding var payBool: Bool
  @Binding var payString: String
  @Binding var selectedTags: [String]
  @Binding var errorMsg: String

  func clearFields(){
    title = ""
    description = ""
    dateDue = Date()
    //location = GeoPoint() stays in pgh for now
    payBool = true
    payString = ""
    pay = 0.0
    selectedTags = []
    
  }

  func payStringToPay() {
    if let payNum = Double(payString) {
      pay = payNum
    }
  }
  
  func isValidErrand() -> Bool {
        if title.isEmpty {
            errorMsg = "Please enter a title for your errand!"
            return false
        }
        if description.isEmpty {
            errorMsg = "Please write some details on what you need help with"
            return false
        }
        if (payBool == true && pay < 1.00) {
            errorMsg = "If you choose to offer compensation, please enter an amount over $1.00"
            return false
        }
    //checking date has not already passed, from: riptutorial.com/ios/example/4884/date-comparison
    
        let calendar = Calendar.current
        let today = Date()
        let result = calendar.compare(dateDue, to: today, toGranularity: .day)
        if result == .orderedAscending {
            errorMsg = "You can only enter a due date that's in the future!"
            return false
        }
        return true
    }
}
