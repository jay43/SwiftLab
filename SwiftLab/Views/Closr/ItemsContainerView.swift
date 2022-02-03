//
//  ItemsContainerView.swift
//  SwiftLab
//
//  Created by PC on 03/02/22.
//

import SwiftUI

struct ItemsContainerView: View {
    @State private var items: [String] = ["There is", "No Growth", "In Confortzone."]
    
    var body: some View {
        VStack {
            ItemsView(items: items)
            ItemssView(items: items) { items in
                Text(items)
            }
        }
    }
}

struct ItemsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsContainerView()
    }
}
