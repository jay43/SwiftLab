//
//  GradientsView.swift
//  SwiftLab
//
//  Created by PC on 03/02/22.
//

import SwiftUI

struct GradientsView: View {
    var body: some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            GeometryReader { geo in
                RadialGradient(
                    gradient: Gradient(colors: [.orange, .white, .orange, .white]),
                    center: .center,
                    startRadius: 1,
                    endRadius: geo.size.height/2
                )
            }
            AngularGradient(
                gradient: Gradient(
                    colors: [
                        .orange, .white, .orange, .white, .orange, .white, .orange, .white, .orange
                    ]
                ),
                center: .center
            )
        }
    }
}

struct GradientsView_Previews: PreviewProvider {
    static var previews: some View {
        GradientsView()
    }
}
