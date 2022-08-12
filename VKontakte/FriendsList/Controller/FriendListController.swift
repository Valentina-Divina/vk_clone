//
//  FriendTableViewController.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit

class FriendListController: UITableViewController {
    
    let session = SessionSingleton.shared // ссылаемся на синглтон
    let service = Service.shared
    
    var friends = [MyFriends]()  {
        didSet {
            update()
            tableView.reloadData()
        }
    }
    
    
    var dictionarySectionToFriends = [String: [MyFriends]]()
    var friendTitles = [String]()
    
    private func update() {
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
        
        print(session.token) // синглтон
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        service.getFriends { result in
            self.friends = result.response.items.map({ user in
                MyFriends(name: user.firstName + " " + user.lastName , imageUrl: URL(string: user.photo), id: user.id)
            })
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return friendTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        cell.customImageView.load(url: friend?.imageUrl)
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
    
 
    
   
