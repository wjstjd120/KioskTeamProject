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
    var buttonView: ButtonView!
    
    override func loadView() {
        homeView = HomeView()
        buttonView = ButtonView()
        buttonView.containerView = homeView
        BookInit.shared.setFilteredBooks(0)
        reloadBasketContainer()
        setupCollectionDataSource()
        setupTableDataSource()
        buttonView.makeButtons()
        self.view = homeView
//        homeView.setupBtns()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        buttonView.delegate = self
        // Do any additional setup after loading the view.
    }
}

//extension HomeController: HomeViewDelegate {
//    func getBook(at index: Int) -> Book {
//        return BookInit.shared.list[index]
//    }
//    
//    func getList() -> [Book] {
//        return BookInit.shared.list
//    }
//    
//    func getListCount() -> Int {
//        return BookInit.shared.list.count
//    }
//}
//
//protocol HomeViewDelegate: AnyObject {
//    func getBook(at index: Int) -> Book
//    func getListCount() -> Int
//    func getList() -> [Book]
//}

extension HomeController: HomeViewDelegate {
    func reloadTableView() {
        homeView.basketView.reloadData()
    }
    
    func setupTableDataSource() {
        homeView.basketView.register(TableCell.self, forCellReuseIdentifier: TableCell.customCelld)
        homeView.basketView.dataSource = self
        homeView.basketView.delegate = self
    }
    
    func segmentChanged(_ sender: UISegmentedControl){
        BookInit.shared.setFilteredBooks(sender.selectedSegmentIndex)
        homeView.collectionView.reloadData()
    }
    
    func reloadBasketContainer() {
        homeView.itemsCount.text = "총 \(BasketInit.shared.getBasketsCount())개"
        homeView.totalPrice.text = "합계: \(BasketInit.shared.getBasketsTotalPrice())원"
    }
}

protocol HomeViewDelegate: AnyObject {
    func reloadTableView()
    func reloadBasketContainer()
    func segmentChanged(_ sender: UISegmentedControl)
}

extension HomeController: UITableViewDataSource, UITableViewDelegate { //UITableViewDataSource 셀에서 어떻게 보여줄지 나타내는 프로토콜
    //UITableViewDelegate는 셀이 눌렸을때 이벤트를 실행하므로 제거
    //func tableView(tableView:, numberOfRowsInSection ) -> 셀을 보여줄 갯수를 정하는 곳
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketInit.shared.getBaskets().count
    }
    
    //func tableView(tableView:,cellForRowAt) 셀을 어떻게 보여줄지 정하는 곳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.customCelld, for: indexPath) as! TableCell

        cell.delegate = self
        
        if !BasketInit.shared.getBaskets().isEmpty {
            cell.plusButton.tag = indexPath.item
            cell.minusButton.tag = indexPath.item
            cell.eliminationButton.tag = indexPath.item
            cell.basket = BasketInit.shared.getBaskets()[indexPath.item]
            cell.custonlayout()
        }
        return cell
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BookInit.shared.getFilteredBooksCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentsCell", for: indexPath) as! CollectionCell
        cell.book = BookInit.shared.filteredBooks[indexPath.item]
        cell.configure()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = Int(collectionView.bounds.width / 3) - 10
        let height: Int = 160
        return CGSize(width: width, height: height)
    }

    // 책 클릭 이벤트 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = BookInit.shared.filteredBooks[indexPath.item]
        // 장바구니에 추가하는 로직 호출
        BasketInit.shared.addBasket(Basket(amount: 1, book: selectedBook))
        reloadBasketContainer()
        homeView.basketView.reloadData()
    }
    
    func setupCollectionDataSource() {
        // 셀 identifier
        homeView.collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "contentsCell")
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
}
