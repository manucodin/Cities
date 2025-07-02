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
            return "filter_all"
        case .favorites:
            return "filte_favorites"
        }
    }
}
