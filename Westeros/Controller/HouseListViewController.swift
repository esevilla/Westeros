//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 18/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate: class {
    // should
    // will
    // did
    func houseListViewController(
        _ viewController: HouseListViewController,
        didSelectHouse house: House
    )
}


class HouseListViewController: UITableViewController {
    
    enum Constants {
        static let houseKey: String = "HouseKey"
        static let lastHouseKey = "LastHouseKey"
    }

    // MARK: Properties
    private let model: [House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Casas"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    // Data source provee de datos
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        // Descubrir cuál es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar modelo(house)-vista(celda)
        cell.textLabel?.text = house.name
        cell.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa se ha pulsado
        let house = model[indexPath.row]
        
        // Avisar al delegado.
        // Enviamos la información de que se ha seleccionado una casa
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Mandamos la misma información a través de las notificacions
        let notificationCenter = NotificationCenter.default
        
        let dictionary = [Constants.houseKey: house]
        
        let notification = Notification(
            name: .houseDidNotificationName,
            object: self,
            userInfo: dictionary
        )
        
        notificationCenter.post(notification)
        
        // Guardar la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    
    private func saveLastSelectedHouse(at index: Int) {
        // Escribimos en UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastHouseKey)
        userDefaults.synchronize() // Por si acaso
    }
    
    func lastSelectedHouse() -> House {
        // Leer de User Defaults
        let userDefaults = UserDefaults.standard
        let lastIndex = userDefaults.integer(forKey: Constants.lastHouseKey) // 0 is the default
        
        // Devolvemos la casa
        return model[lastIndex]
    }
}
