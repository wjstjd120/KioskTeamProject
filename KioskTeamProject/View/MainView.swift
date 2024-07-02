//
//  MainView.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit

class MainView: UIView {
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Home!"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
