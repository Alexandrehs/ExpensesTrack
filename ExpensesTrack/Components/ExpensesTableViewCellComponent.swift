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
        variable.spacing = 20
        variable.alignment = .fill
        variable.distribution = .fill
        return variable
    }()
    
    private lazy var stackTitleAndCategory: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.alignment = .leading
        variable.alignment = .fill
        variable.spacing = 5
        return variable
    }()
    
    private lazy var stackImage: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
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
        variable.backgroundColor = UIColor.app
        variable.layer.cornerRadius = 20
        variable.clipsToBounds = true
        variable.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        variable.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
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
        let variable = UILabel().labelTextPrimary()
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
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32.0),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupStack() {
        stackTitleAndCategory.addArrangedSubview(titleLabel)
        stackTitleAndCategory.addArrangedSubview(categoryLabel)
        
        stackValueAndCreatedAt.addArrangedSubview(valueLabel)
        stackValueAndCreatedAt.addArrangedSubview(createdAtLabel)
        
        stackImage.addArrangedSubview(expenseImageView)
        
        stack.addArrangedSubview(stackImage)
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
        let valueText = FormatterUtil.numberFormatter(number: expense.value)
        titleLabel.text = expense.title
        categoryLabel.text = expense.category
        createdAtLabel.text = FormatterUtil.dateFormatter(date: expense.createdAt)
        
        if expense.entry {
            valueLabel.textColor = UIColor.textColorEntry
            valueLabel.text = "+" + valueText
        } else {
            valueLabel.text = valueText
        }
    }
}
