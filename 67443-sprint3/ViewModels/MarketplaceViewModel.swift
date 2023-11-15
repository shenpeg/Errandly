
import Foundation
import Combine

class MarketplaceViewModel: ObservableObject {
  @Published var errandViewModels: [ErrandViewModel] = []
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var errandRepository = ErrandRepository()  
  @Published var errands: [ErrandViewModel] = []

  
  init() {
    errandRepository.$errands.map { errands in
      return errands.map(ErrandViewModel.init)
    }
    .assign(to: \.errandViewModels, on: self)
    .store(in: &cancellables)
  }
  
  
  func getErrand(_ id: String) -> Errand {
    if let errandVM = errandViewModels.first(where: {$0.id == id}) {
      return errandVM.errand
    }
    else {
      fatalError("Unable to find the corresponding errand.")
    }
  }

  func getErrandsByStatus(_ ids: [String]) -> [String: [Errand]] {
    var errands: [String: [Errand]] = ["new": [], "in progress": [], "completed": []]
    ids.forEach {id in
      if let errandVM = errandViewModels.first(where: {$0.id == id}) {
        errands[errandVM.errand.status]!.append(errandVM.errand)
      }
    }
    return errands
  }
  
  func add(_ errand: Errand) async -> Errand {
    return await errandRepository.create(errand)
  }
  
  func editUser(user: User, userId: String, postedErrandsIds: [String], pickedUpErrandsIds: [String]) {
    errandRepository.updateUser(user: user, userId: userId, postedErrandsIds: postedErrandsIds, pickedUpErrandsIds: pickedUpErrandsIds)
  }
  
  func destroy(_ errand: Errand) {
    errandRepository.delete(errand)
  }

}
