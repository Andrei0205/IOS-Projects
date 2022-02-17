//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Andrei Marinescu on 21.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    // Create swipable cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }

    // MARK: - SwipeCellKit delegate 

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

                
                self.updateModel(at: indexPath)
            }

            // customize the action appearance
            deleteAction.image = UIImage(systemName: "trash")

            return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
   //     options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath: IndexPath){
        
    }
    
    //MARK: - Edit navigation bar
    
    func updateNavBarColor(_ currentColour: UIColor) {
        
        let navBarAppearance = UINavigationBarAppearance()
        let navBar = navigationController?.navigationBar
        let navItem = navigationController?.navigationItem
        navBarAppearance.configureWithOpaqueBackground()

        
         // Use Chameleon's ContrastColorOf() function to set the colour of the text based on the colour we use. If it is dark, the text is light, and vice versa.
        
        let contrastColour = ContrastColorOf(currentColour, returnFlat: true)

        navBarAppearance.titleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.backgroundColor = currentColour
        navItem?.rightBarButtonItem?.tintColor = contrastColour
        navBar?.tintColor = contrastColour
        navBar?.standardAppearance = navBarAppearance
        navBar?.scrollEdgeAppearance = navBarAppearance

        self.navigationController?.navigationBar.setNeedsLayout()
    }
    
}
