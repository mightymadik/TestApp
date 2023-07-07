//
//  MainView.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import SwiftUI


struct MainView: ViewModelDepend {
    @StateObject var vm: MainViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                NavigationView {
                    VStack(spacing: 0) {
                        HStack {
                            HStack(alignment: .top, spacing: 4) {
                                Image("geo")
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(self.vm.city)
                                        .appFont(.header1)
                                        .foregroundColor(.text.primary)
                                    Text(self.vm.dateString)
                                        .appFont(.subHeader1)
                                        .foregroundColor(.text.opacity)
                                }
                                .animation(.easeInOut(duration: 0.2), value: self.vm.city)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                
                            } label: {
                                Image("avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44)
                                    .clipShape(Circle())
                            }
                            .disabled(true)
                        }
                        .padding(.bottom, 6)
                        .padding(.horizontal, 16)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.background)
                        
                        Group {
                            switch self.coordinator.state {
                            case .home(let actions):
                                HomeView(vm: self.vm.homeVM, activeLink: actions)
                            case .cart:
                                CartView(vm: self.vm.cartVM)
                            default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .navigationViewStyle(.stack)
                
                TabBarView(vm: self.vm.tabVM)
            }
            .environmentObject(self.vm)
            .overlay(content: {
                VStack {
                    if let dish = self.vm.selectedDish {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea(.all)
                                .onTapGesture {
                                    self.vm.unselectDish()
                                }
                            
                            LargeDishCardView(vm: .init(dish: dish), dismiss: {
                                self.vm.unselectDish()
                            })
                            .environmentObject(self.vm)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.2), value: self.vm.selectedDish)
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            self.vm.updateUI()
        }
        .onChange(of: self.scenePhase) { newValue in
            if newValue == .active {
                self.vm.updateUI()
            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: .init())
    }
}
