//
//  OtherGroupsController.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit

class OtherGroupsController: UITableViewController {
    
    
    let otherGroups = [
        OtherGroups(name: "Тут подкасты", image: UIImage(named: "grafon")),
        OtherGroups(name: "Шумерля", image: UIImage(named: "shumerlya")),
        OtherGroups(name: "Грустный голубь (очень)", image: UIImage(named: "golyb"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OtherGroupsCellID",
                                                       for: indexPath) as? OtherGroupsCell else {
            preconditionFailure("Error")
        }
        cell.imageOtherGroups.layer.cornerRadius = 40
        cell.imageOtherGroups.image = otherGroups[indexPath.row].image
        cell.lableOtherGroups.text = otherGroups[indexPath.row].name
        
        return cell
    }
}
