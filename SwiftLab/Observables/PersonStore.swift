//
//  PersonStore.swift
//  SwiftLab
//
//  Created by PC on 29/01/22.
//

import SwiftUI
import Combine

struct Person: Identifiable {
    let id: UUID
    var name: String
    var age: Int
}

final class PersonStore: ObservableObject {
    @Published var persons: [Person] = [
        .init(id: .init(), name: "Jacob", age: 27),
        .init(id: .init(), name: "Simba", age: 31),
        .init(id: .init(), name: "Fred", age: 25)
    ]
}
