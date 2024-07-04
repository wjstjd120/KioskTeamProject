//
//  customCellView.swift
//  Myjang1
//
//  Created by 신상규 on 7/3/24.
//

import UIKit
import SnapKit

class TableCell: UITableViewCell {
    var basket: Basket?
    
    weak var tableDelegate: TableViewReloadDelegate?
    
    static let customCelld =  "custommcelld"
    
    private var numbers: Int = 0
    let plusButton = UIButton()
    let minusButton = UIButton()
    let eliminationButton = UIButton()
    let numberLabel = UILabel()
    let priceLabel = UILabel()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        custonlayout()
    }
    
    func custonlayout() {
        numbers = basket?.amount ?? 0
        
        self.addSubview(plusButton)
        self.addSubview(minusButton)
        self.addSubview(eliminationButton)
        self.addSubview(numberLabel)
        self.addSubview(priceLabel)
        self.addSubview(nameLabel)
        
        //플러스 버튼
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = .red
        plusButton.layer.cornerRadius = 5
        plusButton.addTarget(self, action: #selector(plusButtonTap), for: .touchDown)
        plusButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.right.equalTo(nameLabel.snp.left).offset(230)
        }
        
        //마이너스 버튼
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = .gray
        minusButton.layer.cornerRadius = 5
        minusButton.addTarget(self, action: #selector(minusButtonTap), for: .touchDown)
        minusButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.right.equalTo(nameLabel.snp.left).offset(160)
        }
        
        //삭제버튼
        eliminationButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        eliminationButton.titleLabel?.font = .boldSystemFont(ofSize: 10)
        eliminationButton.setTitleColor(.white, for: .normal)
        eliminationButton.imageView?.tintColor = .black
        eliminationButton.backgroundColor = .clear
        eliminationButton.layer.cornerRadius = 5
        eliminationButton.addTarget(self, action: #selector(eliminationButtonTap), for: .touchDown)
        eliminationButton.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
        
        //갯수 레이블
        numberLabel.text = "\(numbers)"
        numberLabel.textColor = .black
        numberLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        //금액 레이블
        priceLabel.text = "가격 : \(numbers * Int(basket!.book.price))"
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalTo(eliminationButton.snp.right).inset(30)
        }
        
        //이름 받아오는 레이블
        nameLabel.text = "\(basket!.book.title)"
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
    }
    //플러스 버튼 숫자 증가
    @objc private func plusButtonTap(_ sender: UIButton) {
        numberLabel.text = "\(numbers)"
        BasketInit.shared.plusAmount(sender.tag)
        tableDelegate?.reloadTableView()
    }
    //마이너스 버튼 숫자 감소
    @objc private func minusButtonTap(_ sender: UIButton) {
        if numbers == 0 {
            numbers = 0
        }else {
            numberLabel.text = "\(numbers)"
            BasketInit.shared.minusAmount(sender.tag)
            tableDelegate?.reloadTableView()
        }
    }
    //삭제버튼
    @objc private func eliminationButtonTap(_ sender: UIButton) {
        BasketInit.shared.removeBaskes(sender.tag)
        tableDelegate?.reloadTableView()
    }
}
