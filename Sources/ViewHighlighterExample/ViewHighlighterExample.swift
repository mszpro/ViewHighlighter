//
//  ContentView.swift
//  SwiftUIHighlighter
//
//  Created by msz on 2023/01/23.
//

#if os(iOS)

import SwiftUI
import MapKit
import ViewHighlighter

@available(iOS 15.0, *)
struct ViewHighlighterExample: View {
    
    @State var currentSpot: Int? = 0
    
    var body: some View {
        
        VStack {
            
            Map(coordinateRegion: .constant(.init(center: .init(latitude: 34.98584759304511, longitude: 135.75867838657743),
                                                  latitudinalMeters: 5000,
                                                  longitudinalMeters: 5000)))
            .ignoresSafeArea()
            .overlay {
                
                VStack {
                    
                    SearchTextFieldView(searchText: .constant("Some search text"))
                        .addSpotlight(0, text: "Search for the name of a location")
                    
                    Spacer()
                    
                    Button {
                        self.currentSpot = 0
                    } label: {
                        Image(systemName: "star")
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.system(size: 30))
                    .addSpotlight(1, text: "Button in the middle of the view just to test the feature of this framework")
                    
                    Spacer()
                    
                    HStack {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "location.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.system(size: 30))
                        .addSpotlight(2, text: "Tap this button to center the map")
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "star.bubble")
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.system(size: 30))
                        .addSpotlight(3, text: "Click here to view a list of featured locations")
                        
                    }
                    
                }
                .padding()
                
            }
            
        }
        .applySpotlightOverlay(currentSpot: $currentSpot)
        
    }
}

@available(iOS 15.0, *)
struct ViewHighlighterExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewHighlighterExample()
    }
}

#endif
