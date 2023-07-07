//
//  DishModel.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


struct DishModel: Remotable {
    let id: Int
    let name: String
    let price: Double
    let weight: Double
    let description: String
    let image_url: String
    let tegs: [String]
    
    
    let priceString: String
    let weightString: String
    
    
    init(
        id: Int,
        name: String,
        price: Double,
        weight: Double,
        description: String,
        image_url: String,
        tags: [String]
    ) {
        self.id = id
        self.name = name
        self.price = price
        self.weight = weight
        self.description = description
        self.image_url = image_url
        self.tegs = tags
        
        self.priceString = String(format: "%.0f", self.price)
        self.weightString = String(format: "%.0f", self.weight)
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.description = try container.decode(String.self, forKey: .description)
        self.image_url = try container.decode(String.self, forKey: .image_url)
        self.tegs = try container.decode([String].self, forKey: .tegs)
        
        self.priceString = String(format: "%.0f", self.price)
        self.weightString = String(format: "%.0f", self.weight)
    }
}
