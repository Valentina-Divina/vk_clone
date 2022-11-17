//
//  GroupListTVC.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit
import RealmSwift

class GroupListController: UITableViewController {
    
    private let session = SessionSingleton.shared // ссылаемся на синглтон
    private let service = Service.shared
    private let groupRepository = GroupRepository.shared
    private var cacheHandler: ImageCaсheHandler? = nil
    private let realm = try! Realm()
    private var token: NotificationToken? = nil
    var groups: Results<GroupCollection>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cacheHandler = ImageCaсheHandler(container: tableView)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        getGroups()
    }
    
    // MARK: -  SearchBar
    private var filteredGroups = [GroupCollection]()
    private let searchController = UISearchController(searchResultsController: nil) // экземпляр класса SearchController
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - notification
    private func getGroups() {
        // нотификация
        groups = groupRepository.getGroupData()
        token = groups!.observe{ (changes: RealmCollectionChange) in
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
    
    // MARK: - Table
    
    override func numberOfSections(in tableView: UITableView) -> Int { // количество секций
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // количество строк в секции
        if isFiltering {
            return filteredGroups.count
        } else {
            return groups?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // создание ячейки
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCellID", for: indexPath) as? GroupCell else {
            preconditionFailure("Error")
        }
        var group: GroupCollection?
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups?[indexPath.row]
        }
        
        cell.lableGroupCell.text = group?.name
        cell.imageGroupCell.layer.cornerRadius = 40
        
        // берем фотки из кеша
        if let url = group?.imageUrl {
            cell.imageGroupCell.image = cacheHandler?.photo(atIndexpath: indexPath, byUrl: url)
        }
            
        return cell
    }
    
    @IBAction func addSelectGroups(segue: UIStoryboardSegue) {
        if let selected = segue.source as? OtherGroupsController,
           let indexPath = selected.tableView.indexPathForSelectedRow {
            
            let newGroup = selected.otherGroups[indexPath.row]
            if !(groups?.contains(where: {$0.name == newGroup.name}) ?? false) {
                groupRepository.addGroup(GroupCollection(name: newGroup.name, imageUrl: nil, id: 1))
            }
        }
    }
    
    // удаляем
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == GroupCell.EditingStyle.delete {
            if let groupToDelete = groups?[indexPath.row] {
                groupRepository.removeGroup(groupToDelete)
            }
        }
    }
}

extension GroupListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchController.searchBar.text!)
    }
    
    private func filterForSearchText(_ searchText: String) { // заполняем массив отфильтрованными данными
        filteredGroups = groups?.filter({ (group: GroupCollection ) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        tableView.reloadData()
    }
}
