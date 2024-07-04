//
//  ViewController.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    var homeView: HomeView!
    
    override func loadView() {
        homeView = HomeView()
        self.view = homeView
        homeView.setupBtns()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        // Do any additional setup after loading the view.
        
    }
}

extension HomeController: HomeViewDelegate {
    func getBook(at index: Int) -> Book {
        return BookInit.shared.list[index]
    }
    
    func getList(category: String) -> [Book] {
        print(category)
        return BookInit.shared.list
    }
    
    func getListCount(category: String) -> Int {
        print(category)
        return BookInit.shared.list.count
    }
}

protocol HomeViewDelegate: AnyObject {
    func getBook(at index: Int) -> Book
    func getListCount(category: String) -> Int
    func getList(category: String) -> [Book]
}
