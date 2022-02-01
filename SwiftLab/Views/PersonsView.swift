//
//  PersonsView.swift
//  SwiftLab
//
//  Created by PC on 29/01/22.
//

import SwiftUI

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}

struct PersonsView: View {
    @ObservedObject var store: PersonStore
    
    var body: some View {
        List(store.persons.indexed(), id: \.1.id) { index, person in
            NavigationLink(destination: EditingView(person: self.$store.persons[index])) {
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                    Text("Age: \(person.age)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }.navigationBarTitle(Text("Persons"))
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(store: PersonStore())
    }
}
