//
//  FriendTableViewController.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit
import RealmSwift

class FriendListController: UITableViewController {
    
    private let session = SessionSingleton.shared // ссылаемся на синглтон
    private let service = Service.shared
    private let userRepository = UserRepository.shared
    private let realm = try! Realm()
    private var token: NotificationToken? = nil
    var friends: Results<MyFriends>? = nil  {  // нотификация
        didSet {
            update()
            tableView.reloadData()
        }
    }
    
    var dictionarySectionToFriends = [String: [MyFriends]]()
    var friendTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        update()
        
        getFriends()
    }
    
    // MARK: - SearchBar
    private var filteredFriends = [MyFriends]() // массив для отфильтрованных
    private var filteredTitles = [String]()
    private let searchController = UISearchController(searchResultsController: nil) // экземпляр класса SearchController
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    // update
    private func update() {
        if let unwrappedFriends = friends {
            for friend in unwrappedFriends {
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
    }
    // MARK: - notification
    private func getFriends() {
        userRepository.getUserData().done(on: .main) { result in
            self.friends = result
            
            if let unwrappedResult = result {
                self.observeFriends(friends: unwrappedResult)
            }
        }
    }
    
    private func observeFriends(friends: Results<MyFriends>) {
        token = friends.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications:  let modifications):
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic )
                self.tableView.endUpdates()
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(isFiltering) {
            return 1
        } else {
            return friendTitles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        } else {
            let friendKey = friendTitles[section]
            if let friendValues = dictionarySectionToFriends[friendKey]{
                return friendValues.count
            }
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCellID", for: indexPath) as? MyFriendsCell else {
            preconditionFailure("Error")
        }
        var friendy: MyFriends?
        if isFiltering {
            friendy = filteredFriends[indexPath.row]
        } else {
            let friendKey = friendTitles[indexPath.section]
            friendy = dictionarySectionToFriends[friendKey]?[indexPath.row]
        }
        
        cell.myFriendsLable.text = friendy?.name
        cell.customImageView.layer.cornerRadius = 40
        cell.customImageView.load(url: URL(string: friendy?.imageUrl ?? ""))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriend",
           let destinationVC = segue.destination as? FriendCollectionController,
           let indexPath = tableView.indexPathForSelectedRow {
            let friendKey = friendTitles[indexPath.section]
            var friend: MyFriends? = nil
            if isFiltering {
                friend = filteredFriends[indexPath.row]
            } else {
                friend = dictionarySectionToFriends[friendKey]?[indexPath.row]
            }
            destinationVC.title = friend?.name
            destinationVC.friend = friend
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return nil
        } else {
            return friendTitles[section]
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendTitles
    }
}

extension FriendListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchController.searchBar.text!)
    }
    
    private func filterForSearchText(_ searchText: String) { // заполняем массив отфильтрованными данными
        filteredFriends = friends?.filter({ (group: MyFriends ) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        tableView.reloadData()
    }
}

