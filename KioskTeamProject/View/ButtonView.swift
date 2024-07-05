//
//  Button.swift
//  KioskTeamProject
//
//  Created by t2023-m0023 on 7/3/24.
//

import UIKit
import SnapKit

class ButtonView {
    weak var tableDelegate: TableViewReloadDelegate?

    var basketData = BasketInit.shared
    let containerView: UIView

    init(containerView: UIView) {
        self.containerView = containerView
    }

    func makeButtons() {
        // 전체 삭제 버튼
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("전체삭제", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "HancomMalangMalang-Bold", size: 17)
        deleteButton.backgroundColor = .clear
        deleteButton.setTitleColor(UIColor(hexCode: "8EB374"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = UIColor(hexCode: "8EB374").cgColor


        // 구매 버튼
        let purchaseButton = UIButton(type: .system)
        purchaseButton.setTitle("구매하기", for: .normal)
        purchaseButton.titleLabel?.font = UIFont(name: "HancomMalangMalang-Bold", size: 17)
        purchaseButton.backgroundColor = UIColor(hexCode: "8EB374")
        purchaseButton.setTitleColor(UIColor(hexCode: "FFDE95"), for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseBtnTapped), for: .touchUpInside)
        purchaseButton.layer.cornerRadius = 20
        
        // 그림자 속성적용
//        btnShadow(to: purchaseButton)

        containerView.addSubview(deleteButton)
        containerView.addSubview(purchaseButton)

        // 전체 삭제 버튼 제약 조건 설정
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(containerView.snp.bottom).inset(70)
            $0.leading.equalToSuperview().offset(60)
        }

        // 구매하기 버튼 제약 조건 설정
        purchaseButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(containerView.snp.bottom).inset(70)
            $0.trailing.equalToSuperview().offset(-60)
        }
    }

    // 전체 삭제 버튼 액션
    @objc func deleteBtnTapped() {
        print("삭제버튼")
        if let containerVC = containerView.next as? UIViewController {
            deleteBtnAlert(title: "경고", message: "장바구니의 모든 항목을 비우시겠습니까?", viewController: containerVC)
        }
    }

    // 전체 삭제 버튼 alert
    func deleteBtnAlert(title: String, message: String, viewController: UIViewController) {
        let deleteAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) {_ in
            self.clearBasket()
        }

        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)

        deleteAlert.addAction(okAction)
        deleteAlert.addAction(cancelAction)

        viewController.present(deleteAlert, animated: true, completion: nil)
    }

    // 구매 하기 버튼 액션
    @objc func purchaseBtnTapped() {
        print("구매버튼")
        if let containerVC = containerView.next as? UIViewController {
            purchaseBtnAlert(title: "구매하기", message: "구매하시겠습니까?", viewController: containerVC)
        }
    }
    // 구매 하기 버튼 alert
    func purchaseBtnAlert(title: String, message: String, viewController: UIViewController) {
        let purchaseAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) {_ in
            let doubleAlert = UIAlertController(title: "확인", message: BasketInit.shared.getBasketsCount() == 0 ? "장바구니 항목이 없습니다." : "구매가 완료 되었습니다.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "확인", style: .destructive) {_ in
                self.clearBasket()
            }
            
            doubleAlert.addAction(confirmAction)
            
            viewController.present(doubleAlert, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
        
        purchaseAlert.addAction(okAction)
        purchaseAlert.addAction(cancelAction)

        viewController.present(purchaseAlert, animated: true, completion: nil)
    }
    
    func clearBasket() {
        basketData.clearBaskets()
        tableDelegate?.reloadBasketContainer()
        tableDelegate?.reloadTableView()
        print("장바구니 전체 삭제")
    }
}
