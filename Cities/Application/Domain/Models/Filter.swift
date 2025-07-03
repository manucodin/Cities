//
//  Filter.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

enum Filter: String, CaseIterable, Identifiable {
    case all
    case favorites
    
    var id: Self { self }
    
    var localizedValue: String {
        switch self {
        case .all:
            return String(localized: "filter_all")
        case .favorites:
            return String(localized: "filte_favorites")
        }
    }
}
