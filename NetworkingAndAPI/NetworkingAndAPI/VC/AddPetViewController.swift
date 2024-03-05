//
//  AddPetViewController.swift
//  NetworkingAndAPI
//
//  Created by Fawaz Alzamel on 05/03/2024.
//

import Foundation
import SnapKit
import Alamofire
import Kingfisher
import Eureka
import UIKit


class AddPetViewController : FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setupForm()

        
        title = "Add Pet"
    }
    
    private func setupForm() {
        form +++ Section("Add New Pet")
        <<< TextRow() { row in
            row.title = "Pet Name"
            row.placeholder = "Enter Pet Name"
            row.tag = "name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        
        
        <<< IntRow() { row in
            row.title = "Pet Age"
            row.placeholder = "Enter Pet Age"
            row.tag = "age"  
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        <<< URLRow() { row in
            row.title = "Pet Picture"
            row.placeholder = "Enter Pet Picture"
            row.tag = "ImageURL"  
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        <<< TextRow() { row in
            row.title = "Pet Gender"
            row.placeholder = "Enter Pet Gender"
            row.tag = "gender" 
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
    
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitTapped))
    }
    
    @objc func submitTapped() {
           
        
        let errors = form.validate()
                guard errors.isEmpty else {
                    presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
                    return
                }
                let nameRow: TextRow? = form.rowBy(tag: "name")
                let ageRow: IntRow? = form.rowBy(tag: "age")
                let imageUrlRow: URLRow? = form.rowBy(tag: "ImageURL")
                let genderRow: TextRow? = form.rowBy(tag: "gender")
        
                let name = nameRow?.value ?? ""
                let age = ageRow?.value ?? 0
                let imageUrl = imageUrlRow?.value?.absoluteString ?? ""
                let gender = genderRow?.value ?? ""

                    
                let pet = Pet(id: nil, name: name, adopted: true, image: imageUrl, age: age, gender: gender)
                    print(pet)
              // Call addBook to add the book, backend will handle assigning an ID
              NetworkManager.shared.addPet(pet: pet) { success in
                  DispatchQueue.main.async {
                      if success {
                          // Dismiss the form upon successful submission
                          self.dismiss(animated: true, completion: nil)
                      } else {
                          // Handle submission error, e.g., show an error alert
                      }
                  }
              }
          }
    
    private func presentAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
}
