
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
  
  //from BookManager_Firebase: LibraryViewModel
  func add(_ errand: Errand) {
    errandRepository.create(errand)
  }
  
  func editUser(owner: ErrandOwner, runner: ErrandRunner) {
    errandRepository.updateUser(owner: owner, runner: runner)
  }
 
  func destroy(_ errand: Errand) {
    errandRepository.delete(errand)
  }

  func getPickedUpErrandsByStatus(user: User, statuses: [String]) -> [Errand] {
    var pickedUpErrands: [Errand] = []
    errandViewModels.forEach { errandVM in
      if (statuses.contains(errandVM.errand.status) && errandVM.errand.runner != nil && errandVM.errand.runner!.id == user.id) {
          pickedUpErrands.append(errandVM.errand)
        }
    }
      return pickedUpErrands
    }
  
    func getPostedErrandsByStatus(user: User, statuses: [String]) -> [Errand] {
      var postedErrands: [Errand] = []
      errandViewModels.forEach { errandVM in
        guard statuses.contains(errandVM.errand.status) && errandVM.errand.owner.id == user.id else {
            return // Skip if either status or ownerId is nil
        }

        if (statuses.contains(errandVM.errand.status) && errandVM.errand.owner.id == user.id) {
          postedErrands.append(errandVM.errand)
        }
      }
      return postedErrands
    }

}
