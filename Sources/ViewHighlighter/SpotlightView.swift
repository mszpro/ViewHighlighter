import SwiftUI

#if os(iOS)

@available(iOS 15.0, *)
struct HighlightedProperty {
    var anchor: Anchor<CGRect>
    var text: String = ""
}

@available(iOS 15.0, *)
struct AnchorPreference: PreferenceKey {
    static var defaultValue: [Int: HighlightedProperty] = [:]
    
    static func reduce(value: inout [Int: HighlightedProperty], nextValue: () -> [Int: HighlightedProperty]) {
        value.merge(nextValue()){$1}
    }
}

@available(iOS 15.0, *)
public extension View {
    
    @ViewBuilder
    func addSpotlight(_ id: Int, text: String) -> some View {
        self
            .anchorPreference(key: AnchorPreference.self, value: .bounds) {
                [id: HighlightedProperty(anchor: $0, text: text)]
            }
    }
    
    func applySpotlightOverlay(currentSpot: Binding<Int?>) -> some View {
        self.overlayPreferenceValue(AnchorPreference.self) { values in
            GeometryReader { proxy in
                if let preference = values.first(where: { item in
                    item.key == currentSpot.wrappedValue
                }) {
                    let anchor = proxy[preference.value.anchor]
                    
                    OverlayView(highlightAnchorPosition: anchor,
                                currentSpot: currentSpot,
                                totalSpotsCount: values.count,
                                textContent: preference.value.text)
                    
                }
            }
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .animation(.easeInOut, value: currentSpot.wrappedValue) // animate when the spotlight index changes
        }
    }
    
}

@available(iOS 15.0, *)
private struct OverlayView: View {
    
    var highlightAnchorPosition: CGRect
    @Binding var currentSpot: Int?
    var totalSpotsCount: Int
    var textContent: String
    var blurredViewOpacity: CGFloat = 0.9
    
    var body: some View {
        
        VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            .opacity((currentSpot != nil) ? blurredViewOpacity : 0)
            .overlay(alignment: .top) {
                
                VStack {
                    
                    Text(textContent)
                        .padding(.all, 15)
                        .foregroundColor(Color.white)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.blue)
                                .shadow(radius: 10)
                        }
                    
                    HStack {
                        
                        // switch to previous one button
                        Button {
                            guard let currentSpotIndex = self.currentSpot else { return }
                            currentSpot = currentSpotIndex - 1
                        } label: {
                            Image(systemName: "chevron.left.circle.fill")
                        }
                        .disabled((currentSpot ?? 0) <= 0)
                        .font(.system(size: 25))
                        
                        // current page index
                        Text("\((currentSpot ?? 0) + 1)/\(totalSpotsCount)")
                        
                        // switch to next one button
                        Button {
                            guard let currentSpotIndex = self.currentSpot else { return }
                            currentSpot = currentSpotIndex + 1
                        } label: {
                            Image(systemName: "chevron.right.circle.fill")
                        }
                        .disabled((currentSpot ?? 0) >= (totalSpotsCount - 1))
                        .font(.system(size: 25))
                        
                    }
                    
                    Button {
                        currentSpot = totalSpotsCount
                    } label: {
                        Image(systemName: (currentSpot == (totalSpotsCount - 1)) ? "xmark" : "chevron.forward.2")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
                    
                }
                .offset(x: 0, y: (highlightAnchorPosition.minY > UIScreen.main.bounds.height / 2) ? (UIScreen.main.bounds.height / 2) : highlightAnchorPosition.maxY)
                .padding()
                
            }
            .onTapGesture {
                guard let currentSpotIndex = self.currentSpot else { return }
                currentSpot = currentSpotIndex + 1
            }
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: highlightAnchorPosition.width,
                                   height: highlightAnchorPosition.height)
                            .offset(x: highlightAnchorPosition.minX,
                                    y: highlightAnchorPosition.minY)
                    }
            }
        
    }
    
}

#endif
