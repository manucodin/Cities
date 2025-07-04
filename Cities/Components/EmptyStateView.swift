//
//  EmptyStateView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct EmptyStateView: View {
    let imageName: String?
    let title: String?
    let message: String?
    
    init(imageName: String? = nil, title: String? = nil, message: String? = nil) {
        self.imageName = imageName
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: 16) {
            imageView
            titleView
            messageView
        }
        .padding()
    }
}

private extension EmptyStateView {
    @ViewBuilder
    var imageView: some View {
        if let imageName {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.secondary)
                .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var messageView: some View {
        if let message {
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    EmptyStateView(imageName: "eye.slash", title: "Title", message: "Message")
}
