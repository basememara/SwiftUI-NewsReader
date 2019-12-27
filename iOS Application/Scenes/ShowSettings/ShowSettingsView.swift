//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI

struct ShowSettingsView: View {
    @State private(set) var text: String
    @State private(set) var date: Date
    @State private(set) var quantity: Int
    @State private(set) var selection: String
    
    private let dateFormatter = DateFormatter().with {
        $0.dateStyle = .medium
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Text", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Stepper(value: $quantity, in: 0...10) {
                    Text("Quantity")
                }
            }
            Section {
                TextField(
                    "Formatted Date",
                    value: $date,
                    formatter: dateFormatter
                )
                DatePicker(selection: $date) {
                    Text("Published Date")
                }
                Picker(
                    selection: $selection,
                    label: Text("Picker Name"),
                    content: {
                        Text("Value 1").tag(0)
                        Text("Value 2").tag(1)
                        Text("Value 3").tag(2)
                        Text("Value 4").tag(3)
                    }
                )
            }
            Section {
                Text(text)
                Text("\(quantity)")
                Text("\(date)")
                Text(selection)
            }
        }
        .navigationBarTitle(Text("Settings"))
    }
}

#if DEBUG
struct ShowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowSettingsView(
                text: "Test string",
                date: Date(),
                quantity: 99,
                selection: "Value 1"
            )
        }
    }
}
#endif

