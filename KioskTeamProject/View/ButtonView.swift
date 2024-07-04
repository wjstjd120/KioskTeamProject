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
        deleteButton.backgroundColor = .clear
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = UIColor.white.cgColor

        // 구매 버튼
        let purchaseButton = UIButton(type: .system)
        purchaseButton.setTitle("구매하기", for: .normal)
        purchaseButton.backgroundColor = .white
        purchaseButton.setTitleColor(.black, for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseBtnTapped), for: .touchUpInside)
        purchaseButton.layer.cornerRadius = 20
        purchaseButton.layer.borderWidth = 2
        purchaseButton.layer.borderColor = UIColor.white.cgColor

        containerView.addSubview(deleteButton)
        containerView.addSubview(purchaseButton)

        // 전체 삭제 버튼 제약 조건 설정
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(containerView.snp.bottom).inset(110)
            $0.leading.equalToSuperview().offset(60)
        }

        // 구매하기 버튼 제약 조건 설정
        purchaseButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(containerView.snp.bottom).inset(110)
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
            // 액션 추가
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive) {(action) in
            // 액션 추가
        }

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

        let okAction = UIAlertAction(title: "OK", style: .cancel) {(action) in
            // 액션 추가
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive) {(action) in
            // 액션 추가
        }

        purchaseAlert.addAction(okAction)
        purchaseAlert.addAction(cancelAction)

        viewController.present(purchaseAlert, animated: true, completion: nil)
    }

    func clearBasket() {
        basketData.clearBaskets()
        tableDelegate?.reloadTableView()
        print("장바구니 전체 삭제")
    }
}
