//
//  PagerContainerView.swift
//  SwiftLab
//
//  Created by PC on 04/02/22.
//

import SwiftUI

struct PagerContainerView: View {
    @State private var currentPage = 0
    
    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            Color.blue
            Color.red
            Color.green
        }
    }
}

struct PagerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PagerContainerView()
    }
}
