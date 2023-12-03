import Foundation

class PayViewModel: ObservableObject {
  private var errandsViewModel: ErrandsViewModel
  private var errand: Errand
  private let paymentHandler = PaymentHandler()
  private let paymentTransferHandler = PaymentTransferHandler()
  @Published private(set) var paymentSucess = false
  @Published private(set) var paymentTransferSucess = false
    
  init(errandsViewModel: ErrandsViewModel, errand: Errand, paymentSucess: Bool = false) {
    self.errandsViewModel = errandsViewModel
    self.errand = errand
    self.paymentSucess = paymentSucess
  }
  
  func pay() {
    paymentHandler.startPayment(errand: errand) { success in
      self.paymentSucess = success
      if success {
        self.errandsViewModel.updateErrandStatus(errandID: self.errand.id!, newStatus: "in progress - owner paid")
      }
    }
  }
  
  func payTransfer() {
    paymentTransferHandler.startTransfer(errand: errand) { success in
      self.paymentTransferSucess = success
      if success {
        self.errandsViewModel.updateErrandStatus(errandID: self.errand.id!, newStatus: "in progress - runner got paid")
      }
    }
  }
  
}
