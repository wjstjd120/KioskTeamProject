//
//  MainView.swift
//  KioskTeamProject
//
//  Created by 이주희 on 7/3/24.
//
import UIKit

class MainView: UIViewController {

    let homeView = HomeView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

    override func viewDidLoad() {
        super.viewDidLoad()

        // HomeView를 MainView의 서브뷰로 추가
        self.view.addSubview(homeView)

        // HomeView의 hostingVC 프로퍼티에 MainView 할당
        homeView.hostingVC = self
    }
}
