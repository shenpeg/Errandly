import Foundation
import Combine

class ErrandViewModel: ObservableObject, Identifiable {

  private let errandRepository = ErrandRepository()
  @Published var errand: Errand
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(errand: Errand) {
    self.errand = errand
    $errand
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }
  
}
