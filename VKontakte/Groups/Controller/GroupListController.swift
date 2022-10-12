//
//  GroupListTVC.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit
import RealmSwift

class GroupListController: UITableViewController {
    
    let session = SessionSingleton.shared // ссылаемся на синглтон
    let service = Service.shared
    let groupRepository = GroupRepository.shared
    let realm = try! Realm()
    
    var groups = [GroupCollection]()  {
        didSet {
            update()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        update()
        groupRepository.getGroupData(completion: {groupes in
            self.groups = groupes
        })
    }
    
    // MARK: -  SearchBar
    private var filteredGroups = [GroupCollection]()
    private let searchController = UISearchController(searchResultsController: nil) // экземпляр класса SearchController
    var dictionarySectionToGroup = [String: [GroupCollection]]()
    var groupTitles = [String]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private func update() {
        for group in groups {
            let groupKey = String(group.name.prefix(1))
            if var groupValues = dictionarySectionToGroup[groupKey] {
                groupValues.append(group)
                dictionarySectionToGroup[groupKey] = groupValues
            } else {
                dictionarySectionToGroup[groupKey] = [group]
            }
        }
        groupTitles = [String](dictionarySectionToGroup.keys)
        groupTitles = groupTitles.sorted()
    }    

    // MARK: - Table
    
    override func numberOfSections(in tableView: UITableView) -> Int { // количество секций
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // количество строк в секции
        if isFiltering {
            return filteredGroups.count
        }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // создание ячейки
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCellID", // ячейку можно переиспользовать
                                                       for: indexPath) as? GroupCell else {
            preconditionFailure("Error")
        }
        
        var group: GroupCollection
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
        
        cell.lableGroupCell.text = group.name
        cell.imageGroupCell.layer.cornerRadius = 40
        cell.imageGroupCell.load(url: group.imageUrl)
        
        return cell
    }
    
    
    @IBAction func addSelectGroups(segue: UIStoryboardSegue) {
        if let selected = segue.source as? OtherGroupsController,
           let indexPath = selected.tableView.indexPathForSelectedRow {
            
            let newGroup = selected.otherGroups[indexPath.row]
            if !groups.contains(where: {$0.name == newGroup.name}) {
                groups.append(GroupCollection(name: newGroup.name, imageUrl: nil, id: 1))
            }
            tableView.reloadData()
        }
    }
    
    // удаляем
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == GroupCell.EditingStyle.delete {
            groups.remove (at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic) } }
}

extension GroupListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchController.searchBar.text!)
    }
    
    private func filterForSearchText(_ searchText: String) { // заполняем массив отфильтрованными данными
        filteredGroups = groups.filter({ (group: GroupCollection ) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
