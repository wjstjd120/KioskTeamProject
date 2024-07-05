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
        Book(title: "하이큐", price: 250, image: .book2, category: "Action"),
        Book(title: "크레용 신짱", price: 400, image: .book3, category: "Action"),
        Book(title: "감옥학원", price: 350, image: .book4, category: "Horror"),
        Book(title: "유희왕", price: 290, image: .book5, category: "Action"),
        Book(title: "귀멸의 칼날", price: 100, image: .book6, category: "Action"),
        Book(title: "치즈인더트랩", price: 320, image: .book7, category: "Romance"),
        Book(title: "나루토", price: 200, image: .book8, category: "Action"),
        Book(title: "아따맘마", price: 140, image: .book9, category: "Romance"),
        Book(title: "너에게 닿기를", price: 160, image: .book10, category: "Romance"),
        Book(title: "블리치", price: 300, image: .book11, category: "Action"),
        Book(title: "체인소맨", price: 300, image: .book12, category: "Action"),
        Book(title: "스쿨럼블", price: 500, image: .book13, category: "Romance"),
        Book(title: "장난을 잘 치는 타카기 양", price: 200, image: .book14, category: "Romance"),
        Book(title: "지옥탕", price: 130, image: .book15, category: "Horror"),
        Book(title: "카케구루이", price: 240, image: .book16, category: "Horror"),
        Book(title: "주술회전", price: 400, image: .book17, category: "Action"),
        Book(title: "원피스", price: 270, image: .book18, category: "Action"),
        Book(title: "약속의 네버랜드", price: 100, image: .book19, category: "Action"),
        Book(title: "진격의 거인", price: 240, image: .book20, category: "Action"),
        Book(title: "나의 히어로아카데미아", price: 140, image: .book21, category: "Action"),
        Book(title: "가정교사 히트맨 리본", price: 200, image: .가히리, category: "Romance"),
        Book(title: "강철의 연금술사", price: 230, image: .강연, category: "Romance"),
        Book(title: "격기 3반", price: 100, image: .격기3반, category: "Action"),
        Book(title: "데스노트", price: 290, image: .데스노트, category: "Horror"),
        Book(title: "아픈 건 싫으니까 방어력에 올인하려고 합니다", price: 200, image: .방어력만, category: "Romance"),
        Book(title: "베르세르크", price: 260, image: .베르세르크, category: "Horror"),
        Book(title: "무적코털 보보보", price: 300, image: .보보보, category: "Romance"),
        Book(title: "스파이 패밀리", price: 160, image: .스파이패밀리, category: "Romance"),
        Book(title: "에반 게리온", price: 300, image: .에반게리온, category: "Horror"),
        Book(title: "원펀맨", price: 350, image: .원펀맨, category: "Action"),
        Book(title: "전생했더니 슬라임이었던 건에 대하여", price: 370, image: .전생슬라임, category: "Action"),
        Book(title: "죠죠의 기묘한 모험", price: 220, image: .죠죠, category: "Horror"),
        Book(title: "최애의 아이", price: 290, image: .최애, category: "Romance"),
        Book(title: "클레이 모어", price: 300, image: .클레이모어, category: "Horror"),
        Book(title: "혈계전선", price: 350, image: .혈계전선, category: "Action"),
        Book(title: "호리미야", price: 370, image: .호리미야, category: "Romance"),
        Book(title: "카이지", price: 190, image: .카이지, category: "Horror"),
    ]
    
    var filteredBooks: [Book] = []
    
    func setFilteredBooks(_ category: Int) {
        switch category {
        case 0: filteredBooks = list
        
        case 1: filteredBooks = list.filter{ $0.category == "Action" }
         
        case 2: filteredBooks = list.filter{$0.category == "Romance"}
           
        case 3: filteredBooks = list.filter{$0.category == "Horror"}
           
        default: break
           
        }
    }
    
    func getFilteredBooks() -> [Book] {
        return filteredBooks
    }
    
    func getFilteredBooksCount() -> Int {
        return filteredBooks.count
    }
    
    private init() {} // Singleton 패턴을 위한 private initializer
}


