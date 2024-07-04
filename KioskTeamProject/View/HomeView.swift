//
//  MainView.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import SnapKit

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
    let segmentControl: UISegmentedControl = {
        let item = ["모든 카테고리", "액션", "로맨스", "공포"]
        let segmentControl = UISegmentedControl(items: item)
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .gray
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        return segmentControl
    }()
    
    var tempBooks: [Book] = BookInit.shared.list
    var filteredBooks: [Book] = []
    
    private var buttonView: ButtonView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filteredBooks = tempBooks
        
        createSegment()
        shoppingView()
        setupCollectionDataSource()
        buttonView = ButtonView(containerView: self)
        buttonView.tableDelegate = self
        setupBtns()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func createSegment() {
        self.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.top.equalTo(self).offset(110)
            $0.trailing.equalTo(self).offset(-9)
            $0.leading.equalTo(self).offset(9)
        }
        segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    var basketView = UITableView() // 테이블 뷰의 UITableView 변수 생성
    
    private func shoppingView() { // 테이블뷰의 레이아웃
        self.addSubview(basketView)
        
        basketView.snp.makeConstraints{
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-100) // 하단으로부터 100만큼 띄어서 오토레이아웃 설정
            $0.height.equalTo(200) // 높이 400으로 설정
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        setupTableDataSource()
    }
    
    private func setupTableView() {
        shoppingView()
        self.addSubview(basketView)
    }
    
    private func setupTableDataSource() {
        basketView.register(TableCell.self, forCellReuseIdentifier: TableCell.customCelld)
        basketView.dataSource = self
        basketView.delegate = self
    }
    
    internal func setupBtns() {
        buttonView.makeButtons()  // Button의 버튼들을 생성하고 설정하는 메서드 호출
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // 컬렉션 뷰 세팅 메서드
    private func setupCollectionDataSource() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 셀 identifier
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "contentsCell")
        
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalTo(basketView.snp.top).offset(0)
        }
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate { //UITableViewDataSource 셀에서 어떻게 보여줄지 나타내는 프로토콜
    //UITableViewDelegate는 셀이 눌렸을때 이벤트를 실행하므로 제거
    //func tableView(tableView:, numberOfRowsInSection ) -> 셀을 보여줄 갯수를 정하는 곳
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketInit.shared.getBaskets().count
    }
    //func tableView(tableView:,cellForRowAt) 셀을 어떻게 보여줄지 정하는 곳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.customCelld, for: indexPath) as! TableCell
        
        cell.tableDelegate = self

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

extension HomeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
    

    @objc func segmentChanged(_ sender: UISegmentedControl){
        BookInit.shared.setFilteredBooks(sender.selectedSegmentIndex)
        collectionView.reloadData()
         
      }

    // 책 클릭 이벤트 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = BookInit.shared.filteredBooks[indexPath.item]
        // 장바구니에 추가하는 로직 호출
        BasketInit.shared.addBasket(Basket(amount: 1, book: selectedBook))
        basketView.reloadData()
    }
}

extension HomeView: TableViewReloadDelegate {
    func reloadTableView() {
        basketView.reloadData()
    }
}

protocol TableViewReloadDelegate: AnyObject {
    func reloadTableView()
}

