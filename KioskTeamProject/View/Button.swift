//
//  Button.swift
//  KioskTeamProject
//
//  Created by t2023-m0023 on 7/3/24.
//

import UIKit
import SnapKit

class Button {
    let parentView: UIView

    init(parentView: UIView) {
        self.parentView = parentView
    }

    func makeButtons() {
        // 전체 삭제 버튼
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("전체삭제", for: .normal)
        deleteButton.backgroundColor = .systemBlue
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)

        // 구매 버튼
        let purchaseButton = UIButton(type: .system)
        purchaseButton.setTitle("구매하기", for: .normal)
        purchaseButton.backgroundColor = .white
        purchaseButton.setTitleColor(.black, for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseBtnTapped), for: .touchUpInside)

        parentView.addSubview(deleteButton)
        parentView.addSubview(purchaseButton)

        // 전체 삭제 버튼 제약 조건 설정
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.top.equalTo(parentView.snp.bottom).inset(110)
            $0.leading.equalToSuperview().offset(20)
        }

        // 구매하기 버튼 제약 조건 설정
        purchaseButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.top.equalTo(parentView.snp.bottom).inset(110)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }

    @objc func deleteBtnTapped() {
        print("삭제버튼")
        if let parentViewController = parentView.next as? UIViewController {
            makeAlert(title: "전체삭제", message: "장바구니의 모든 항목을 삭제하시겠습니까?", viewController: parentViewController)
        }
    }

    @objc func purchaseBtnTapped() {
        print("구매버튼")
        if let parentViewController = parentView.next as? UIViewController {
            makeAlert(title: "구매하기", message: "구매하시겠습니까?", viewController: parentViewController)
        }
    }

    func makeAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        viewController.present(alert, animated: true, completion: nil)
    }
}
