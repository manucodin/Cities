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
            if let imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.secondary)
            }
            
            if let title {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            if let message {
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .accessibilityElement(children: .combine)
        
    }
}

#Preview {
    EmptyStateView(imageName: "eye.slash", title: "Title", message: "Message")
}
