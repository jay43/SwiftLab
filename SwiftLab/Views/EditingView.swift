//
//  EditingView.swift
//  SwiftLab
//
//  Created by PC on 29/01/22.
//

import SwiftUI

struct EditingView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var person: Person
    
    var body: some View {
        Form {
            Section(header: Text("Personal information")) {
                TextField("type something...", text: $person.name)
                Stepper(value: $person.age) {
                    Text("Age: \(person.age)")
                }
            }
            
            Section {
                Button("Save") {
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }.navigationBarTitle(Text(person.name))
    }
}

struct EditingView_Previews: PreviewProvider {
    static var previews: some View {
        EditingView(person: .constant(Person(id: UUID(), name: "Abcd", age: 42)))
    }
}
