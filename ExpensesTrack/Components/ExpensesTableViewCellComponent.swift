//
//  ExpensesTableViewCellComponent.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import UIKit

class ExpensesTableViewCellComponent: UITableViewCell {
    
    private lazy var stack: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .horizontal
        variable.isLayoutMarginsRelativeArrangement = true
        variable.layoutMargins = .init(top: 8.0, left: 16.0, bottom: 16.0, right: 16.0)
        variable.spacing = 10
        variable.distribution = .fill
        return variable
    }()
    
    private lazy var stackTitleAndCategory: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.alignment = .leading
        variable.distribution = .fillProportionally
        return variable
    }()
    
    private lazy var stackValueAndCreatedAt: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.alignment = .trailing
        return variable
    }()
    
    private lazy var expenseImageView: UIImageView = {
        let variable = UIImageView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.backgroundColor = UIColor.ligthGray
        variable.layer.cornerRadius = 25
        variable.clipsToBounds = true
        variable.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        variable.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        return variable
    }()

    private lazy var titleLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        return variable
    }()
    
    private lazy var categoryLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        return variable
    }()
    
    private lazy var valueLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        return variable
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.font = .systemFont(ofSize: 12.0, weight: .bold)
        return variable
    }()
    
    private func setupSubView() {
        addSubview(stack)
        setupStack()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupStack() {
        stackTitleAndCategory.addArrangedSubview(titleLabel)
        stackTitleAndCategory.addArrangedSubview(categoryLabel)
        
        stackValueAndCreatedAt.addArrangedSubview(valueLabel)
        stackValueAndCreatedAt.addArrangedSubview(createdAtLabel)
        
        stack.addArrangedSubview(expenseImageView)
        stack.addArrangedSubview(stackTitleAndCategory)
        stack.addArrangedSubview(stackValueAndCreatedAt)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(expense: Expense) {
        titleLabel.text = expense.title
        categoryLabel.text = expense.category
        valueLabel.text = "R$ " + FormatterUtil.numberFormatter(number: expense.value)
        createdAtLabel.text = FormatterUtil.dateFormatter(date: expense.createdAt)
    }
}
