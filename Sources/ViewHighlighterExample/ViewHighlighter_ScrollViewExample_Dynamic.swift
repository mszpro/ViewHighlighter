//
//  SwiftUIView.swift
//  
//
//  Created by msz on 2023/01/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct ViewHighlighter_ScrollViewExample_Dynamic: View {
    
    var catImageURLs: [String] = [
        "https://placekitten.com/1200/1200",
        "https://placekitten.com/1100/1100",
        "https://placekitten.com/1000/1000",
        "https://placekitten.com/1500/1500",
        "https://placekitten.com/800/800"
    ]
    
    @State var currentSpot: Int? = 0
    
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                ForEach(catImageURLs, id: \.self) { imageURL in
                    
                    AsyncImage(url: URL(string: imageURL)) { loadedImage in
                        loadedImage
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: 300, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    .id(imageURL)
                    .addSpotlight(catImageURLs.firstIndex(of: imageURL) ?? -1, text: "This is the cat image with URL \(imageURL)")
                    
                }
                
            }
            .applySpotlightOverlay(currentSpot: $currentSpot)
            .onChange(of: currentSpot) { newValue in
                guard let newValue else { return }
                withAnimation {
                    // scroll to make sure the current spotlight is visible
                    if newValue < catImageURLs.count {
                        proxy.scrollTo(catImageURLs[newValue], anchor: .bottom)
                    }
                    // at the last spotlight (index + 1), scroll to the very top
                    if newValue == catImageURLs.count,
                       let firstCatImageID = catImageURLs.first
                    {
                        proxy.scrollTo(firstCatImageID, anchor: .top)
                    }
                }
            }
            
        }
        
    }
    
}

@available(iOS 15.0, *)
struct ViewHighlighter_ScrollViewExample_Dynamic_Previews: PreviewProvider {
    static var previews: some View {
        ViewHighlighter_ScrollViewExample_Dynamic()
    }
}
