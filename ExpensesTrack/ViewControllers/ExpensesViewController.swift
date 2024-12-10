//
//  ViewController.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 02/12/24.
//

import UIKit

protocol ExpensesViewControllerDelegate: AnyObject {
    func addExpense()
    func updateTotal()
}

class ExpensesViewController: UIViewController {
    private var repository: ExpenseRepository
    private var totalExpenses: String = ""
    
    private lazy var stackBalanceInfo: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .horizontal
        variable.backgroundColor = UIColor.appColorBlack
        variable.isLayoutMarginsRelativeArrangement = true
        variable.layoutMargins = .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        variable.alignment = .fill
        return variable
    }()
    
    private lazy var stackBalance: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        return variable
    }()
    
    private lazy var stackBalanceEntrys: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 1.0
        return variable
    }()
    
    private lazy var titleTotalEntryslLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.text = "Total de entradas"
        variable.font = .systemFont(ofSize: 12.0, weight: .bold)
        return variable
    }()
    
    private lazy var titleTotalEntrysValuelLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = "R$ 100,00"
        variable.textColor = .white
        return variable
    }()
    
    private lazy var titleTotalExpenseslLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.text = "Total de despeza"
        variable.font = .systemFont(ofSize: 12.0, weight: .bold)
        return variable
    }()
    
    private lazy var titleTotalExpensesValuelLabel: UILabel = {
        let variable = UILabel().labelTextSecondary()
        variable.text = "R$ 2.000,00"
        variable.textColor = .white
        return variable
    }()
    
    private lazy var titleTotalLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.text = "Total geral"
        return variable
    }()
    
    private lazy var totalLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        variable.textColor = .white
        return variable
    }()
    
    private lazy var tableView: UITableView = {
        let variable = UITableView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.separatorStyle = .none
        variable.showsVerticalScrollIndicator = true
        variable.delegate = self
        variable.dataSource = self
        variable.register(ExpensesTableViewCellComponent.self, forCellReuseIdentifier: "cellid")
        return variable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        totalLabel.text = FormatterUtil.numberFormatter(number: repository.total)
        titleTotalEntrysValuelLabel.text = FormatterUtil.numberFormatter(number: repository.totalEntrys)
        titleTotalExpensesValuelLabel.text = FormatterUtil.numberFormatter(number: repository.totalExpenses)
        setupNavigationBar(title: "Expenses Track")
        setupSubViews()
        setupConstraints()
    }
    
    init(repository: ExpenseRepository = ExpenseRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        view.addSubview(stackBalanceInfo)
        view.addSubview(tableView)
        
        stackBalanceEntrys.addArrangedSubview(titleTotalEntryslLabel)
        stackBalanceEntrys.addArrangedSubview(titleTotalEntrysValuelLabel)
        stackBalanceEntrys.addArrangedSubview(titleTotalExpenseslLabel)
        stackBalanceEntrys.addArrangedSubview(titleTotalExpensesValuelLabel)
        
        stackBalance.addArrangedSubview(titleTotalLabel)
        stackBalance.addArrangedSubview(totalLabel)
        stackBalanceInfo.addArrangedSubview(stackBalance)
        stackBalanceInfo.addArrangedSubview(stackBalanceEntrys)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackBalanceInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBalanceInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBalanceInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackBalanceInfo.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar(title: String) {
        self.navigationItem.title = title
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(named: AssetsConstants.appColorBlack)
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.shadowColor = UIColor.appColorBlack
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        navigationItem.compactAppearance = appearence
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        //self.navigationController?.navigationBar.tintColor = .white
        addButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addButton
    }

}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as? ExpensesTableViewCellComponent else {
            return UITableViewCell()
        }
        
        cell.configureCell(expense: repository.expenses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let expense = repository.expenses[indexPath.row]
        let expenseDetailVC = ExpenseDetailViewController(expenseTitle: expense.title, category: expense.category, value: FormatterUtil.numberFormatter(number: expense.value), createdAt: FormatterUtil.dateFormatter(date: expense.createdAt))
        navigationController?.pushViewController(expenseDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.deleteExpense(id: repository.expenses[indexPath.row].id)
            repository.expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let newTotal = FormatterUtil.numberFormatter(number: repository.getTotal())
            totalLabel.text = newTotal
        }
    }
}

extension ExpensesViewController: ExpenseTableViewHeaderDelegate {
    @objc func tapAddButton() {
        let addExpenseVC = AddExpenseViewController(repository: repository)
        addExpenseVC.delegate = self
        navigationController?.present(addExpenseVC, animated: true)
    }
}

extension ExpensesViewController: ExpensesViewControllerDelegate {
    func updateTotal() {
        totalLabel.text = FormatterUtil.numberFormatter(number: repository.total)
    }
    
    func addExpense() {
        tableView.reloadData()
    }
}
