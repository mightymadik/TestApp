//
//  RowCartDishView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import NukeUI
import SwiftUI


struct RowCartDishView: ViewModelDepend {
    @StateObject var vm: RowCartDishViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Color.backgroundGray
                
                LazyImage(source: self.vm.dish.image_url)
                    .padding(10)
            }
            .frame(width: 62, height: 62, alignment: .center)
            .cornerRadius(6)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(self.vm.dish.name)
                    .foregroundColor(.text.primary)
                    .appFont(.text)
                
                HStack {
                    Text("\(self.vm.dish.priceString)₽")
                        .foregroundColor(.text.primary)
                    
                    Text("· \(self.vm.dish.weightString)г")
                        .foregroundColor(.text.opacity)
                }
                .appFont(.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: 16) {
                Button {
                    self.vm.remove()
                } label: {
                    Image("minus")
                }

                Text("\(self.vm.count)")
                    .foregroundColor(.text.primary)
                
                Button {
                    self.vm.add()
                } label: {
                    Image("plus")
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(TabBarColorScheme().stroke)
            .cornerRadius(10)
        }
    }
}
