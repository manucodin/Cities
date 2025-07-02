//
//  Array+Extension.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [self] }
        return stride(from: 0, to: self.count, by: size).map { start in
            let end = Swift.min(start + size, self.count)
            return Array(self[start..<end])
        }
    }
}
