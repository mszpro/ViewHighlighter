//
//  VisualEffectView.swift
//  KyotoShrineGuide
//
//  Created by msz on 2023/01/02.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
