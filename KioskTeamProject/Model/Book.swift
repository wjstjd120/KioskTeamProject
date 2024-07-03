//
//  Sample.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit

struct Book {
    let title: String
    let code: String
    let price: Double
    let image: UIImage
    let category: String
    
    static let list: [Book] = [
        Book(title: "원피스", code: "AA0001", price: 300, image: .book1, category: "action"),
        Book(title: "나루토", code: "AA0002", price: 200, image: .book2, category: "action"),
        Book(title: "블리치", code: "AA0003", price: 400, image: .book3, category: "action"),
        Book(title: "진격의거인", code: "AA0004", price: 350, image: .book4, category: "action"),
        Book(title: "케로로", code: "AA0005", price: 390, image: .book5, category: "action"),
        Book(title: "나의 히어로 아카데미아", code: "AA0006", price: 230, image: .book6, category: "action"),
        Book(title: "귀멸의 칼날", code: "AA0007", price: 120, image: .book7, category: "action"),
        Book(title: "혈계전선", code: "AA0008", price: 300, image: .book8, category: "action")
    ]
}


