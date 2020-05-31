//
//  Extensions.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 26/05/2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation

extension Array {
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
