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
        variable.backgroundColor = UIColor.app
        variable.isLayoutMarginsRelativeArrangement = true
        variable.layoutMargins = .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        return variable
    }()
    
    private lazy var stackBalance: UIStackView = {
        let variable = UIStackView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.axis = .vertical
        variable.spacing = 10.0
        return variable
    }()
    
    private lazy var titleTotalLabel: UILabel = {
        let variable = UILabel().labelTextTerciary()
        variable.text = "Total de despeza"
        return variable
    }()
    
    private lazy var totalLabel: UILabel = {
        let variable = UILabel().labelTextPrimary()
        return variable
    }()
    
    private lazy var tableView: UITableView = {
        let variable = UITableView()
        variable.translatesAutoresizingMaskIntoConstraints = false
        variable.separatorStyle = .none
        variable.showsVerticalScrollIndicator = true
        //variable.transform = CGAffineTransform(scaleX: -, y: -1)
        variable.delegate = self
        variable.dataSource = self
        variable.register(ExpensesTableViewCellComponent.self, forCellReuseIdentifier: "cellid")
        return variable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        totalLabel.text = FormatterUtil.numberFormatter(number: repository.total)
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
        
        stackBalance.addArrangedSubview(titleTotalLabel)
        stackBalance.addArrangedSubview(totalLabel)
        stackBalanceInfo.addArrangedSubview(stackBalance)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackBalanceInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBalanceInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBalanceInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackBalanceInfo.bottomAnchor, constant: 16.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar(title: String) {
        self.navigationItem.title = title
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(named: AssetsConstants.appColor)
        appearence.titleTextAttributes = [.foregroundColor: UIColor.textColorPrimary]
        appearence.shadowColor = UIColor.app
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        navigationItem.compactAppearance = appearence
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        self.navigationController?.navigationBar.tintColor = UIColor.textColorPrimary
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
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.deleteExpense(id: repository.expenses[indexPath.row].id)
            repository.expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
