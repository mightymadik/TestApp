//
//  HomeView.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import SwiftUI

struct HomeView: ViewModelDepend {
    @StateObject var vm: HomeViewModel
    @State var activeLink: HomeViewState?
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 8) {
                    if self.vm.isLoading {
                        ProgressView()
                            .frame(maxWidth: proxy.size.width, minHeight: proxy.size.height)
                    } else {
                        ForEach(self.vm.categories, id: \.self) { category in
                            NavigationLink(tag: .categoryLink(id: category.id), selection: self.$activeLink, destination: {
                                CategoryView(vm: self.vm.getCategoryVM(category: category))
                            }, label: {
                                CategoryCardView(vm: self.vm.getCategoryCardVM(category: category))
                            })
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .alert(isPresented: self.$vm.showAlert, content: {
            Alert(
                title: Text("Ошибка"),
                message: Text(self.vm.error?.localizedDescription ?? ""),
                dismissButton: .cancel(Text("Понятно"), action: {
                    self.vm.error = nil
                }))
        })
        .task {
            if self.vm.categories.isEmpty {
                await self.vm.fetchCategories()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: .init())
    }
}
