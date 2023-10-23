//
//  MessagesService.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/23/23.
//
// tutorial: https://www.youtube.com/watch?v=M-9UFn0sCCQ
// note: can't use simulator to send a message, must connect your actual device
// more info: https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device#
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
