//
//  RoundButtonModifier.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct RoundButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.backgroundPrimary.opacity(0.9))
            .clipShape(Circle())
            .shadow(radius: 4)
    }
}

extension View {
    func roundButtonStyle() -> some View {
        self.modifier(RoundButtonModifier())
    }
}
