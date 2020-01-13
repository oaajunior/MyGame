//
//  ConsolesTableViewController.swift
//  MyGames
//
//  Created by aluno on 30/11/19.
//  Copyright © 2019 School. All rights reserved.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    
    var consolesManager = ConsolesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadConsoles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         // se ocorrer mudancas na entidade Console, a atualização automatica não irá ocorrer porque nosso NSFetchResultsController esta monitorando a entidade Game. Caso tiver mudanças na entidade Console precisamos atualizar a tela com a tabela de alguma forma: reloadData :)
         loadConsoles()
         //tableView.reloadData()
    }

    
    func loadConsoles(){
        consolesManager.loadConsoles(with: context)
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return consolesManager.consoles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let console = consolesManager.consoles[indexPath.row]
        cell.textLabel?.text = console.name
        return cell
    }
    
//    func showAlert(with console: Console?) {
//        let title = console == nil ? "Adicionar" : "Editar"
//        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
//
//        alert.addTextField(configurationHandler: { (textField) in
//            textField.placeholder = "Nome da plataforma"
//
//            if let name = console?.name {
//                textField.text = name
//            }
//        })
//
//        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
//            let console = console ?? Console(context: self.context)
//            console.name = alert.textFields?.first?.text
//            do {
//                try self.context.save()
//                self.loadConsoles()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//        alert.view.tintColor = UIColor(named: "second")
//
//        present(alert, animated: true, completion: nil)
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let console = consolesManager.consoles[indexPath.row]
         //showAlert(with: console)
        
         // deselecionar atual cell
         tableView.deselectRow(at: indexPath, animated: false)
     }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
         if editingStyle == .delete {
             consolesManager.deleteConsole(index: indexPath.row, context: context)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
//    @IBAction func AddConsole(_ sender: Any) {
//        
//        showAlert(with: nil)
//    }
}
