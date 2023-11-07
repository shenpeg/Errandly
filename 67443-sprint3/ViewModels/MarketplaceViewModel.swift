
import Foundation
import Combine

// from Swift Repos Lab
class MarketplaceViewModel: ObservableObject {
  @Published var errandViewModels: [ErrandViewModel] = []
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var errandRepository = ErrandRepository()
//  @Published var errands: [Errand] = []
//  @Published var filteredErrands: [Errand] = []

  @Published var searchText: String = ""
  @Published var filteredErrands: [ErrandViewModel] = []
  
  init() {
    errandRepository.$errands.map { errands in
      return errands.map(ErrandViewModel.init)
    }
    .assign(to: \.errandViewModels, on: self)
    .store(in: &cancellables)
  }
  
  func search(searchText: String) {
    self.filteredErrands = self.errandViewModels.filter { errandVM in
      return errandVM.errand.name.lowercased().contains(searchText.lowercased())
    }
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

}
