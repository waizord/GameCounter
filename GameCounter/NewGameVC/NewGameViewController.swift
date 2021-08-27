//
//  ViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/26/21.
//

import UIKit

class NewGameViewController: UIViewController {
    let dataSourse = ["Kerri", "Nine", "Glory", "Dien"]
    
    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textColor = .white
        label.text = "Game Counter"
        return label
    }()
    
    let playersTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        settingGameLabel()
        settingPlayersTableView()
    }
}

//MARK: - Setting views
extension NewGameViewController {
    func settingGameLabel() {
        view.addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            gameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
//            gameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            gameLabel.heightAnchor.constraint(equalToConstant: CGFloat(dataSourse.count * 44))
        ])
    }
    func settingPlayersTableView() {
        playersTable.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        playersTable.dataSource = self
        playersTable.delegate = self
        
        playersTable.layer.cornerRadius = 16
        playersTable.backgroundColor = .gray
        
        view.addSubview(playersTable)
        
        NSLayoutConstraint.activate([
            playersTable.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 25),
            playersTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playersTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playersTable.heightAnchor.constraint(equalToConstant: CGFloat(dataSourse.count * 54))
        ])
    }
}

//MARK: - DataSource and Delegate
extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        cell.textLabel?.text = dataSourse[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        cell.backgroundColor = .clear
        return cell
    }
}
extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
