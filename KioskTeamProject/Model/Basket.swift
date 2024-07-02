//
//  Basket.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

class Basket {
    static let basket = Basket()

    private init() {}

    private var books: [Book] = []
//
//    func addBook(_ book: Book) {
//        books.append(book)
//    }
//
//    func removeBook(_ book: Book) {
//        if let index = books.firstIndex(where: { $0.code == book.code }) {
//            books.remove(at: index)
//        }
//    }
//
//    func getBook() -> [Book] {
//        return books
//    }
//
//    func getTotalPrice() -> Double {
//        return books.reduce(0) { $0 + $1.price }
//    }
}
