//
//  AddExpenseViewController.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit
import CoreData

class AddExpenseViewController: UIViewController {
    weak var delegate: ExpensesViewControllerDelegate?
    var repository: ExpenseRepository
    var category: String = ""
    
    private lazy var stack: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 10
        variable.distribution = .equalCentering
        return variable
    }()
    
    private lazy var infoLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        variable.text = "Bora registrar uma nova despeza"
        variable.textAlignment = .center
        return variable
    }()
    
    private lazy var stackLabelsAndFields: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 10
        return variable
    }()
    
    private lazy var stackCategory: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .horizontal
        variable.spacing = 10
        return variable
    }()
    
    private lazy var categoyLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = "Categoria:"
        return variable
    }()
    
    private lazy var categoryButton: UIButton = {
        let variable = UIButton(primaryAction: nil)
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        variable.tintColor = UIColor.textColorPrimary
        variable.backgroundColor = UIColor.lightGray
        variable.layer.cornerRadius = 12.0
        variable.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        variable.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        let actionClosure = { (action: UIAction) in self.category = action.title}
        var menuChildren: [UIMenuElement] = []
        for cat in Category.allCases {
            menuChildren.append(UIAction(title: cat.rawValue, handler: actionClosure))
        }
        variable.menu = UIMenu(options: .displayInline, children: menuChildren)
        variable.showsMenuAsPrimaryAction = true
        variable.changesSelectionAsPrimaryAction = true
        variable.frame = CGRect(x: 150, y: 200, width: 100, height: 40)
        return variable
    }()
    
    private lazy var titleLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = "Título:"
        return variable
    }()
    
    private lazy var titleTextField: UITextField = {
        let variable = UITextField().textFieldDefault(placeholder: "Digite aqui o titulo da despeza", keyboardType: .default)
        variable.addDoneButtonOnKeyboard()
        return variable
    }()
    
    private lazy var valueLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = "Valor:"
        return variable
    }()
    
    private lazy var valueTextField: UITextField = {
        let variable = UITextField().textFieldDefault(placeholder: "Digite aqui o titulo da despeza", keyboardType: .decimalPad)
        variable.addDoneButtonOnKeyboard()
        return variable
    }()
    
    private lazy var buttonSave: UIButton = {
        let variable = UIButton().buttonDefault(title: "Salva despeza")
        variable.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        return variable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubView()
        setupConstraints()
    }
    
    init(repository: ExpenseRepository = ExpenseRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubView() {
        view.addSubview(stack)
        setupStack()
    }
    
    private func setupStack() {
        stackCategory.addArrangedSubview(categoyLabel)
        stackCategory.addArrangedSubview(categoryButton)
        stackLabelsAndFields.addArrangedSubview(titleLabel)
        stackLabelsAndFields.addArrangedSubview(titleTextField)
        stackLabelsAndFields.addArrangedSubview(valueLabel)
        stackLabelsAndFields.addArrangedSubview(valueTextField)
        
        stack.addArrangedSubview(infoLabel)
        stack.addArrangedSubview(stackCategory)
        stack.addArrangedSubview(stackLabelsAndFields)
        stack.addArrangedSubview(buttonSave)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0)
        ])
    }
    
    @objc private func tapSaveButton() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        guard let value = valueTextField.text, !value.isEmpty else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: context)
        let newExpense = Expense(entity: entity!, insertInto: context)
        
        newExpense.id = UUID()
        newExpense.title = title
        newExpense.value = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
        newExpense.createdAt = Date.now
        newExpense.category = category
        
        repository.addExpense(expense: newExpense, context: context)
        delegate?.updateTotal()
        delegate?.addExpense()
        dismiss(animated: true)
    }

}
