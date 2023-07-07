//
//  ContentView.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator: Coordinator = .shared
    
    var body: some View {
        MainView(vm: .init())
            .environmentObject(self.coordinator)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
