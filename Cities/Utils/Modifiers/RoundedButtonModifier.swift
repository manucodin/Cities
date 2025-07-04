//
//  RoundedButtonModifier.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct RoundedButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

extension View {
    func roundedButtonStyle() -> some View {
        self.modifier(RoundedButtonModifier())
    }
}
