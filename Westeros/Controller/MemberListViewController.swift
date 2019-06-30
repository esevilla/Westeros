//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 18/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var model: [Person]
    private var houseModelName: String
    
    // MARK: Initialization
    init(model: [Person], houseName: String) {
        self.model = model
        self.houseModelName = houseName
        super.init(nibName: nil, bundle: nil)
        title = "Members \(houseModelName)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // OJO. No olvidarse de asignar el dataSource
        tableView.dataSource = self
        tableView.delegate = self
        subscribe()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        unsubscribe()
    }
}

// MARK: Table view data source
extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        // Descubrir qué persona tengo que mostrar
        let person = model[indexPath.row]
        
        // Crear la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        // sincronizar model-view
        cell.textLabel?.text = person.fullName
        cell.detailTextLabel?.text = person.alias
        
        // Devolver la celda
        return cell 
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let member = model[indexPath.row]
        let memberDetailViewController = MemberDetailViewController(model: member)
        
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}

extension MemberListViewController {
    func syncModelWithView(){
        title = "Members \(houseModelName)"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = false
        tableView.reloadData()
    }
}

extension MemberListViewController {
    private func subscribe() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(houseDidChange),
            name: .houseDidNotificationName,
            object: nil)
    }
    
    private func unsubscribe(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func houseDidChange(notification: Notification){
        guard let dictionary = notification.userInfo
            else { return }
        guard let house = dictionary[HouseListViewController.Constants.houseKey] as? House
            else { return }
        
        model = house.sortedMembers
        houseModelName = house.name
        syncModelWithView()
        
    }
}

