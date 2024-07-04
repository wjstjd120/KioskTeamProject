//
//  Sample.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import Foundation

struct Book {
    let title: String
    let price: String
    let imageName: String
}
class BooksData {
    static let shared = BooksData()

    let books: [Book] = [
        Book(title: "책이름", price: "300원", imageName: "book1",장르),
        Book(title: "Book 2", price: "300원", imageName: "book2"),
        Book(title: "Book 3", price: "300원", imageName: "book3"),
        Book(title: "Book 4", price: "300원", imageName: "book4"),
        Book(title: "Book 5", price: "300원", imageName: "book5"),
        Book(title: "Book 6", price: "300원", imageName: "book6"),
        Book(title: "Book 7", price: "300원", imageName: "book7"),
        Book(title: "Book 8", price: "300원", imageName: "book8"),
        Book(title: "Book 9", price: "300원", imageName: "book9"),
        Book(title: "Book 10", price: "300원", imageName: "book10"),
        Book(title: "Book 11", price: "300원", imageName: "book11"),
        Book(title: "Book 12", price: "300원", imageName: "book12"),
        Book(title: "Book 13", price: "300원", imageName: "book13"),
        Book(title: "Book 14", price: "300원", imageName: "book14"),
        Book(title: "Book 15", price: "300원", imageName: "book15"),
        Book(title: "Book 16", price: "300원", imageName: "book16"),
        Book(title: "Book 17", price: "300원", imageName: "book17"),
        Book(title: "Book 18", price: "300원", imageName: "book18"),
        Book(title: "Book 19", price: "300원", imageName: "book19"),
        Book(title: "Book 20", price: "300원", imageName: "book20"),
        Book(title: "Book 21", price: "300원", imageName: "book21"),
        Book(title: "Book 22", price: "300원", imageName: "book22"),
        Book(title: "Book 23", price: "300원", imageName: "book23")
    ]

    private init() {} // Singleton 패턴을 위한 private initializer
}

