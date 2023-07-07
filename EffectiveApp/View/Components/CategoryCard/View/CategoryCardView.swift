//
//  CategoryCardView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import NukeUI
import SwiftUI


struct CategoryCardView: ViewModelDepend {
    @StateObject var vm: CategoryCardViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            LazyImage(source: self.vm.category.image_url)
            
            GeometryReader { proxy in
                Text(self.vm.category.name)
                    .appFont(.large)
                    .padding(.top, 12)
                    .padding(.leading, 16)
                    .frame(maxWidth: proxy.size.width * 0.5, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.text.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 148)
        .cornerRadius(10)
    }
}


struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(vm: .init(category: .init(id: 1, name: "Test", image_url: "")))
    }
}
