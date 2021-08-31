//
//  GameViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import UIKit

class GameProcessViewController: UIViewController {

    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textColor = .white
        label.text = "Game"
        return label
    }()
    
    let rollButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRollButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "dice_4"), for: .normal)
        return button
    }()
    
    let diceView: UIView = {
        let view = UIView()
        return view
    }()
    
    let diceCountView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textColor = .white
        label.text = "Game"
        return label
    }()
    
    let timerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRollButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "play"), for: .normal)
        button.setBackgroundImage(UIImage(named: "pause"), for: .reserved)
        return button
    }()
    
    let playerCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPreviousButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "previous"), for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    let pageCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackButtonView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 15
        return view
    }()
    
    let countButtonOne = CountButton()
    let countButtonUnOne = CountButton()
    let countButtonFive = CountButton()
    let countButtonUnFive = CountButton()
    let countButtonTen = CountButton()
    let countButtonUnTen = CountButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.colors.appBackgroundBlack
        settingNavBar()
        settingGameLabel()
        settingRollButton()
        settingStackButton()
    }
}

//MARK: - Actions
extension GameProcessViewController {
    @objc func tapNewGameButton() {
        let newGameVC = NewGameViewController()
        self.navigationController?.pushViewController(newGameVC, animated: true)
    }
    
    @objc func tapResultButton() {
        let resultVC = ResultViewController()
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    @objc func tapRollButton() {
        print("Roll")
    }
    
    @objc func tapPreviousButton() {
        print("Previous")
    }
    
    @objc func tapNextButton() {
        print("Next")
    }
}
//MARK: - Setting NavBar
extension GameProcessViewController {
    func settingNavBar() {
        let newGameButton = UIBarButtonItem()
        newGameButton.title = "New Game"
        newGameButton.target = self
        newGameButton.action = #selector(tapNewGameButton)
        self.navigationItem.leftBarButtonItem = newGameButton
        
        let resultButton = UIBarButtonItem()
        resultButton.title = "Results"
        resultButton.target = self
        resultButton.action = #selector(tapResultButton)
        self.navigationItem.rightBarButtonItem = resultButton
    }
}

//MARK: - Setting views
extension GameProcessViewController {
    func settingGameLabel() {
        view.addSubview(gameLabel)
        settingGameLabelConstraints()
    }
    
    func settingRollButton() {
        view.addSubview(rollButton)
        settingRollButtonConstraints()
    }
    
    func settingCountButtons() {
        countButtonUnOne.configure(Constants.share.countButtonSize, "-1", 25)
        countButtonFive.configure(Constants.share.countButtonSize, "+5", 25)
        countButtonUnFive.configure(Constants.share.countButtonSize, "-5", 25)
        countButtonTen.configure(Constants.share.countButtonSize, "+10", 25)
        countButtonUnTen.configure(Constants.share.countButtonSize, "-10", 25)
    }
    
    func settingStackButton() {
        settingCountButtons()
        stackButtonView.addArrangedSubview(countButtonUnTen)
        stackButtonView.addArrangedSubview(countButtonUnFive)
        stackButtonView.addArrangedSubview(countButtonUnOne)
        stackButtonView.addArrangedSubview(countButtonFive)
        stackButtonView.addArrangedSubview(countButtonTen)
        view.addSubview(stackButtonView)
        settingStackButtonConstraints()
        print(stackButtonView.frame.size)
    }
    
}

//MARK: - Constraints
extension GameProcessViewController {
    func settingGameLabelConstraints() {
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            gameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func settingRollButtonConstraints() {
        NSLayoutConstraint.activate([
            rollButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            rollButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            rollButton.heightAnchor.constraint(equalToConstant: Constants.share.diceSize),
            rollButton.widthAnchor.constraint(equalToConstant: Constants.share.diceSize)
        ])
    }
    
    func settingStackButtonConstraints() {
        NSLayoutConstraint.activate([
            stackButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -74),
            stackButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            stackButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            stackButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
