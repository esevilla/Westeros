//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 30/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    
    private var model: [Episode]
    
    // MARK: Inicialización
    init (model: [Episode], seasonName: String) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = seasonName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    // MARK: Data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EpisodeCell"
        let episode = model[indexPath.row]
        
        // Creamos la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sincronizamos el modelo con la vista
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = "Emitido por primera vez en el \(dateFormatter.string(from: episode.releaseDate))"
        
        return cell // Devolvemos la celda
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = model[indexPath.row]
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}

extension EpisodeListViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        model = season.sortedEpisodes
        title = season.name
       
        tableView.reloadData()
    }
}
