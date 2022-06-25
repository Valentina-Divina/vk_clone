//
//  GroupListTVC.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit

class GroupListController: UITableViewController {
    
    var groups = [
        GroupCollection(name: "Молоко+", image: UIImage(named: "cow")), // image: UIImage(named: "cow")),
        GroupCollection(name: "Karelia aesthetic", image: UIImage(named: "karelia")),
        GroupCollection(name: "Средневековая таверна", image: UIImage(named: "tavern")),
        GroupCollection(name: "Книга Средиземья", image: UIImage(named: "tolkin")),
        GroupCollection(name: "Папка с папками", image: UIImage(named: "folder")),
        GroupCollection(name: "Прерафаэлиты", image: UIImage(named: "preraf")),
        GroupCollection(name: "EVIL SPACE", image: UIImage(named: "space")),
        GroupCollection(name: "Мемы", image: UIImage(named: "memes")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { // количество секций
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // количество строк в секции
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // создание ячейки
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCellID", // ячейку можно переиспользовать
                                                    for: indexPath) as? GroupCell else {
            preconditionFailure("Error")
        }
        
        cell.lableGroupCell.text = groups[indexPath.row].name
        cell.imageGroupCell.layer.cornerRadius = 40
        cell.imageGroupCell.image = groups[indexPath.row ].image
        
        return cell
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "showOtherGroups",
     let destinationVC = segue.destination as? OtherGroupsController {
     destinationVC.joinedGroupsLink = groups
     }
     
     }
     */
    
    @IBAction func addSelectGroups(segue: UIStoryboardSegue) {
        if let selected = segue.source as? OtherGroupsController,
           let indexPath = selected.tableView.indexPathForSelectedRow {
            
            let newGroup = selected.otherGroups[indexPath.row]
            if !groups.contains(where: {$0.name == newGroup.name}) {
                groups.append(GroupCollection(name: newGroup.name, image: newGroup.image))
            }
            tableView.reloadData()
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // удаляем
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == GroupCell.EditingStyle.delete {
            groups.remove (at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic) } }
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
