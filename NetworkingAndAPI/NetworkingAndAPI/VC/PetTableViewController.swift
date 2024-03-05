//
//  ViewController.swift
//  NetworkingAndAPI
//
//  Created by Fawaz Alzamel on 04/03/2024.
//

import UIKit
import Alamofire

class PetTableViewController: UITableViewController {
    
    var pets: [Pet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchPetsDetails()
        setUpNavigationBar()
        title = "Pets"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookToDelete = pets[indexPath.row]  // Get the book to delete
            NetworkManager.shared.deletePet(bookID: bookToDelete.id) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        // Remove the book from the data source
                        self?.pets.remove(at: indexPath.row)

                        // Delete the table view row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        // Handle the case where the book couldn't be deleted (e.g., show an alert)
                    }
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = PetDetailsViewController()
        
        let selectedPet = pets[indexPath.row]
        detailVC.pets = selectedPet
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    private func setUpNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetsSelected))
    }
    
    @objc private func addPetsSelected() {
            let navigationController = UINavigationController(rootViewController: AddPetViewController())
            present(navigationController, animated: true, completion: nil)
        }
    
    
    
    private func fetchPetsDetails() {
        NetworkManager.shared.fetchPets { fetchPets in
            DispatchQueue.main.async {
                self.pets = fetchPets ?? []
                self.tableView.reloadData()
            }
        }
    }
    }



