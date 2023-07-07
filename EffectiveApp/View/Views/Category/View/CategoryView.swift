//
//  CategoryView.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


struct CategoryView: ViewModelDepend {
    @StateObject var vm: CategoryViewModel
    @EnvironmentObject private var mainVM: MainViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("left_arrow")
                            .frame(width: 30, height: 30)
                    }
                    .frame(maxWidth: proxy.size.width * 0.15, alignment: .leading)

                    Text(self.vm.category.name)
                        .appFont(.header1)
                        .frame(maxWidth: proxy.size.width * 0.7, alignment: .center)
                        .lineLimit(1)
                        .foregroundColor(.text.primary)

                    Button {

                    } label: {
                        Image("avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                    }
                    .frame(maxWidth: proxy.size.width * 0.15, alignment: .trailing)
                    .disabled(true)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.bottom, 6)
            .frame(height: 60)
            .background(Color.background)
            
            VStack(alignment: .leading, spacing: 16) {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 8) {
                            ForEach(self.vm.tags, id: \.self) { tag in
                                TagView(tag: tag, proxy: proxy)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                GeometryReader { proxy in
                    let columns = Array(repeating: GridItem(.flexible()), count: 3)
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        if self.vm.isLoading {
                            ProgressView()
                                .frame(maxWidth: proxy.size.width, minHeight: proxy.size.height)
                        } else {
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(self.vm.sortedDishes, id:\.self) { dish in
                                    Button {
                                        self.mainVM.selectDish(dish: dish)
                                    } label: {
                                        DishCardView(vm: .init(dish: dish))
                                    }
                                    .frame(minHeight: 180)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
        .task {
            if self.vm.dishes.isEmpty {
                await self.vm.fetchDishes()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    
    @ViewBuilder
    private func TagView(tag: String, proxy: ScrollViewProxy) -> some View {
        Button {
            self.vm.setTag(tag: tag)
            
            withAnimation(.easeInOut(duration: 0.2)) {
                proxy.scrollTo(tag, anchor: .center)
            }
        } label: {
            Text(tag)
                .appFont(.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(self.vm.selectedTag == tag ? Color.text.accent : Color.text.primary)
                .background(self.vm.selectedTag == tag ? Color.accentColor : Color.backgroundGray)
                .cornerRadius(10)
        }
        .id(tag)
        .animation(.easeInOut(duration: 0.2), value: self.vm.selectedTag)

    }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(vm: .init(category: .init(id: 1, name: "Test", image_url: "")))
    }
}
