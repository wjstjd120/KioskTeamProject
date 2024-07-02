//
//  MainView.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import SnapKit

class HomeView: UIView {
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "전성진"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        CreateSegment()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
    private func CreateSegment() {
        let segmentControl = UISegmentedControl()
        let segmentTitles = ["All", "Action", "Romance", "Horror"]
        
        for i in 0..<segmentTitles.count {
            segmentControl.insertSegment(withTitle: segmentTitles[i], at: i, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .systemRed
        
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.green], for: .selected)
        
        self.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints{
            $0.width.equalTo(380)
            $0.height.equalTo(40)
            $0.top.equalToSuperview().offset(110)
            $0.centerX.equalToSuperview()
            
        }
        
    }
}
