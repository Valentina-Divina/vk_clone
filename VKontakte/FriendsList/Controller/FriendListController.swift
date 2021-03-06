//
//  FriendTableViewController.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit



class FriendListController: UITableViewController {
    
    
    var dictionarySectionToFriends = [String: [MyFriends]]()
    var friendTitles = [String]()
    
    let friends = [
        MyFriends(name: "Guts Berserk", image: UIImage(named: "guts"), photoGallery: [UIImage(named: "cow")!,UIImage(named: "ilon")!,UIImage(named: "misha")!,UIImage(named: "kolya")!,UIImage(named: "female")!,UIImage(named: "mark")!]),
        MyFriends(name: "Николай Мозгляков", image: UIImage(named: "kolya"), photoGallery: [UIImage(named: "cow")!]),
        MyFriends(name: "Сергей Кочетков", image: UIImage(named: "serg"), photoGallery: [UIImage(named: "cow")!]),
        MyFriends(name: "Анастасия Землепашская", image: UIImage(named: "female"), photoGallery: [UIImage(named: "cow")!]),
        MyFriends(name: "Михаил Изпод-Вылез", image: UIImage(named: "misha"), photoGallery: [UIImage(named: "cow")!]),
        MyFriends(name: "Илон Маск", image: UIImage(named: "ilon"), photoGallery: [UIImage(named: "cow")!]),
        MyFriends(name: "Марк Аврелий", image: UIImage(named: "mark"), photoGallery: [UIImage(named: "cow")!])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(sender:)))
        
        for friend in friends {
            let friendKey = String(friend.name.prefix(1))
            if var friendValues = dictionarySectionToFriends[friendKey] {
                friendValues.append(friend)
                dictionarySectionToFriends[friendKey] = friendValues
            } else {
                dictionarySectionToFriends[friendKey] = [friend]
            }
        }
        friendTitles = [String](dictionarySectionToFriends.keys)
        friendTitles = friendTitles.sorted()
    }
    
  //  @objc private func handleTapGesture(sender: UITapGestureRecognizer ) {
        
 //   }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return friendTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let friendKey = friendTitles[section]
        if let friendValues = dictionarySectionToFriends[friendKey]{
            return friendValues.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCellID", for: indexPath) as? MyFriendsCell else {
            preconditionFailure("Error")
        }
        
        let friendKey = friendTitles[indexPath.section]
        let friend = dictionarySectionToFriends[friendKey]?[indexPath.row]
        
        cell.customImageView.image = friend?.image
        cell.myFriendsLable.text = friend?.name
        
        cell.setup()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriend",
           let destinationVC = segue.destination as? FriendCollectionController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let friendKey = friendTitles[indexPath.section]
            let friend = dictionarySectionToFriends[friendKey]?[indexPath.row]
            
            
            destinationVC.title = friend?.name
            destinationVC.friend = friend
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendTitles
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
    
// }
