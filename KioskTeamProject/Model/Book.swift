//
//  Sample.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit

struct Book {
    let title: String
    let price: Int
    let image: UIImage
    let category: String
}

class BookInit {
    static let shared = BookInit()

    let list: [Book] = [
        Book(title: "메이드인 인 어비스", price: 300, image: .book1, category: "Horror"),
        Book(title: "하이큐", price: 300, image: .book2, category: "Action"),
        Book(title: "크레용 신짱", price: 300, image: .book3, category: "Action"),
            Book(title: "prison school", price: 300, image: .book4, category: "Horror"),
            Book(title: "prison school", price: 300, image: .book5, category: "Horror"),
            Book(title: "귀멸의 칼날", price: 300, image: .book6, category: "Action"),
            Book(title: "치즈인더트랩", price: 300, image: .book7, category: "Romance"),
            Book(title: "나루토", price: 300, image: .book8, category: "Action"),
            Book(title: "아따맘마", price: 300, image: .book9, category: "Romance"),
            Book(title: "너에게 닿기를", price: 300, image: .book10, category: "Romance"),
            Book(title: "블리치", price: 300, image: .book11, category: "Action"),
            Book(title: "체인소맨", price: 300, image: .book12, category: "Action"),
            Book(title: "스쿨럼블", price: 300, image: .book13, category: "Romance"),
            Book(title: "장난을 잘 치는 타카기 양", price: 300, image: .book14, category: "Romance"),
            Book(title: "지옥탕", price: 300, image: .book15, category: "Horror"),
            Book(title: "카케구루이", price: 300, image: .book16, category: "Horror"),
            Book(title: "주술회전", price: 300, image: .book17, category: "Action"),
            Book(title: "원피스", price: 300, image: .book18, category: "Action"),
            Book(title: "약속의 네버랜드", price: 300, image: .book19, category: "Action"),
            Book(title: "진격의 거인", price: 300, image: .book20, category: "Action"),
            Book(title: "나의 히어로아케데미아", price: 300, image: .book21, category: "Action"),
            Book(title: "기생수", price: 300, image: .book22, category: "Horror"),
            Book(title: "유희왕", price: 300, image: .book23, category: "Action")
    ]

    private init() {} // Singleton 패턴을 위한 private initializer
}


