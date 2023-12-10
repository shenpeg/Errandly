// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
 //
 import SwiftUI
 import MapKit

 struct LocationSearchView: View {
   @EnvironmentObject var locationViewModel: LocationViewModel
   @FocusState private var isFocusedTextField: Bool

   var body: some View {
     NavigationView {
       VStack(alignment: .leading, spacing: 0) {

         TextField("Type address", text: $locationViewModel.searchableText)
           .padding()
           .autocorrectionDisabled()
           .focused($isFocusedTextField)
           .font(.title)
           .onReceive(
            locationViewModel.$searchableText.debounce(
               for: .seconds(1),
               scheduler: DispatchQueue.main
             )
           ) {
               locationViewModel.searchAddress($0)
           }
           .background(Color.init(uiColor: .systemBackground))
           .overlay {
             LocationSearchClearButton(text: $locationViewModel.searchableText)
               .padding(.trailing)
               .padding(.top, 8)
           }
           .onAppear {
             isFocusedTextField = true
           }

         List(self.locationViewModel.results) { address in
           VStack(alignment: .leading) {
             Text(address.title)
             Text(address.subtitle)
                 .font(.caption)
           }
           .listRowBackground(backgroundColor)
         }
         .listStyle(.plain)
         .scrollContentBackground(.hidden)
       }
       .background(backgroundColor)
       .edgesIgnoringSafeArea(.bottom)
     }
   }

   var backgroundColor: Color = Color.init(uiColor: .systemGray6)
 }
