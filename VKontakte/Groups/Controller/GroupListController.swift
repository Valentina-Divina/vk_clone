//
//  GroupListTVC.swift
//  VKontakte
//
//  Created by Valya on 21.06.2022.
//

import UIKit

class GroupListController: UITableViewController {
    
    let session = SessionSingleton.shared // ссылаемся на синглтон
    let service = Service.shared
    
    private var groups: [GroupCollection] = [
        GroupCollection(name: "Молоко+", image: UIImage(named: "cow")), // image: UIImage(named: "cow")),
        GroupCollection(name: "Karelia aesthetic", image: UIImage(named: "karelia")),
        GroupCollection(name: "Средневековая таверна", image: UIImage(named: "tavern")),
        GroupCollection(name: "Книга Средиземья", image: UIImage(named: "tolkin")),
        GroupCollection(name: "Папка с папками", image: UIImage(named: "folder")),
        GroupCollection(name: "Прерафаэлиты", image: UIImage(named: "preraf")),
        GroupCollection(name: "EVIL SPACE", image: UIImage(named: "space")),
        GroupCollection(name: "Мемы", image: UIImage(named: "memes")),
    ]
    
    private var filteredGroups = [GroupCollection]()
    private let searchController = UISearchController(searchResultsController: nil) // экземпляр класса SearchController
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        service.getGroups()
        service.getGroupsBySearch(query: "Шумерля")
    }
    
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
        cell.imageGroupCell.image = group.image
        
        return cell
    }
    
    
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
