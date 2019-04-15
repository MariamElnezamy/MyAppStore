//
//  AddItemViewController.swift
//  AppStore
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 mariamelnezamy. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController ,UIPickerViewDelegate ,UIPickerViewDataSource ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    
    
    var EditOrDeleteItem :Items?
    
//    func  LoadForEdit() {
//        if let item = EditOrDeleteItem {
//            nameTF.text = item.item_name
//            ImgView.image = item.image as? UIImage
//
//            if let store = item.toStore {
//                var index = 0
//                while index<listStoreType.count{
//                    let row = listStoreType[index]
//                    if row.name == store.name{
//                        PickerView.selectRow(index, inComponent: 0, animated: false)
//                    }
//                    index=index+1
//                }
//            }
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if EditOrDeleteItem != nil {
//            LoadForEdit()
//        }
        
        PickerView.delegate=self
        PickerView.dataSource=self
        loadStore()
        
        ImagePicker=UIImagePickerController()
        ImagePicker.delegate=self
        
     
    }
    

    
    var listStoreType = [StoreType]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listStoreType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = listStoreType[row]
        return store.name
    }
    

 
    
    func loadStore(){
        let fetchRequest :NSFetchRequest<StoreType> = StoreType.fetchRequest()
        do{
            listStoreType=try context.fetch(fetchRequest)
        }catch{
        }
    }

    
  
    
    @IBOutlet var nameTF: UITextField!
    @IBAction func saveBtn(_ sender: Any) {
        
        let newItem:Items!
        if EditOrDeleteItem == nil {
          newItem = Items(context: context)
        }else{
            newItem = EditOrDeleteItem
        }
        newItem.data_add = NSDate() as Date
        newItem.image = ImgView.image
        newItem.item_name = nameTF.text
        newItem.toStore = listStoreType[PickerView.selectedRow(inComponent: 0)]
        do{
            ad.saveContext()
            nameTF.text = ""
            ImgView.image = UIImage(named: "iconfinder_download_1608668")
            
            print("saved")
        }catch{
            print("erorr")

        }
        
    }
    
    // implement img picker
    
    var ImagePicker :UIImagePickerController!
    @IBOutlet var ImgView: UIImageView!

    @IBAction func btnPickerImg(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImgView.image = img
        }
        ImagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var PickerView: UIPickerView!
    
//    @IBAction func DeleteBtn(_ sender: Any) {
//        
//        if EditOrDeleteItem != nil {
//            context.delete(EditOrDeleteItem!)
//            ad.saveContext()
//            _ = navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
//        }
//    }
    
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
