//
//  ContentView.swift
//  SwiftLab
//
//  Created by PC on 28/01/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isButtonVisible = true
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                List {
                    NavigationLink(destination: SettingView(), tag: 1, selection: $selection) {
                        Button("Setting View") {
                            self.selection = 1
                        }
                    }
                    NavigationLink(destination: PersonsView(store: PersonStore())) {
                        Text("Persons View")
                    }
                    NavigationLink(destination: GesturesView()) {
                        Text("Gesture View")
                    }
                    Toggle(isOn: $isButtonVisible.animation()) {
                        Text("Show/Hide button")
                    }
                    
                    NavigationLink(destination: ItemsContainerView()) {
                        Text("Closure Concept")
                    }
                    
                    NavigationLink(destination: GradientsView()) {
                        Text("Gradient Concept")
                    }
                    Group {
                        NavigationLink(destination: BottomSheetContainer()) {
                            Text("BottomSheet")
                        }
                        
                        NavigationLink(destination: PagerContainerView()) {
                            Text("Pager concept")
                        }
                        NavigationLink(destination: AnchorPrefView()){
                            Text("Anchor Pref")
                        }
                        NavigationLink(destination: AnchorPrefView2()){
                            Text("Anchor Pref 2")
                        }
                        NavigationLink(destination: TemplateView()){
                            Text("Template View")
                        }
                        NavigationLink(destination: MailView()){
                            Text("Mail View")
                        }
                        NavigationLink(destination: InstagramShareView()){
                            Text("Instagram Share View")
                        }
                    }
                    if isButtonVisible {
                        Button(action: {}) {
                            Text("Hidden Button")
                        }.transition(.moveOrFade(edge: .trailing))
                    }
                }
            }.navigationTitle("SwiftUiLab")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension AnyTransition {
    static func moveAndScale(edge: Edge) -> AnyTransition {
        AnyTransition.move(edge: edge).combined(with: .scale)
    }
    
    static func moveOrFade(edge: Edge) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: edge),
            removal: .opacity
        )
    }
}
