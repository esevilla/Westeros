//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Estefania Sevilla on 30/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberAliasLabel: UILabel!
    
    private var model: Person
    
    init(model: Person){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        
    }
}

extension MemberDetailViewController {
    func syncModelWithView(){
        self.memberNameLabel.text = model.fullName
        self.memberAliasLabel.text = model.alias
    }
}

extension MemberDetailViewController {
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
        navigationController?.popViewController(animated: true)
    }
}


