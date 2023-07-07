//
//  AccentButton.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


struct AccentButtonView<Content: View>: ViewModelDepend {
    @StateObject var vm: AccentButtonViewModel
    let action: () -> Void
    let label: Content
    
    
    init(vm: AccentButtonViewModel, action: @escaping() -> Void, @ViewBuilder label: () -> Content) {
        self._vm = StateObject(wrappedValue: vm)
        self.action = action
        self.label = label()
    }
    
    
    var body: some View {
        Button {
            self.action()
        } label: {
            self.label
                .appFont(.header3)
                .foregroundColor(self.vm.colorScheme.foreground)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(self.vm.colorScheme.background)
                .cornerRadius(10)
        }

    }
}
