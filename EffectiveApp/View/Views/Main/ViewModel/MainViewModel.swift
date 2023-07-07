//
//  MainViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import Foundation


@MainActor
final class MainViewModel: ViewModel {
    @Published private (set) var dateString: String = ""
    @Published private (set) var city: String = "Неизвестно"
    @Published private (set) var selectedDish: DishModel? = nil
    
    let homeVM: HomeViewModel = .init()
    let cartVM: CartViewModel = .init()
    let tabVM: TabBarViewModel = .init()
    
    private let locationManager: LocationManager = .init()
    private let df: DateFormatter = .init()
    private let calendar: Calendar = .current
    private var date: Date = .now
    
    
    init() {
        
    }
    
    
    func updateUI() {
        self.updateDate()
        self.updateLocation()
    }
    
    
    func selectDish(dish: DishModel) {
        self.selectedDish = dish
    }
    
    
    func unselectDish() {
        self.selectedDish = nil
    }
    
    
    private func updateLocation() {
        self.locationManager.request()
        Task {
            guard let city = try? await self.locationManager.getCity() else {
                return
            }
            self.city = city
        }
    }
    
    
    private func updateDate() {
        let compare = self.calendar.compare(self.date, to: .now, toGranularity: .day)
        
        guard compare == .orderedSame else {
            return
        }
        self.date = .now
        self.setDateString()
    }
    
    
    private func setDateString() {
        df.locale = .init(identifier: "RU")
        df.dateFormat = "dd MMMM, YYYY"
        self.dateString = self.df.string(from: self.date)
    }
}
