//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 30/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    private var model: Episode
    
    // MARK: Inicialización
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }
    
}

extension EpisodeDetailViewController {
        private func subscribeToNotifications() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(
                self,
                selector: #selector(seasonDidChange),
                name: .seasonDidNotificationName,
                object: nil
            )
        }
    
        private func unsubscribeNotifications() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
    
        @objc private func seasonDidChange(notification: Notification) {
            guard let dictionary = notification.userInfo else { return }
            guard let season = dictionary[SeasonListViewController.Constants.seasonKey] as? Season else { return }
        
        // Actualizamos el modelo
            model = season.sortedEpisodes[0]
        
        // Actualizamos la etiqueta con la casa correcta
            self.navigationItem.hidesBackButton = true
            self.navigationItem.hidesBackButton = false
        
            syncModelWithView()
            navigationController?.popViewController(animated: true)
        }
}


extension EpisodeDetailViewController {
        private func syncModelWithView() {
            title = model.name
            let dateFormatter = DateFormatter()
        
            episodeNameLabel.text = "Episodio: \(model.name)"
            
            if let season = model.season {
                episodeSeasonLabel.text = "\(season.name)"
            } else {
                episodeSeasonLabel.text = ""
            }
            
            releaseDateLabel.text = "Emitido por pimera vez en el \(dateFormatter.string(from: model.releaseDate))"
    }
}


