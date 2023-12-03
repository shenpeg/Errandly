import Foundation

class PayViewModel: ObservableObject {
  private var errand: Errand
  private let paymentHandler = PaymentHandler()
  @Published private(set) var paymentSucess = false
  
  init(errand: Errand, paymentSucess: Bool = false) {
    self.errand = errand
    self.paymentSucess = paymentSucess
  }
  
  func pay() {
    paymentHandler.startPayment(errand: errand) { success in
      self.paymentSucess = success
    }
  }
}
