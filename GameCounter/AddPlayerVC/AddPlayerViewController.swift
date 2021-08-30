//
//  AddPlayerViewController.swift
//  GameCounter
//
//  Created by Ivan on 8/28/21.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
    var sendName: String?
    
    let addPlayerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textColor = .white
        label.text = "Add Player"
        return label
    }()
    
    let textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.colors.customBackgroundGray
        return view
    }()
    
    let textFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = Constants.colors.customBackgroundGray
        field.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        field.textColor = Constants.colors.customPlaseHolder
        field.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: [NSAttributedString.Key.foregroundColor : Constants.colors.customPlaseHolder])
        field.becomeFirstResponder()
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.colors.appBackgroundBlack
        self.hideKeyboardWhenTappedAround()
        settingNavBar()
        settingAddPlayerLabel()
        settingTextView()
        settingTextField()
    }

}
//MARK: - Actions
extension AddPlayerViewController {
    @objc func tapBackButton() {
        print("tap on Back")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapAddButton() {
        if let name = sendName {
            print("tap on Add name: \(name)")
        }
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

//MARK: - Setting views
extension AddPlayerViewController {
    func settingAddPlayerLabel() {
        view.addSubview(addPlayerLabel)
        
        NSLayoutConstraint.activate([
            addPlayerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            addPlayerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func settingTextView() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: addPlayerLabel.bottomAnchor, constant: 25),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func settingTextField() {
        textFieldView.delegate = self
        view.addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            textFieldView.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24)
        ])
    }
}

//MARK: - DataSource and Delegate
extension AddPlayerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if !text.isReallyEmpty {
                sendName = text.trimmingCharacters(in: .whitespacesAndNewlines)
                print(sendName!)
            }
        }
    }
}

extension AddPlayerViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPlayerViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

///Support
extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
