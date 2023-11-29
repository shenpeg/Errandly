//
//  MessagesServices.swift
//  67443-sprint3
//
//  Created by Ohnyoo Esther Bae on 11/27/23.
//

import Foundation
import SwiftUI

class MessagesService {
  func sendMessage(_ phoneNumber: String) {
    let sms: String = "sms:+1\(phoneNumber)&body=Example message body"
    let strURL:String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
  }
}
