//
//  ItemsView.swift
//  SwiftLab
//
//  Created by PC on 03/02/22.
//

import SwiftUI

struct ItemsView: View {
    let items: [String]
    
    var body: some View {
        List(items, id:\.self) { item in
            NavigationLink(destination: Text("It's never over till it's over.")) {
                Text(item)
            }
        }
    }
}


struct ItemssView<Destination: View>: View {
    let items: [String]
    let buildDestination: (String) -> Destination
    
    var body: some View {
        List(items, id:\.self) { item in
            NavigationLink(destination: self.buildDestination(item)) {
                Text(item)
            }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(items: ["WAS", "asad", "dfjsk"])
    }
}


