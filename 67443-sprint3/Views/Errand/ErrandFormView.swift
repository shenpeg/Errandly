import Combine
import Foundation
import FirebaseFirestore
import SwiftUI

struct ErrandFormView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var selectedTags: [String]
    @Binding var dateDue: Date
    @Binding var location: GeoPoint
    @Binding var pay: Double
    @Binding var payBool: Bool
    @Binding var payString: String

    var body: some View {
        Section {
          if title == "" {
            TextField("Errand Title", text: $title)
              .font(.system(size: 38))
              .underline(true)
              .foregroundColor(darkBlue)
              .listRowSeparator(.hidden)
          }
          else {
            TextField(title, text: $title)
              .font(.system(size: 38))
              .underline(true)
              .foregroundColor(darkBlue)
              .listRowSeparator(.hidden)
          }
          
          if description == "" {
            TextField("What do you need help with?", text: $description, axis: .vertical)
                .lineLimit(10, reservesSpace: true)
                .background(Color.white)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
                .listRowSeparator(.hidden)
          }
          else {
            TextField(description, text: $description, axis: .vertical)
              .lineLimit(10, reservesSpace: true)
              .background(Color.white)
              .padding(5)
              .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
              .listRowSeparator(.hidden)
          }
            
            DatePicker("Date needed by:", selection: $dateDue, displayedComponents: .date)

            VStack(alignment: .leading, spacing: 0) {
                Text("Tags (select up to three):")
                    .padding(.bottom, 10)
                FormTags(formTags: $selectedTags)
            }
            .listRowSeparator(.hidden)

            VStack(alignment: .leading) {
              Text("Location:")
              LocationSearchView(geoPoint: $location, locationString: "")
            }
            .listRowSeparator(.hidden)

            VStack(alignment: .leading) {
                Text("Compensation?")
              
                HStack {
                    Button(action: { payBool = true }) { //payString = "1";
                        Text(" ")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 20, height: 20)
                    .background(payBool ? darkBlue : Color.white)
                    .cornerRadius(100)
                    .foregroundColor(Color.black)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(darkBlue, lineWidth: 2)
                        .scaleEffect(0.5))
                    Text("Yes     ")

                    if payBool {
                      if payString == "" {
                        TextField("How much?", text: $payString)
                          .padding(5)
                          .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
                          .keyboardType(.decimalPad)
                      }
                      else {
                        TextField(payString, text: $payString)
                          .padding(5)
                          .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
                          .keyboardType(.decimalPad)
                      }
                    }
                }

                HStack {
                    Button(action: { payBool = false }) {
                        Text(" ")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 20, height: 20)
                    .background(payBool ? Color.white : darkBlue)
                    .cornerRadius(100)
                    .foregroundColor(darkBlue)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(darkBlue, lineWidth: 2)
                        .scaleEffect(0.5))
                    Text("No      ")
                }
            }
            .listRowSeparator(.hidden)
        }
    }
}
