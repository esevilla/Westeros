//
//  AppDelegate.swift
//  Westeros
//
//  Created by Estefania Sevilla on 11/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

// should - will - did
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var houseListNavigation: UINavigationController?
    var houseDetailListNavigation: UINavigationController?
    var seasonListNavigation: UINavigationController?
    var episodeListNavigation: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Lanzar la app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Crear el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Creamos los controladores master
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        // Persistencia
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        
        // Creamos los controladores detail
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        let episodeListViewController = EpisodeListViewController(model: seasons[0].sortedEpisodes, seasonName: seasons[0].name)
        
        // Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = episodeListViewController
        
        // Los envolvemos en Navigations
        houseListNavigation = houseListViewController.wrappedInNavigation()
        houseDetailListNavigation = houseDetailViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        episodeListNavigation = episodeListViewController.wrappedInNavigation()
        
        // Creamos el Tab bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListNavigation!, seasonListNavigation!]
        tabBarController.delegate = self
 //       tabBarController.viewControllers[seasonListViewController.wrappedInNavigation(), houseListViewController.wrappedInNavigation()]
        
        // Creamos el split view controller
        let splitViewController = UISplitViewController()
        
        splitViewController.viewControllers = [
            tabBarController, // master
            houseDetailListNavigation!// detail
        ]
        
        // Asignamos el rootViewController
        window?.rootViewController = splitViewController
        
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
            case houseListNavigation:
                tabBarController.splitViewController?.viewControllers[1] = houseDetailListNavigation!
            case seasonListNavigation:
                tabBarController.splitViewController?.viewControllers[1] = episodeListNavigation!
        default:
            tabBarController.splitViewController?.viewControllers[1] = houseDetailListNavigation!
        }
    }
}
