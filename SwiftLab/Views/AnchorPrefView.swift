//
//  AnchorPrefView.swift
//  SwiftLab
//
//  Created by PC on 18/02/22.
//

import SwiftUI

struct AnchorPrefView: View {
    var body: some View {
        ZStack {
            Color.yellow
            Text("Hello World !!!")
                .anchorPreference(
                    key: BoundsPreferenceKey.self,
                    value: .bounds
                ) { $0 }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                preferences.map {
                    Rectangle()
                        .stroke()
                        .frame(
                            width: geometry[$0].width,
                            height: geometry[$0].height
                        )
                        .offset(
                            x: geometry[$0].minX,
                            y: geometry[$0].minY
                        )
                }
            }
        }
    }
}

struct AnchorPrefView_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPrefView()
    }
}


struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    
    static var defaultValue: Value = nil
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}

