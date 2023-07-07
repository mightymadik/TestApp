//
//  ViewModelDepent.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


protocol ViewModelDepend: View {
    associatedtype ViewModelT: ViewModel
    
    var vm: ViewModelT { get }
}
