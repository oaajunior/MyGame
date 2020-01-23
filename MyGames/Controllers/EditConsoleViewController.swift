//
//  EditConsoleViewController.swift
//  MyGames
//
//  Created by aluno on 30/11/19.
//  Copyright © 2019 School. All rights reserved.
//

import UIKit
import Photos

class EditConsoleViewController: UIViewController {

    @IBOutlet weak var tfConsole: UITextField!
    @IBOutlet weak var btAdicionarImg: UIButton!
    @IBOutlet weak var btSalvar: UIButton!
    @IBOutlet weak var ivCover: UIImageView!
    
    var console: Console!
    var consolesManager = ConsolesManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loadFotos(_ sender: UIButton) {
        // para adicionar uma imagem da biblioteca
        print("para adicionar uma imagem da biblioteca")
        
        
        let alert = UIAlertController(title: "Selecinar capa", message: "De onde você quer escolher a capa?", preferredStyle: .actionSheet)
        
         let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
             self.selectPicture(sourceType: .photoLibrary)
         })
         alert.addAction(libraryAction)
        
         let photosAction = UIAlertAction(title: "Album de fotos", style: .default, handler: {(action: UIAlertAction) in
             self.selectPicture(sourceType: .savedPhotosAlbum)
         })
         alert.addAction(photosAction)
        
         let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
         alert.addAction(cancelAction)
        
         present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func salvarConsole(_ sender: UIButton) {
        
        //Salvar console
        if console == nil {
            console = Console(context: context)
        }
        console.name = tfConsole.text
        
//        if !tfConsole.text!.isEmpty {
//              let console = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)]
//              console.console = console
//        }
        console.cover = ivCover.image
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        // Back na navigation
        navigationController?.popViewController(animated: true)
        
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
              
               //Photos
               let photos = PHPhotoLibrary.authorizationStatus()
               if photos == .notDetermined {
                   PHPhotoLibrary.requestAuthorization({status in
                       if status == .authorized{
                          
                           self.chooseImageFromLibrary(sourceType: sourceType)
                          
                       } else {
                          
                           print("unauthorized -- TODO message")
                       }
                   })
               } else if photos == .authorized {
                  
                   self.chooseImageFromLibrary(sourceType: sourceType)
               }
           }
    
    func chooseImageFromLibrary(sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.tintColor = UIColor(named: "main")
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
}


extension EditConsoleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // ImageView won't update with new image
            // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.ivCover.image = pickedImage
                self.ivCover.setNeedsDisplay()
                self.btAdicionarImg.setTitle(nil, for: .normal)
                self.btAdicionarImg.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}



