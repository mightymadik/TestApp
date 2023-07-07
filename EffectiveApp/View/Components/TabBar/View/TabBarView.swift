//
//  TabBarView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


struct TabBarView: ViewModelDepend {
    @StateObject var vm: TabBarViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(self.vm.colorScheme.stroke)
            
            HStack {
//                ForEach(MainViewState.allCases, id: \.self) { state in
                TabItemView(.home)
                TabItemView(.search)
                TabItemView(.cart)
                TabItemView(.profile)
//                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 14)
            .padding(.horizontal, 16)
            .background(self.vm.colorScheme.background)
        }
    }
    
    
    @ViewBuilder
    private func TabItemView(_ state: MainViewState) -> some View {
        Button {
            self.coordinator.setViewState(state)
        } label: {
            VStack(spacing: 7) {
                Image(state.icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Text(state.label)
                    .appFont(.tab)
            }
            .foregroundColor(self.coordinator.state == state ? self.vm.colorScheme.selectedForeground : self.vm.colorScheme.foreground)
            .transition(.scale)
            .animation(.easeInOut(duration: 0.2), value: self.coordinator.state)
            .frame(maxWidth: .infinity, alignment: .center)
            .contentShape(Rectangle())
        }

    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(vm: .init())
    }
}
