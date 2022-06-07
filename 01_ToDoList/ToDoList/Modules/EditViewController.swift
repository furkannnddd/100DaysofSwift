//
//  EditViewController.swift
//  ToDoList
//
//  Created by Furkan DURSUN on 1.06.2022.
//

import UIKit

protocol DelegateEdit: AnyObject {
    func taskDidSaved()
}

class EditViewController: UIViewController {
    
    weak var delegate: DelegateEdit?
    private let userDefaults = UserDefaults.standard
    var selectedTask: String = ""
    
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
        textField.text = selectedTask
    }
    
    @objc func buttonAction(sender: UIButton!) {
        guard let title = textField.text else { return }
        
        if var tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
            if let row = tasks.firstIndex(where: {$0.title == selectedTask}) {
                tasks[row].title = title
            }
            
            try? UserDefaultsManager.shared.setObject(tasks, forKey: "Tasks")
            delegate?.taskDidSaved()
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Helpers
private extension EditViewController {
    func configureUI() {
        self.view.addSubview(textField)
        self.view.addSubview(button)
    }
}

// MARK: - UITextFieldDelegate
extension EditViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        button.isEnabled = !text.isEmpty
    }
}
