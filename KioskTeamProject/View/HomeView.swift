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
//        segmentControl.backgroundColor = UIColor(hexCode: "A4BB94", alpha: 0.2)
        segmentControl.selectedSegmentTintColor = UIColor(hexCode: "D98C59", alpha: 1.0)

        //selectedFont bold체, normalFont 시스템체
        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let selectedFontAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)]

        segmentControl.setTitleTextAttributes(normalFontAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedFontAttributes, for: .selected)

        BookInit.shared.setFilteredBooks(0)

        return segmentControl
    }()
    
    let basketContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hexCode: "D98C59")
        view.layer.cornerRadius = 10
        return view
    }()

    private var logoImageView: UIImageView!
    private var buttonView: ButtonView!
    
    let itemsCount = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let totalPrice = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9058823529, blue: 0.6980392157, alpha: 1)
        self.backgroundColor = UIColor(hexCode: "FFDE95")
        setupBasketContainer()
        reloadBasketContainer()
        makeLogoImage()
        createSegment()
        setupBasketView()
        setupCollectionDataSource()
        buttonView = ButtonView(containerView: self)
        buttonView.tableDelegate = self
        setupBtns()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func makeLogoImage() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logoImage")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.top.equalTo(self).offset(60)
            $0.centerX.equalTo(self)
        }
    }
    
    private func setupBasketContainer() {
        self.addSubview(basketContainer)
        
        [itemsCount, totalPrice].forEach {
            basketContainer.addSubview($0)
        }
        
        itemsCount.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(10)
        }
        
        totalPrice.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(10)
        }
        
        basketContainer.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-55)
            $0.height.equalTo(230)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        basketContainer.addSubview(basketView)
        
        basketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


    private func createSegment() {
        guard let logoImageView = self.logoImageView else { return }
        
        self.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints{
            $0.height.equalTo(38)
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.trailing.equalTo(self).offset(-5)
            $0.leading.equalTo(self).offset(5)
        }
        segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    
    var basketView = {
        var s = UITableView()
        s.layer.cornerRadius = 10
        return s
    }()  // 테이블 뷰의 UITableView 변수 생성
    

    private func setupBasketView() { // 테이블뷰의 레이아웃
        self.addSubview(basketView)

        basketView.snp.makeConstraints {
            $0.bottom.equalTo(basketContainer.snp.bottom).offset(-8)
            $0.top.equalTo(basketContainer.snp.top).offset(40)
            $0.leading.equalTo(basketContainer).offset(8)
            $0.trailing.equalTo(basketContainer).offset(-8)
        }
        setupTableDataSource()
    }

    private func setupTableView() {
        setupBasketView()
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
        collectionView.backgroundColor = .clear

        // 셀 identifier
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "contentsCell")

        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalTo(basketContainer.snp.top).offset(-10)
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

    // 책 클릭 이벤트 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = BookInit.shared.filteredBooks[indexPath.item]
        // 장바구니에 추가하는 로직 호출
        BasketInit.shared.addBasket(Basket(amount: 1, book: selectedBook))
        reloadBasketContainer()
        basketView.reloadData()
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl){
        BookInit.shared.setFilteredBooks(sender.selectedSegmentIndex)
        collectionView.reloadData()
    }
}

extension HomeView: TableViewReloadDelegate {
    func reloadTableView() {
        basketView.reloadData()
    }
    
    func reloadBasketContainer() {
        itemsCount.text = "총 \(BasketInit.shared.getBasketsCount())개"
        totalPrice.text = "합계: \(BasketInit.shared.getBasketsTotalPrice())원"
    }
}

protocol TableViewReloadDelegate: AnyObject {
    func reloadTableView()
    func reloadBasketContainer()
}

extension UIColor {

    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
