//
//  customCellView.swift
//  Myjang1
//
//  Created by 신상규 on 7/3/24.
//

import UIKit
import SnapKit

class customCellView: UITableViewCell {
    
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
            $0.right.equalTo(-140)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.top.equalTo(self).offset(9)
        }
        
        //마이너스 버튼
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = .gray
        minusButton.layer.cornerRadius = 5
        minusButton.addTarget(self, action: #selector(minusButtonTap), for: .touchDown)
        minusButton.snp.makeConstraints{
            $0.right.equalTo(-200)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.top.equalTo(self).offset(9)
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
            $0.right.equalTo(0)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.top.equalTo(self).offset(9)
        }
        
        //갯수 레이블
        numberLabel.text = "\(numbers)"
        numberLabel.textColor = .black
        numberLabel.snp.makeConstraints{
            $0.right.equalTo(-178)
            $0.top.equalTo(self).offset(9)
        }
        
        //금액 레이블
        priceLabel.text = "가격 : \(numbers * 300)"
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.snp.makeConstraints{
            $0.right.equalTo(-30)
            $0.width.equalTo(100)
            $0.top.equalTo(self).offset(14)
        }
        
        //이름 받아오는 레이블
        nameLabel.text = " "
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    //플러스 버튼 숫자 증가
    @objc private func plusButtonTap() {
        self.numbers += 1
        numberLabel.text = "\(numbers)"
    }
    //마이너스 버튼 숫자 감소
    @objc private func minusButtonTap() {
        if numbers == 0 {
            numbers = 0
        }else {
            self.numbers -= 1
            numberLabel.text = "\(numbers)"
        }
    }
    //삭제버튼
    @objc private func eliminationButtonTap() {
        
    }
}
