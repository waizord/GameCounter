//
//  AddPlayerViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import UIKit

class AddPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.colors.appBackgroundBlack
        settingNavBar()
    }

}
//MARK: - Actions
extension AddPlayerViewController {
    @objc func tapBackButton() {
        print("tap on Back")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapAddButton() {
        print("tap on Add")
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Setting NavBar
extension AddPlayerViewController {
    func settingNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.target = self
        backButton.action = #selector(tapBackButton)
        self.navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem()
        addButton.title = "Add"
        addButton.target = self
        addButton.action = #selector(tapAddButton)
        self.navigationItem.rightBarButtonItem = addButton
    }
}
