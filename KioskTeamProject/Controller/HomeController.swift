//
//  ViewController.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//
import UIKit
import SnapKit

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // 책 데이터 소스 배열
    let books = BooksData.shared.books

    // 장바구니 배열
    var cart: [Book] = []

    // 컬렉션 뷰 생성
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 컬렉션 뷰를 뷰에 추가하고 레이아웃 설정
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // 컬렉션 뷰 데이터 소스 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count // 셀의 개수를 책 데이터의 개수로 설정
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCollectionViewCell

        // 셀에 책 데이터 설정
        let book = books[indexPath.item]
        cell.imageView.image = UIImage(named: book.imageName)
        cell.titleLabel.text = book.title
        cell.priceLabel.text = book.price

        return cell
    }

    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - (padding * 3)
        let width = availableWidth / 4
        return CGSize(width: width, height: width * 1.7) // 책 모양의 크기와 텍스트 공간 추가
    }

    // 책 클릭 이벤트 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.item]
        // 장바구니에 추가하는 로직 호출
        addToCart(book: selectedBook)
    }

    // 장바구니에 책을 추가하는 메서드
    func addToCart(book: Book) {
        cart.append(book)
        print("\(book.title) added to cart")

        // 장바구니 업데이트 알림을 보냄
        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil, userInfo: ["book": book])
    }
}

// 컬렉션 뷰 셀 클래스
class MyCollectionViewCell: UICollectionViewCell {
    // 이미지 뷰 생성
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // 책 이름 레이블 생성
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // 가격 레이블 생성
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 이미지 뷰와 레이블을 셀에 추가하고 레이아웃 설정
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        // 레이블 간의 간격을 설정합니다.
        let labelHeight: CGFloat = 20
        let labelSpacing: CGFloat = 5

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.2)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(labelSpacing)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(labelHeight)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(labelSpacing)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(labelHeight)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
