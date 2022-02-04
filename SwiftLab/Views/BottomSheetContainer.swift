//
//  BottomSheetContainer.swift
//  SwiftLab
//
//  Created by PC on 04/02/22.
//

import SwiftUI

struct BottomSheetContainer: View {
    @State private var bottomSheetShown = false
    
    var body: some View {
        GeometryReader { geometry in
            Color.green
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.7
            ) {
                Color.blue
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct BottomSheetContainer_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContainer()
    }
}
