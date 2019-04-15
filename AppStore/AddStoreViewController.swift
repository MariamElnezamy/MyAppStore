//
//  AddStoreViewController.swift
//  AppStore
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 mariamelnezamy. All rights reserved.
//

import UIKit

class AddStoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBOutlet var storenameTF: UITextField!
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtn(_ sender: Any) {
        let store = StoreType(context: context)
        store.name = storenameTF.text
        do{
            ad.saveContext()
            storenameTF.text = ""
            print("saved")
        }catch{
            print("cannot saved")

        }
    }
}
