//
//  OnBoardingViewController.swift
//  LoginApp
//
//  Created by aluno on 28/12/19.
//  Copyright © 2019 School. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Datasource Variables
    var datasource: [OnboardingCollectionViewCellModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
            
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.isPagingEnabled = true
            
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureApplied))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
    
    }

    @objc func gestureApplied() {
          dismiss(animated: true, completion: nil)
      }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
       }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let row = indexPath.row
        cell.populate(model: datasource[row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

