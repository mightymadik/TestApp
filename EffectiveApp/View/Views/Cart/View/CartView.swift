//
//  CartView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


struct CartView: ViewModelDepend {
    @StateObject var vm: CartViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(self.vm.dishes, id: \.self) { dish in
                        RowCartDishView(vm: self.vm.getVM(dish: dish))
                    }
                }
                .padding(.horizontal, 16)
            }
            
            AccentButtonView(vm: self.vm.buttonVM) {
                
            } label: {
                Text("Оплатить \(String(format: "%.0f", self.vm.total)) ₽")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .disabled(self.vm.dishes.isEmpty)
        }
        .padding(.top, 10)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(vm: .init())
    }
}
