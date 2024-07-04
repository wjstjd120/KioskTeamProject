//
//  Basket.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//
struct Basket {
    let amount: Int
    let code: String
}

class BasketInit {
    static let shared = BasketInit()
    
    private init() {}
    
    private var baskets: [Basket] = []
    
    func addBasket(_ basket: Basket) {
        baskets.append(basket)
    }
    
    func getBaskets() -> [Basket] {
        return baskets
    }
}
