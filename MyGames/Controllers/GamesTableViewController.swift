//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by aluno on 30/11/19.
//  Copyright © 2019 School. All rights reserved.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {

    var fetchedResultController:NSFetchedResultsController<Game>!
    var label = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mensagem default
         label.text = "Você não tem jogos cadastrados"
         label.textAlignment = .center
        
        // altera comportamento default que adicionava background escuro sobre a view principal
         searchController.dimsBackgroundDuringPresentation = false
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.tintColor = .white
         searchController.searchBar.barTintColor = .white
        
         navigationItem.searchController = searchController
        
         // usando extensions
         searchController.searchBar.delegate = self
         searchController.searchResultsUpdater = self
        
        /*
        FIX BUG black screen
         Source: https://stackoverflow.com/questions/38836862/tab-bar-view-goes-blank-when-switched-back-to-with-search-bar-active
         */
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        loadGames()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         // se ocorrer mudancas na entidade Console, a atualização automatica não irá ocorrer porque nosso NSFetchResultsController esta monitorando a entidade Game. Caso tiver mudanças na entidade Console precisamos atualizar a tela com a tabela de alguma forma: reloadData :)
         tableView.reloadData()
    }
    
     // valor default evita precisar ser obrigado a passar o argumento quando chamado
       func loadGames(filtering: String = "") {
           let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
           let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
          
           if !filtering.isEmpty {
               // usando predicate: conjunto de regras para pesquisas
               // contains [c] = search insensitive (nao considera letras identicas)
               let predicate = NSPredicate(format: "title contains [c] %@", filtering)
               fetchRequest.predicate = predicate
           }
          
           // possui
           fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
           fetchedResultController.delegate = self
          
           do {
               try fetchedResultController.performFetch()
           } catch  {
               print(error.localizedDescription)
           }
       }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultController?.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
        
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        
        guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
           return cell
        }
               
        cell.prepare(with: game)
        return cell
    }
    
    // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           if segue.identifier! == "gameSegue" {
               print("gameSegue")
               let vc = segue.destination as! GameViewController
               
               if let games = fetchedResultController.fetchedObjects {
                   vc.game = games[tableView.indexPathForSelectedRow!.row]
               }
               
           } else if segue.identifier! == "newGameSegue" {
               print("newGameSegue")
           }
       }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(game)
           
            do {
                try context.save()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
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

}

extension GamesTableViewController: NSFetchedResultsControllerDelegate {
   
    // sempre que algum objeto for modificado esse metodo sera notificado
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    // Delete the row from the data source
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData()
        }
    }
}

extension GamesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadGames()
        tableView.reloadData()
       
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
