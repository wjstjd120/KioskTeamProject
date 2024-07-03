//
//  MainView.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import SnapKit

class HomeView: UIView {
    // 안녕하세요
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "전성진"
        label.textAlignment = .center
        return label
    }()
    private var button: Button!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        CreateSegment()
        shoppingView()

        button = Button(containerView: self)
        setupBtns()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func CreateSegment() {
        
        let item = ["모든 카테고리", "액션", "로맨스", "공포"]
        let segmentControl =  UISegmentedControl(items: item)
        
        segmentControl.selectedSegmentIndex = 3
        
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .gray
        
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        self.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints{
            
            $0.height.equalTo(30)
            $0.top.equalTo(self).offset(110)
            $0.trailing.equalTo(self).offset(-9)
            $0.leading.equalTo(self).offset(9)
            
            
        }
        
    }
    var basketView = UITableView() // 테이블 뷰의 UITableView 변수 생성
    
    private func shoppingView() { // 테이블뷰의 레이아웃
        self.addSubview(basketView)
        
        basketView.snp.makeConstraints{
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-100) // 하단으로부터 100만큼 띄어서 오토레이아웃 설정
            $0.height.equalTo(200) // 높이 400으로 설정
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        setupTableDataSource()
    }
    private func setupTableView() {
        shoppingView()
        self.addSubview(basketView)
    }
    private func setupTableDataSource() {
        basketView.register(customCellView.self, forCellReuseIdentifier: customCellView.customCelld)
        basketView.dataSource = self
        basketView.delegate = self
    }
    internal func setupBtns() {
        button.makeButtons()  // Button의 버튼들을 생성하고 설정하는 메서드 호출
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate { //UITableViewDataSource 셀에서 어떻게 보여줄지 나타내는 프로토콜
    //UITableViewDelegate는 셀이 눌렸을때 이벤트를 실행하므로 제거
    //func tableView(tableView:, numberOfRowsInSection ) -> 셀을 보여줄 갯수를 정하는 곳
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    //func tableView(tableView:,cellForRowAt) 셀을 어떻게 보여줄지 정하는 곳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellView.customCelld, for: indexPath) as! customCellView
        cell.custonlayout()
        return cell
    }
}

