//
//  TableViewCell.swift
//  AppStore
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 mariamelnezamy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var StoreName: UILabel!
    @IBOutlet var DateAdd: UILabel!
    @IBOutlet var Img: UIImageView!
    @IBOutlet var ItemName: UILabel!
    func setMyCell(item:Items) {

        StoreName.text = item.item_name
        Img.image = item.image as! UIImage
        ItemName.text = item.toStore?.name
        // convert data to string
        let dataformat = DateFormatter()
        dataformat.dateFormat = "MM/DD/yy   h:mm a"
        DateAdd.text = dataformat.string(from: item.data_add!)
    }
    
}
