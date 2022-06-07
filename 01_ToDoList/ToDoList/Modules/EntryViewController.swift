//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Furkan DURSUN on 25.05.2022.
//

import UIKit

protocol Delegate: AnyObject {
    func taskDidSaved()
}

class EntryViewController: UIViewController {
    
    weak var delegate: Delegate?
    private let userDefaults = UserDefaults.standard
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 350, height: 40))
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.view.center.x - 50), y: 160, width: 100, height: 40))
        button.backgroundColor = .blue
        button.isEnabled = false
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        configureUI()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        guard let title = textField.text else { return }
        
        if var tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
            let task = Task(title: title)
            tasks.append(task)
            
            try? UserDefaultsManager.shared.setObject(tasks, forKey: "Tasks")
            delegate?.taskDidSaved()
            navigationController?.popToRootViewController(animated: true)
        } else {
            let task = Task(title: title)
            
            try? UserDefaultsManager.shared.setObject([task], forKey: "Tasks")
            delegate?.taskDidSaved()
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Helpers
private extension EntryViewController {
    func configureUI() {
        self.view.addSubview(textField)
        self.view.addSubview(button)
    }
}

// MARK: - UITextFieldDelegate
extension EntryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        button.isEnabled = !text.isEmpty
    }
}
