//
//  DishCardView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import NukeUI
import SwiftUI


struct DishCardView: ViewModelDepend {
    @StateObject var vm: DishCardViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 5) {
                ZStack {
                    Color.backgroundGray
                        
                    
                    LazyImage(source: self.vm.dish.image_url) { state in
                        if let image = state.image {
                            image
                                .resizingMode(.aspectFit)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: proxy.size.width, height: proxy.size.width)
                .cornerRadius(10)
                
                Text(self.vm.dish.name)
                    .appFont(.text)
                    .foregroundColor(.text.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}


struct DishCardView_Previews: PreviewProvider {
    static var previews: some View {
        DishCardView(vm: .init(dish: .init(id: 1, name: "Test", price: 50.0, weight: 100, description: "Test description", image_url: "", tags: ["Test"])))
    }
}
