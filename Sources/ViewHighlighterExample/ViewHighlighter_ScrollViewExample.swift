//
//  SwiftUIView.swift
//  
//
//  Created by msz on 2023/01/24.
//

import SwiftUI
import ViewHighlighter

@available(iOS 15.0, *)
struct ViewHighlighter_ScrollViewExample: View {
    
    @State var currentSpot: Int? = 0
    
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                AsyncImage(url: URL(string: "https://placekitten.com/1200/1200")) { loadedImage in
                    loadedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                .id(0)
                .addSpotlight(0, text: "This is the first cat image")
                
                AsyncImage(url: URL(string: "https://placekitten.com/1100/1100")) { loadedImage in
                    loadedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                .id(1)
                .addSpotlight(1, text: "This is the second cat image")
                
                AsyncImage(url: URL(string: "https://placekitten.com/1000/1000")) { loadedImage in
                    loadedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                .id(2)
                .addSpotlight(2, text: "This is the third cat image")
                
                AsyncImage(url: URL(string: "https://placekitten.com/1500/1500")) { loadedImage in
                    loadedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                .id(3)
                .addSpotlight(3, text: "This is the fourth cat image")
                
                AsyncImage(url: URL(string: "https://placekitten.com/800/800")) { loadedImage in
                    loadedImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                .id(4)
                .addSpotlight(4, text: "I think that is enough cats to explain this new feature")
                
            }
            .applySpotlightOverlay(currentSpot: $currentSpot)
            .onChange(of: currentSpot) { newValue in
                guard let newValue else { return }
                withAnimation {
                    // scroll to make sure the current spotlight is visible
                    if newValue < 5 {
                        proxy.scrollTo(newValue, anchor: .bottom)
                    }
                    // at the last spotlight (index + 1), scroll to the very top
                    if newValue == 5 {
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
            }
            
        }
        
    }
    
}

@available(iOS 15.0, *)
struct ViewHighlighter_ScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewHighlighter_ScrollViewExample()
    }
}
