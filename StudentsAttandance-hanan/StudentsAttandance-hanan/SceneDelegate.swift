//
//  SceneDelegate.swift
//  StudentsAttandance-hanan
//
//  Created by  HANAN ASIRI on 28/03/1443 AH.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarControllerDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

            guard let windowScene = (scene as? UIWindowScene) else { return }
            window?.windowScene = windowScene
            window?.makeKeyAndVisible()
            let tabBar = UITabBarController()
            let profile = UINavigationController(rootViewController: DaysVC())
            profile.tabBarItem.title = "Days"
            profile.tabBarItem.image = UIImage(systemName: "calendar.day.timeline.leading")!
        
            let home = UINavigationController(rootViewController:StudentsVC())
            home.tabBarItem.title = "Students"
            home.tabBarItem.image = UIImage(systemName: "person.3")!
        
                        tabBar.delegate = self
                        tabBar.viewControllers = [home,profile]
                        tabBar.selectedIndex = 0
                        tabBar.tabBar.tintColor = .blue
                        tabBar.tabBar.backgroundColor = .white
                        tabBar.tabBar.layer.shadowColor = UIColor.black.cgColor
                        tabBar.tabBar.layer.shadowOpacity = 0.3
                        tabBar.tabBar.layer.shadowOffset = .zero
                        tabBar.tabBar.layer.shadowRadius = 1
                        window?.windowScene = windowScene
                        window?.makeKeyAndVisible()
                        window?.rootViewController = tabBar

                      }
        }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

