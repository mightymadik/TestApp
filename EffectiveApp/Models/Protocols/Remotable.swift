//
//  Remotable.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


protocol Remotable: Codable, Hashable {
    
}


extension Array: Remotable where Element: Remotable {
    
}
