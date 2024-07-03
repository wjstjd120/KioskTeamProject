//
//  ViewController.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    override func loadView() {
        self.view = HomeView()

        let homeView = HomeView()
                view.addSubview(homeView)
        homeView.setupBtns()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}

