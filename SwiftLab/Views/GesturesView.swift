//
//  GesturesView.swift
//  SwiftLab
//
//  Created by PC on 29/01/22.
//

import SwiftUI

struct GesturesView: View {
    @GestureState var isLongPressed = false
    @State private var offset: CGSize = .zero
    
    var body: some View {
        let longPress = LongPressGesture()
            .updating($isLongPressed) { value, state, transaction in
                state = value
            }
//            .simultaneously(with: DragGesture()
//                                .onChanged { self.offset = $0.translation }
//                                .onEnded { _ in self.offset = .zero }
//            )
            .sequenced(before: DragGesture()
                        .onChanged { self.offset = $0.translation }
                        .onEnded { _ in self.offset = .zero }
            )
//            .exclusively(before: DragGesture()
//                            .onChanged { self.offset = $0.translation }
//                            .onEnded { _ in self.offset = .zero }
//            )
//
        let drag = DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded {
                if $0.translation.width < -100 {
                    self.offset = .init(width: -1000, height: 0)
                } else if $0.translation.width > 100 {
                    self.offset = .init(width: 1000, height: 0)
                } else {
                    self.offset = .zero
                }
            }
        return
//        PersonView()
//            .background(Color.red)
//            .cornerRadius(8)
//            .shadow(radius: 8)
//            .padding()
//            .offset(x: offset.width, y: offset.height)
//            .gesture(drag)
//            .animation(.interactiveSpring(), value: offset)
        Rectangle()
            .fill(isLongPressed ? Color.purple : Color.red)
            .frame(width: 300, height: 300)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding()
            .scaleEffect(isLongPressed ? 1.1 : 1)
            .offset(x: offset.width, y: offset.height)
            .gesture(longPress)
            .animation(.interactiveSpring(), value: offset)
            .animation(.interactiveSpring(), value: isLongPressed)
    }
}

struct GesturesView_Previews: PreviewProvider {
    static var previews: some View {
        GesturesView()
    }
}


struct PersonView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray)
                .cornerRadius(8)
                .frame(height: 300)
            
            Text("Spider Man")
                .font(.title)
                .foregroundColor(.white)
            
            Text("iOS Developer")
                .font(.body)
                .foregroundColor(.white)
        }.padding()
    }
}
