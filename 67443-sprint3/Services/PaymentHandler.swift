// tutorial: https://www.youtube.com/watch?v=1kRqM7F3AIQ

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
  var paymentController: PKPaymentAuthorizationController?
  var paymentSummaryItem: PKPaymentSummaryItem? = nil
  var paymentStatus: PKPaymentAuthorizationStatus = PKPaymentAuthorizationStatus.failure
  var completionHandler: PaymentCompletionHandler?
  
  static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .discover,
    .masterCard,
    .visa
  ]
  
  func startPayment(errand: Errand, completion: @escaping PaymentCompletionHandler) {
    completionHandler = completion
    paymentSummaryItem = PKPaymentSummaryItem(
      label: "\(errand.runner!.first_name) \(errand.runner!.last_name)",
      amount: NSDecimalNumber(value: errand.pay),
      type: .final
    )
    
    let paymentRequest = PKPaymentRequest()
    paymentRequest.paymentSummaryItems = [paymentSummaryItem!]
    paymentRequest.merchantIdentifier = "merchant.cmu.errandly"
    paymentRequest.merchantCapabilities = .capability3DS
    paymentRequest.countryCode = "US"
    paymentRequest.currencyCode = "USD"
    paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
    
    paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
    paymentController?.delegate = self
    paymentController?.present(completion: { (presented: Bool) in
        if presented {
            debugPrint("Presented payment controller")
        } else {
            debugPrint("Failed to present payment controller")
        }
    })
  }
  
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
  func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) 
  {
    let errors = [Error]()
    let status: PKPaymentAuthorizationStatus = PKPaymentAuthorizationStatus.success
    self.paymentStatus = status
    completion(PKPaymentAuthorizationResult(status: status, errors: errors))
  }
  
  func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
      DispatchQueue.main.async {
        if self.paymentStatus == .success {
          if let completionHandler = self.completionHandler {
            completionHandler(true)
          }
        }
        else {
          if let completionHandler = self.completionHandler {
            completionHandler(false)
          }
        }
      }
    }
  }
  
}
