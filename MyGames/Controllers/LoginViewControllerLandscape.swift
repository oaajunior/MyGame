//
//  LoginViewControllerLandscape.swift
//  MyGames
//
//  Created by aluno on 13/01/20.
//  Copyright © 2020 School. All rights reserved.
//

import UIKit

class LoginViewControllerLandscape: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var loginImageView: UIImageView!
    
    var onboardingViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadOnboarding(withModels: [
            OnboardingCollectionViewCellModel(title: "The best app ever from login", description: "First app with the new guys", imageName: "pacoquita"),
            OnboardingCollectionViewCellModel(title: "The best app ever from login", description: "First app with the new guys", imageName: "pacoquita")
        ])

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
    
    private func configureNavigationItem() {
        navigationItem.title = "Login"
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        if newCollection.verticalSizeClass == .regular {
            dismiss(animated: true, completion: nil)

            let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            present(viewController, animated: true, completion: nil)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
