//
//  ApiManager.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Alamofire
import Foundation


final class ApiManager {
    func fetchCategories() async throws -> [CategoryModel] {
        try await withUnsafeThrowingContinuation({ continuation in
            AF
                .request("https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54", method: .get)
                .responseDecodable(of: CategoriesResponseModel.self) { response in
                    switch response.result {
                    case .success(let result):
                        return continuation.resume(returning: result.сategories)
                    case .failure(let error):
                        return continuation.resume(throwing: error)
                    }
                }
        })
    }
    
    
    func fetchDishes() async throws -> [DishModel] {
        try await withUnsafeThrowingContinuation({ continuation in
            AF
                .request("https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b", method: .get)
                .responseDecodable(of: DishesResponseModel.self) { response in
                    switch response.result {
                    case .success(let result):
                        return continuation.resume(returning: result.dishes)
                    case .failure(let error):
                        return continuation.resume(throwing: error)
                    }
                }
        })
    }
}
