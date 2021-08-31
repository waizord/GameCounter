//
//  ViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/26/21.
//

import UIKit

class NewGameViewController: UIViewController {
    var players = [Player]()
    
    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textColor = .white
        label.text = "Game Counter"
        return label
    }()
    
    let playersTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapStartGameButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        button.titleLabel?.textColor = .white
        button.setTitle("Start game", for: .normal)
        button.backgroundColor = Constants.colors.customGreen
        button.layer.cornerRadius = Constants.share.startButtonHeight / 2
        button.layer.shadowColor = Constants.colors.customShadowGreen.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0
        button.layer.masksToBounds = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        playersTable.reloadData()
        viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.colors.appBackgroundBlack
        settingNavBar()
        settingGameLabel()
        settingPlayersTableView()
        settingStartGameButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.deactivate(playersTable.constraints)
        //settingGameLabelConstraints()
        //settingStartGameButtonConstraints()
        settingPlayersTableViewConstraints()
    }
}

//MARK: - Actions
extension NewGameViewController {
    @objc func tapCancel() {
        self.navigationController?.popViewController(animated: true)
        print("tap on Cancel")
    }
    
    @objc func addPlayerButton() {
        let addPlayerVC = AddPlayerViewController()
        addPlayerVC.delegate = self
        self.navigationController?.pushViewController(addPlayerVC, animated: true)
    }
    
    @objc func deletePlayerButton(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        print("Delete row: \(indexPath.row)")
        players.remove(at: indexPath.row)
        playersTable.deleteRows(at: [indexPath], with: .fade)
        playersTable.reloadData()
        viewDidLayoutSubviews()
    }
    @objc func tapStartGameButton() {
        let gameVC = GameProcessViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
        print("start")
    }
}

//MARK: - Setting NavBar
extension NewGameViewController {
    func settingNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        backButton.target = self
        backButton.action = #selector(tapCancel)
        self.navigationItem.leftBarButtonItem = backButton
    }
}
//MARK: - Setting views
extension NewGameViewController {
    func settingGameLabel() {
        view.addSubview(gameLabel)
        settingGameLabelConstraints()
    }
    
    func settingPlayersTableView() {
        playersTable.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        playersTable.dataSource = self
        playersTable.delegate = self
        playersTable.isEditing = true
        
        playersTable.layer.cornerRadius = 16
        playersTable.backgroundColor = Constants.colors.customBackgroundGray
        
        view.addSubview(playersTable)
        settingPlayersTableViewConstraints()
    }
    
    func settingStartGameButton() {
        view.addSubview(startButton)
        settingStartGameButtonConstraints()
    }
}

//MARK: - Constraints
extension NewGameViewController {
    func settingGameLabelConstraints() {
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            gameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    func settingStartGameButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: Constants.share.startButtonHeight)
        ])
    }
    
    func settingPlayersTableViewConstraints() {
        
        let heightTableSizeConstraint = Constants.share.playerCellHeight * CGFloat(players.count) + Constants.share.playerHeaderHeight + Constants.share.playerFooterHeight
        
        let heightSearchLine = view.safeAreaLayoutGuide.layoutFrame.height - gameLabel.frame.height - startButton.frame.height - CGFloat(12 + 25 + 70)
        print(heightSearchLine, heightTableSizeConstraint)
        
        NSLayoutConstraint.activate([
            playersTable.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 25),
            playersTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playersTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playersTable.heightAnchor.constraint(equalToConstant: Constants.share.playerCellHeight * CGFloat(players.count) + Constants.share.playerHeaderHeight + Constants.share.playerFooterHeight)
        ])
        
//        if heightTableSizeConstraint <= heightSearchLine {
//            playersTable.heightAnchor.constraint(equalToConstant: heightTableSizeConstraint).isActive = true
//        }else {
//            playersTable.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20).isActive = true
//        }
    }
}

//MARK: - Custom Delegate
extension NewGameViewController: AddPlayerProtocolDelegate {
    func addPlayerName(_ name: String) {
        let player = Player(name: name)
        players.append(player)
    }
}

//MARK: - DataSource and Delegate
extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        
        cell.textLabel?.text = players[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        cell.backgroundColor = Constants.colors.customBackgroundGray
        
        cell.selectionStyle = .none
        let separatorLine = UIView(frame: CGRect(x: 16, y: cell.frame.height, width: cell.frame.width - 16, height: 1))
        separatorLine.backgroundColor = Constants.colors.customPlayerTableSeparator
        cell.addSubview(separatorLine)
        
        let deleteButton = UIButton(frame: CGRect(x: 16, y: (cell.contentView.frame.height / 2) - 13, width: 25, height: 25))
        deleteButton.layer.cornerRadius = 25 / 2
        deleteButton.backgroundColor = Constants.colors.customRed
        deleteButton.setImage(UIImage(named: "minus"), for: .normal)
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(self, action: #selector(deletePlayerButton), for: .touchUpInside)
        cell.addSubview(deleteButton)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.subviews
                .filter { $0.isMember(of: NSClassFromString("UITableViewCellReorderControl")!) }
                .compactMap { $0.value(forKey: "imageView") as? UIImageView }
                .forEach {$0.image = $0.image?.withRenderingMode(.alwaysTemplate)
                    $0.tintColor = .white
                }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.players[sourceIndexPath.row]
        players.remove(at: sourceIndexPath.row)
        players.insert(movedObject, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.reloadData()
        print("reload")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.share.playerCellHeight
    }
    
    //header setting
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.share.playerHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: Constants.share.playerHeaderHeight))
        label.text = "Players"
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = Constants.colors.customTextGray
        headerView.addSubview(label)
        return headerView
    }
    
    //footer setting
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.share.playerFooterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.share.playerFooterHeight))
        button.addTarget(self, action: #selector(addPlayerButton), for: .touchUpInside)
        let label = UILabel(frame: CGRect(x: 56, y: 0, width: tableView.frame.width - 56, height: Constants.share.playerFooterHeight))
        label.text = "Add player"
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = Constants.colors.customGreen
        button.addSubview(label)
        
        let addButton = UIButton(frame: CGRect(x: 16, y: (Constants.share.playerFooterHeight / 2) - 13, width: 25, height: 25))
        addButton.layer.cornerRadius = 25 / 2
        addButton.backgroundColor = Constants.colors.customGreen
        addButton.setImage(UIImage(named: "plus"), for: .normal)
        footerView.addSubview(addButton)
        footerView.addSubview(button)
        return footerView
    }
}
