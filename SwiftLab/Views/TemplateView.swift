//
//  TemplateView.swift
//  SwiftLab
//
//  Created by PC on 28/02/22.
//

import SwiftUI

struct TemplateView: View {
    let heartRates: [Int] = [70, 0, 78, 77, 68, 61, 66]
    
    var body: some View {
        VStack{
            HStack {
                ForEach(self.heartRates, id: \.self) { hr in
                    Text("190")
                        .hidden()
                        .padding(4)
                        .background(Color.purple)
                        .cornerRadius(4)
                        .overlay(Text(String(hr)))
                }
            }
            Button(action: { print("Hello!")}) {
                HStack {
                    Image(systemName: "keyboard")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("Press me")
                }
            }
            
            Button(action: { print("Hello!")}) {
                HStack {
                    Text("00")
                        .font(.title)
                        .hidden()
                        .overlay(
                            Image(systemName: "keyboard")
                                .resizable()
                                .scaledToFit()
                        )
                    Text("Press me")
                }
            }
        }
    }
}

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView()
    }
}
