import Foundation

class PayViewModel: ObservableObject {
  private var errand: Errand
  private let paymentHandler = PaymentHandler()
  private let paymentTransferHandler = PaymentTransferHandler()
  @Published private(set) var paymentSucess = false
  @Published private(set) var paymentTransferSucess = false
  
  init(errand: Errand, paymentSucess: Bool = false) {
    self.errand = errand
    self.paymentSucess = paymentSucess
  }
  
  func pay() {
    paymentHandler.startPayment(errand: errand) { success in
      self.paymentSucess = success
    }
  }
  
  func payTransfer() {
    paymentTransferHandler.startTransfer(errand: errand) { success in
      self.paymentTransferSucess = success
    }
  }
  
}
