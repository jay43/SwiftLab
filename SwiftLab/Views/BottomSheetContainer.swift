//
//  BottomSheetContainer.swift
//  SwiftLab
//
//  Created by PC on 04/02/22.
//

import SwiftUI
import UIKit
import MapKit

struct BottomSheetContainer: View {
    @State private var bottomSheetShown = false
    @State private var centerLocation = CLLocationCoordinate2D(
        latitude: 37.789467,
        longitude:-122.416772
    )
    @State private var links: [URL] = [
        URL(string: "https://twitter.com/mecid")!,
        URL(string: "https://apple.com/")!
    ]
    
    var body: some View {
        GeometryReader { geometry in
            MapView(center: $centerLocation)
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.7
            ) {
                HStack {
                    Spacer()
                    HStack(alignment: .center) {
                        Image(systemName: "star")
                        VStack(alignment: .center) {
                            Text("Toronto")
                            Text("Paris")
                            Text("London")
                            Text("Madrid")
                        }
                    }
                    Spacer()
                    HStack(alignment: .custom) {
                        Image(systemName: "star")
                        VStack(alignment: .leading) {
                            Text("Toronto")
                            Text("Paris")
                            Text("London")
                                .alignmentGuide(.custom) { $0[VerticalAlignment.center] }
                            Text("Madrid")
                        }
                    }
                    Spacer()
                    List {
                        ForEach(links, id: \.self) { url in
                            Text(url.absoluteString)
                                .onDrag { NSItemProvider(object: url as NSURL) }
                        }
                        .onInsert(of: ["public.url"], perform: drop)
//                        .onDrop(
//                            of: ["public.url"],
//                            delegate: BookmarksDropDelegate(bookmarks: $links)
//                        )
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private func drop(at index: Int, _ items: [NSItemProvider]) {
        for item in items {
            _ = item.loadObject(ofClass: URL.self) { url, _ in
                DispatchQueue.main.async {
                    url.map { self.links.insert($0, at: index) }
                }
            }
        }
    }
}

struct BottomSheetContainer_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContainer()
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var center: CLLocationCoordinate2D
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.setCenter(center, animated: true)
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        private let mapView: MapView
        
        init(_ mapView: MapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            self.mapView.center = mapView.centerCoordinate
        }
    }
}

//Custom alignment
extension VerticalAlignment {
    struct CustomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center]
        }
    }
    
    static let custom = VerticalAlignment(CustomAlignment.self)
}


//Drop delegates
struct BookmarksDropDelegate: DropDelegate {
    @Binding var bookmarks: [URL]
    
    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: ["public.url"]) else {
            return false
        }
        
        let items = info.itemProviders(for: ["public.url"])
        for item in items {
            _ = item.loadObject(ofClass: URL.self) { url, _ in
                if let url = url {
                    DispatchQueue.main.async {
                        self.bookmarks.insert(url, at: 0)
                    }
                }
            }
        }
        
        return true
    }
}
