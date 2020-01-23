//
//  GameCollectionViewCell.swift
//  MyGames
//
//  Created by aluno on 22/01/20.
//  Copyright © 2020 School. All rights reserved.
//

import UIKit

struct GameCollectionViewCellModel {
    var title: String?
    var description: String?
    var imageName: String?
    
    init(title: String, description: String, imageName: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
    }
}

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var titleGameText: UILabel!
    
    @IBOutlet weak var descriptionGameText: UILabel!
    
    var model: GameCollectionViewCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(model: GameCollectionViewCellModel) {
        self.model = model
        titleGameText.text = model.title
        descriptionGameText.text = model.description
        
        if let imageName = model.imageName {
            gameImageView.image = UIImage(named: imageName)
        }
    }

}
