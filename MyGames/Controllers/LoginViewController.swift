//
//  LoginViewControllerLandscape.swift
//  MyGames
//
//  Created by aluno on 13/01/20.
//  Copyright © 2020 School. All rights reserved.
//

import UIKit

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}

class LoginViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var loginImageView: UIImageView!
    
    var onboardingViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        if !UIDevice.current.orientation.isLandscape {

        loadOnboarding(withModels: [OnboardingCollectionViewCellModel(title: "O melhor App criado ever", description: "Melhor doce, paçoquita", imageName: "pacoquita"), OnboardingCollectionViewCellModel(title: "O melhor App criado ever", description: "Não adianta, paçoquita é a melhor", imageName: "pacoquita"),
               ])
        }
            //configureButton()
            configureNavigationItem()
    }
    
    private func loadOnboarding(withModels models: [OnboardingCollectionViewCellModel]) {
            
        if let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController() as? OnboardingViewController {
            onboardingViewController = viewController
            viewController.datasource = models
            present(viewController, animated: true, completion: nil)
        }

    }
     
     private func configureLogoImageView(){
         loginImageView.layer.cornerRadius = loginImageView.frame.size.height / 2
         loginImageView.layer.masksToBounds = true
     }
    
    private func configureNavigationItem() {
        navigationItem.title = "Login"
    }
    
    
     override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          //configureLogoImageView()
      }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
           super.willTransition(to: newCollection, with: coordinator)
           
        if newCollection.verticalSizeClass == .compact{
               
            dismiss(animated: true, completion: nil)
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyBoard.instantiateViewController(identifier: "LoginLandscape") as! LoginViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        if newCollection.verticalSizeClass == .regular{

            dismiss(animated: true, completion: nil)
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyBoard.instantiateViewController(identifier: "LoginPortrait") as! LoginViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tbc  = storyboard.instantiateViewController(withIdentifier:"TabBarController") as! UITabBarController
          tbc.selectedIndex = 0
          self.present(tbc, animated: true, completion:nil)
        
    
        
    }
}
