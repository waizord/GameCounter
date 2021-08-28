//
//  ViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/26/21.
//

import UIKit

class NewGameViewController: UIViewController {
    var dataSourse = ["Kerri", "Nine", "Glory", "Dien"]
    
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
    
    let heightConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.colors.appBackgroundBlack
        settingGameLabel()
        settingPlayersTableView()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        playersTable.invalidateIntrinsicContentSize()
        playersTable.reloadData()
    }
}

//MARK: - Setting views
extension NewGameViewController {
    func settingGameLabel() {
        view.addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            gameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    func settingPlayersTableView() {
        playersTable.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        playersTable.dataSource = self
        playersTable.delegate = self
        
        playersTable.layer.cornerRadius = 16
        playersTable.backgroundColor = Constants.colors.customBackgroundGray
        
        view.addSubview(playersTable)
        
        heightConstraint.constant = Constants.share.playerCellHeight * CGFloat(dataSourse.count) + Constants.share.playerHeaderHeight + Constants.share.playerFooterHeight
        
        NSLayoutConstraint.activate([
            playersTable.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 25),
            playersTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playersTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playersTable.heightAnchor.constraint(equalToConstant: Constants.share.playerCellHeight * CGFloat(dataSourse.count) + Constants.share.playerHeaderHeight + Constants.share.playerFooterHeight)
        ])
    }
}
//MARK: - Custom draw Icon
extension NewGameViewController {
    func drawHamburgerIcon(in view: UIView) {
        drawLineFromPoint(start: CGPoint(x: 0, y: 4), toPoint: CGPoint(x: 18, y: 4), ofColor: .white, inView: view)
        drawLineFromPoint(start: CGPoint(x: 0, y: 9), toPoint: CGPoint(x: 18, y: 9), ofColor: .white, inView: view)
        drawLineFromPoint(start: CGPoint(x: 0, y: 14), toPoint: CGPoint(x: 18, y: 14), ofColor: .white, inView: view)
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view: UIView) {
        
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 2.0
        
        view.layer.addSublayer(shapeLayer)
    }
}
//MARK: - Actions
extension NewGameViewController {
    @objc func addPlayerButton() {
        print("tap")
    }
    
    @objc func deletePlayerButton(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        print("\(indexPath.row)")
        dataSourse.remove(at: indexPath.row)
        playersTable.beginUpdates()
        playersTable.deleteRows(at: [indexPath], with: .fade)
        playersTable.reloadData()
        playersTable.endUpdates()
    }
}

//MARK: - DataSource and Delegate
extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        
        cell.textLabel?.text = dataSourse[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        cell.backgroundColor = .clear
        
        cell.selectionStyle = .none
        let separatorLine = UIView(frame: CGRect(x: 16, y: cell.contentView.frame.height, width: cell.contentView.frame.width - 16, height: 1))
        separatorLine.backgroundColor = Constants.colors.customPlayerTableSeparator
        cell.addSubview(separatorLine)
        
        let deleteButton = UIButton(frame: CGRect(x: 16, y: (cell.contentView.frame.height / 2) - 13, width: 25, height: 25))
        deleteButton.layer.cornerRadius = 25 / 2
        deleteButton.backgroundColor = Constants.colors.customRed
        deleteButton.setImage(UIImage(named: "minus"), for: .normal)
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(self, action: #selector(deletePlayerButton), for: .touchUpInside)
        cell.addSubview(deleteButton)
        let accesView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        drawHamburgerIcon(in: accesView)
        cell.accessoryView = accesView
        
        return cell
    }
}
extension NewGameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            dataSourse.remove(at: indexPath.row)
            // Then, delete the row from the table itself
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.reloadData()
        print("reload")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.share.playerCellHeight
    }
    
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
        //addView.backgroundColor = .black
        footerView.addSubview(addButton)
        footerView.addSubview(button)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.share.playerFooterHeight
    }
    
}
