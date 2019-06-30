//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 30/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBAction func close(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    private var model: Season
    
    init(model: Season){
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
    }
}

extension SeasonDetailViewController {
    private func syncModelWithView() {
        let dateFormatter = DateFormatter()
        
        nameLabel.text = "\(model.name)"
        releaseDateLabel.text = "Emitido por primera vez en \(dateFormatter.string(from: model.releaseDate))"
    }
}
