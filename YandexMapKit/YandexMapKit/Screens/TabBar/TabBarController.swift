//
//  TabBarController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        
        let addresses = AddressesViewController(style: .grouped)
        let addressesNavVC = UINavigationController(rootViewController: addresses)
        addresses.title = "Мои Адреса"
        addressesNavVC.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(named: "tab_bookmark"),
                                            selectedImage: UIImage(named: "tab_bookmark_filled"))

        let map = MapViewController()
        map.tabBarItem = UITabBarItem(title: nil,
                                          image: UIImage(named: "tab_location"),
                                          selectedImage: UIImage(named: "tab_location_filled"))
        let profile = ProfileViewController()
        let profileNavVC = UINavigationController(rootViewController: profile)
        profile.title = "Профиль"
        profileNavVC.tabBarItem = UITabBarItem(title: nil,
                                          image: UIImage(named: "tab_profile"),
                                          selectedImage: UIImage(named: "tab_profile_filled"))
        
        viewControllers = [addressesNavVC, map, profileNavVC]
    }
}
