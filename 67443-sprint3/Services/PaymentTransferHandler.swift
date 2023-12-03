// tutorial: https://developer.apple.com/videos/play/wwdc2023/10114/?time=681

import Foundation
import PassKit

class PaymentTransferHandler: NSObject {
  var disbursementController: PKPaymentAuthorizationController?
  var disbursementStatus: PKPaymentAuthorizationStatus = PKPaymentAuthorizationStatus.failure
  var disbursementCompletionHandler: PaymentCompletionHandler?
  
  static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .discover,
    .masterCard,
    .visa
  ]
  
  func startTransfer(errand: Errand, completion: @escaping PaymentCompletionHandler) {
    disbursementCompletionHandler = completion
    
    let fundsWithdrawn = PKPaymentSummaryItem(
      label: "Errandly",
      amount: NSDecimalNumber(value: errand.pay)
    )
    let fundsSent = PKDisbursementSummaryItem(
      label: "\(errand.owner.first_name) \(errand.owner.last_name)",
      amount: NSDecimalNumber(value: errand.pay)
    )
    
    let disbursementRequest = PKDisbursementRequest()
    disbursementRequest.summaryItems = [fundsWithdrawn, fundsSent]
    disbursementRequest.merchantIdentifier = "merchant.cmu.errandly"
    disbursementRequest.merchantCapabilities = [.debit, .credit]
    disbursementRequest.currency = Locale.Currency("USD")
    disbursementRequest.region = .unitedStates
    disbursementRequest.supportedNetworks = PaymentTransferHandler.supportedNetworks
    
    disbursementController = PKPaymentAuthorizationController(disbursementRequest: disbursementRequest)
    disbursementController?.delegate = self
    disbursementController?.present(completion: { (presented: Bool) in
      if !presented {
        debugPrint("Failed to present payment disbursement controller")
      }
    })
  }
  
}

extension PaymentTransferHandler: PKPaymentAuthorizationControllerDelegate {
  func paymentAuthorizationController(
    _ controller: PKPaymentAuthorizationController,
    didAuthorizePayment payment: PKPayment,
    handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
  )
  {
    let errors = [Error]()
    let status: PKPaymentAuthorizationStatus = PKPaymentAuthorizationStatus.success
    self.disbursementStatus = status
    completion(PKPaymentAuthorizationResult(status: status, errors: errors))
  }
  
  func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
      DispatchQueue.main.async {
        if self.disbursementStatus == .success {
          if let completionHandler = self.disbursementCompletionHandler {
            completionHandler(true)
          }
        }
        else {
          if let completionHandler = self.disbursementCompletionHandler {
            completionHandler(false)
          }
        }
      }
    }
  }
  
}
