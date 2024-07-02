//
//  TabBarController.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit
class MainTabBarController: UITabBarController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        configureController()
    }
    // MARK: - Helpers
    func configureController() {
        tabBar.backgroundColor = .white
        let home = tabBarView(unselectedImage: UIImage(systemName: "house.fill")!, selectedImage: UIImage(systemName: "house.fill")!, viewController: HomeController())
        let category = tabBarView(unselectedImage: UIImage(systemName: "doc.text.magnifyingglass")!, selectedImage: UIImage(systemName: "doc.text.magnifyingglass")!, viewController: CategoryController())
        viewControllers = [home, category]
    }
    
    func tabBarView(unselectedImage: UIImage, selectedImage: UIImage, viewController: UIViewController) -> UIViewController {
        viewController.tabBarItem.image = unselectedImage
        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}
