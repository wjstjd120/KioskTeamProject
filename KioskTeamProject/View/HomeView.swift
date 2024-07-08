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
    
    private var logoImage = {
        let x = UIImageView()
        x.image = UIImage(named: "logoImage")
        x.contentMode = .scaleAspectFit
        return x
    }() //로고이미지 변수생성
    let segmentControl = {
        let item = ["모든 카테고리", "액션", "로맨스", "공포"]
        let segmentControl = UISegmentedControl(items: item)
        segmentControl.selectedSegmentIndex = 0
//        segmentControl.backgroundColor = UIColor(hexCode: "A4BB94", alpha: 0.2)
        segmentControl.selectedSegmentTintColor = UIColor(hexCode: "D98C59", alpha: 1.0)


        let normalFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "HancomMalangMalang-Regular", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]

        let selectedFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HancomMalangMalang-Bold", size: UIFont.systemFontSize) ?? UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]

        segmentControl.setTitleTextAttributes(normalFontAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedFontAttributes, for: .selected)

        return segmentControl
    }() //세그먼트 변수생성
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }() // 컨텐츠 담는 컬렉션 뷰
    let basketContainer = {
        var view = UIView()
        view.backgroundColor = UIColor(hexCode: "F09C64")
        view.layer.cornerRadius = 10
        return view
    }() // 테이블뷰 감싸는 컨테이너뷰생성
    let itemsCount = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "HancomMalangMalang-Bold", size: 16)

        return label
    }() // 장바구니 총 갯수
    let totalPrice = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont(name: "HancomMalangMalang-Bold", size: 18)

        return label
    }() // 장바구니 상품 총금액
    var basketView = {
        var x = UITableView()
        x.layer.cornerRadius = 10
        return x
    }()  // 테이블 뷰의 UITableView 변수 생성
    
// 변수 생성

    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9058823529, blue: 0.6980392157, alpha: 1)
        self.backgroundColor = UIColor(hexCode: "FFDE95")
        setupBasketContainer()
//        reloadBasketContainer()
        setupLogo()
        setupSegment()
        setupBasketView()
        setupCollectionDataSource()
//        setupBtns()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
// 레이아웃 지정 및 값 설정
    private func setupLogo() {
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.top.equalTo(self).offset(60)
            $0.centerX.equalTo(self)
        }
    }
    private func setupSegment() {
        
        self.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints{
            $0.height.equalTo(38)
            $0.top.equalTo(logoImage.snp.bottom).offset(15)
            $0.trailing.equalTo(self).offset(-5)
            $0.leading.equalTo(self).offset(5)
        }
        segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    private func setupCollectionDataSource() {
        collectionView.backgroundColor = .clear

        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalTo(basketContainer.snp.top).offset(-10)
        }
    } // 컬렉션 뷰 세팅 메서드
    // 테이블뷰
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
    private func setupBasketView() { // 테이블뷰의 레이아웃
        self.addSubview(basketView)

        basketView.snp.makeConstraints {
            $0.bottom.equalTo(basketContainer.snp.bottom).offset(-8)
            $0.top.equalTo(basketContainer.snp.top).offset(40)
            $0.leading.equalTo(basketContainer).offset(8)
            $0.trailing.equalTo(basketContainer).offset(-8)
        }
    }
    private func setupTableView() {
        setupBasketView()
        self.addSubview(basketView)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl){
        BookInit.shared.setFilteredBooks(sender.selectedSegmentIndex)
        delegate?.segmentChanged(sender)
    }
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
