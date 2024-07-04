//
//  Basket.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//
struct Basket {
    var amount: Int
    let book: Book
}

class BasketInit {
    static let shared = BasketInit()
    
    private init() {}
    
    private var baskets: [Basket] = []
    
    func addBasket(_ basket: Basket) {
        baskets.append(basket)
    }
    
    func plusAmount(_ index: Int) {
        baskets[index].amount += 1
    }
    
    func minusAmount(_ index: Int) {
        baskets[index].amount -= 1
    }
    
    func getBaskets() -> [Basket] {
        return baskets
    }
    
    func clearBaskets() {
        baskets.removeAll()
    }
    
    func removeBaskes(_ index: Int) {
        baskets.remove(at: index)
    }
    
    func getBasketsCount() -> Int {
        return baskets.map { $0.amount }.reduce(0, +)
    }
    
    func getBasketsTotalPrice() -> Int {
        return baskets.map { $0.book.price * $0.amount }.reduce(0, +)
    }
}
