//
//  LargeDishCardView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import NukeUI
import SwiftUI


struct LargeDishCardView: ViewModelDepend {
    @StateObject var vm: LargeDishCardViewModel
    @EnvironmentObject private var mainVM: MainViewModel
    let dismiss: () -> Void
    
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    Color.backgroundGray
                    
                    LazyImage(source: self.vm.dish.image_url) { state in
                        if let image = state.image {
                            image
                                .resizingMode(.aspectFit)
                                .frame(maxHeight: 200)
                        }
                    }
                }
                
                HStack(alignment: .center, spacing: 8) {
                    Button {
                        
                    } label: {
                        Image("favorite")
                            .frame(width: 40, height: 40)
                    }
                    .background(Color.background)
                    .cornerRadius(8)
                    
                    
                    Button {
                        self.dismiss()
                    } label: {
                        Image("times")
                            .frame(width: 40, height: 40)
                    }
                    .background(Color.background)
                    .cornerRadius(8)
                    
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity, maxHeight: 230, alignment: .center)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(self.vm.dish.name)
                    .foregroundColor(.text.primary)
                    .appFont(.header2)
                
                HStack {
                    Text("\(self.vm.dish.priceString)₽")
                        .foregroundColor(.text.primary)
                    
                    Text("· \(self.vm.dish.weightString)г")
                        .foregroundColor(.text.opacity)
                }
                .appFont(.text)
                
                Text(self.vm.dish.description)
                    .foregroundColor(.text.secondary)
                    .appFont(.text)
            }
            .padding(.bottom, 16)
            
            AccentButtonView(vm: self.vm.buttonVM) {
                self.mainVM.cartVM.addDish(dish: self.vm.dish)
            } label: {
                Text("Добавить в корзину")
            }

        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.background)
        .cornerRadius(15)
    }
}

                    
struct LargeDishCardView_Previews: PreviewProvider {
    static var previews: some View {
        LargeDishCardView(vm: .init(dish: .init(id: 1, name: "Test", price: 100, weight: 100, description: "Test", image_url: "", tags: ["Test"]))) {
            print("Dismiss")
        }
    }
}
