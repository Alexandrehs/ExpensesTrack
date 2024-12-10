//
//  ExpenseDetailViewController.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 09/12/24.
//

import UIKit

class ExpenseDetailViewController: UIViewController {
    
    private var expenseTitle: String
    private var category: String
    private var value: String
    private var createdAt: String
    
    init(expenseTitle: String, category: String, value: String, createdAt: String) {
        self.expenseTitle = expenseTitle
        self.category = category
        self.value = value
        self.createdAt = createdAt
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stack: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 20
        variable.alignment = .center
        variable.distribution = .fillProportionally
        return variable
    }()
    
    private lazy var titleLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        variable.text = expenseTitle
        return variable
    }()
    
    private lazy var categoryLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = category
        return variable
    }()
    
    private lazy var valueLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        variable.text = value
        return variable
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.text = createdAt
        return variable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        configView()
    }
    
    private func configView() {
        view.addSubview(stack)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(categoryLabel)
        stack.addArrangedSubview(valueLabel)
        stack.addArrangedSubview(createdAtLabel)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
