//
//  ErrorStateView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct ErrorStateView: View {
    let imageName: String?
    let title: String?
    let message: String?
    let retryButtonLabel: String?
    let retryAction: (() -> Void)?

    var body: some View {
        contentView
    }
}

private extension ErrorStateView {
    @ViewBuilder
    var contentView: some View {
        VStack(spacing: 16) {
            imageView
            titleView
            messageView
            retryButton
        }
        .padding()
    }
    
    @ViewBuilder
    var imageView: some View {
        if let imageName {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.error)
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
    
    @ViewBuilder
    var retryButton: some View {
        if let retryAction, let retryButtonLabel {
            Button(action: retryAction) {
                Text(retryButtonLabel)
                    .roundedButtonStyle()
            }
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    ErrorStateView(
        imageName: "eye.slash",
        title: "Title",
        message: "Message",
        retryButtonLabel: "Retry",
        retryAction: {}
    )
}
