//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 30/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController (_ viewController: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    
    @IBOutlet var seasonListTableView: UITableView!
    
    enum Constants {
        static let seasonKey: String = "SeasonKey"
        static let lastSeasonKey = "LastSeasonKey"
    }
    
    private let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: Inicialización
    init(model: [Season]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Temporadas"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let season = model[indexPath.row]
        
        // Creamos la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        
        // Sincronizamos el modelo con la vista
        cell.textLabel?.text = season.name
        
        return cell // Se devuelve la celda
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        // Se notifica al delegado que se ha pulsado una temporada, indicada en season
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        let notificationCenter = NotificationCenter.default
        let dictionary = [Constants.seasonKey: season]
        
        let notification = Notification(
            name: .seasonDidNotificationName,
            object: self,
            userInfo: dictionary)
        notificationCenter.post(notification)
        
       saveLastSelectedSeason(at: indexPath.row)
        }
    
}

extension SeasonListViewController {
    private func saveLastSelectedSeason(at index: Int) {
        // Escribimos en UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastSeasonKey)
        userDefaults.synchronize() // Por si acaso
    }
    
    func lastSelectedSeason() -> Season {
        // Leer de User Defaults
        let userDefaults = UserDefaults.standard
        let lastIndex = userDefaults.integer(forKey: Constants.lastSeasonKey) // 0 is the default
        
        // Devolvemos la season
        return model[lastIndex]
    }
}
