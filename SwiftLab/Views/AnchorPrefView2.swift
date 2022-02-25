//
//  AnchorPrefView2.swift
//  SwiftLab
//
//  Created by PC on 25/02/22.
//

import SwiftUI

struct AnchorPrefView2: View {
    @State private var cards: [String] = [
        "Sporty", "Food Lover", "Sex", "Theories", "Lifestyle & Hobbies",
        "Gaming", "Ego", "Entertainment", "Festivities & Celebration", "Mom & Dad",
        "History & politics", "The World"
    ]
    @State var totalHeight = CGFloat.zero
    
    var body: some View {
        Grid(cards) { card in
            Text(card)
                //.frame(width: 120, height: 120)
                .padding()
                .background(Color.orange)
                .cornerRadius(8)
                .padding(4)
        }
        gridItemView()
    }
    
    func gridItemView() -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(cards, id: \.self) { item in
                    Text(item)
                        .padding(8)
                        .background(
                            Capsule()
                                .fill(LinearGradient(
                                    colors: [Color.orange, .yellow, .black.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                        )
                        .padding(4)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            
                            let result = width
                            if item == cards.last {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if item == cards.last {
                                height = 0
                            }
                            return result
                        }
                }
            }).padding(.horizontal, 10)
                .background(viewHeightReader($totalHeight))
        }
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}



struct AnchorPrefView2_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPrefView2()
    }
}


struct Grid<Data: RandomAccessCollection, ElementView: View>: View where Data.Element: Hashable {
    private let data: Data
    private let itemView: (Data.Element) -> ElementView
    
    @State private var preferences: [Data.Element: CGRect] = [:]
    
    init(_ data: Data, @ViewBuilder itemView: @escaping (Data.Element) -> ElementView) {
        self.data = data
        self.itemView = itemView
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.data, id: \.self) { item in
                    self.itemView(item)
                        .alignmentGuide(.leading) { _ in
                            -self.preferences[item, default: .zero].origin.x
                        }
                        .alignmentGuide(.top) { _ in
                            -self.preferences[item, default: .zero].origin.y
                        }
                        .anchorPreference(
                            key: SizePreferences<Data.Element>.self,
                            value: .bounds
                        ) {
                            [item: geometry[$0].size]
                        }
                }
            }
            .onPreferenceChange(SizePreferences<Data.Element>.self) { sizes in
                var newPreferences: [Data.Element: CGRect] = [:]
                var bounds: [CGRect] = []
                for item in self.data {
                    let size = sizes[item, default: .zero]
                    let rect: CGRect
                    if let lastBounds = bounds.last {
                        if lastBounds.maxX + size.width > geometry.size.width {
                            let origin = CGPoint(x: 0, y: lastBounds.maxY)
                            rect = CGRect(origin: origin, size: size)
                        } else {
                            let origin = CGPoint(x: lastBounds.maxX, y: lastBounds.minY)
                            rect = CGRect(origin: origin, size: size)
                        }
                    } else {
                        rect = CGRect(origin: .zero, size: size)
                    }
                    bounds.append(rect)
                    newPreferences[item] = rect
                }
                self.preferences = newPreferences
            }
        }
    }
}

struct SizePreferences<Item: Hashable>: PreferenceKey {
    typealias Value = [Item: CGSize]
    
    static var defaultValue: Value { [:] }
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value.merge(nextValue()) { $1 }
    }
}
