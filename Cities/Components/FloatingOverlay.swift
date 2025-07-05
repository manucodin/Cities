//
//  FloatingOverlay.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct FloatingOverlay<Content: View>: View {
    let isPresented: Bool
    let dismiss: (() -> Void)?
    let content: () -> Content
    
    init(isPresented: Bool, dismiss: (() -> Void)? = nil, content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.dismiss = dismiss
        self.content = content
    }
    
    var body: some View {
        contentView
    }
}

private extension FloatingOverlay {
    @ViewBuilder
    var contentView: some View {
        ZStack(alignment: .center) {
            if isPresented {
                backgroundView
                containerView
            }
        }
    }
    
    @ViewBuilder
    var backgroundView: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .onTapGesture {
                dismiss?()
            }
    }
    
    @ViewBuilder
    var containerView: some View {
        VStack {
            Spacer()
            content()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 8)
                )
                .padding()
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: isPresented)
    }
}
