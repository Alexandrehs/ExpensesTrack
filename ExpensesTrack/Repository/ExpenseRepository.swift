//
//  ExpenseRepository.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//
import Foundation
import UIKit
import CoreData

class ExpenseRepository {
    var expenses: [Expense] = []
    var total: Double = 0
    var totalExpenses: Double = 0
    var totalEntrys: Double = 0
    
    func addExpense(expense: NSManagedObject, context: NSManagedObjectContext) {
        
        do {
            try context.save()
            expenses.append(expense as! Expense)
            self.total = sumTotal()
        } catch {
            print("error ao salvar, erro: \(error)")
        }
    }
    
    func loadExpenses() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        request.returnsObjectsAsFaults = false
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let expense = result as! Expense
                self.expenses.append(expense)
            }
            self.total = sumTotal()
        } catch {
            print("deu ruim em buscar as expense, error: \(error)")
        }
    }
    
    func deleteExpense(id: UUID) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.predicate = NSPredicate(format: "id=='\(id)'")
        let result = try! context.fetch(request)
        for object in result {
            context.delete(object)
        }
        
        do {
            try context.save()
        } catch {
            print("erro ao deletar id: \(id), error: \(error)")
        }
    }
    
    private func sumTotal() -> Double {
        var total: Double = 0
        for e in expenses {
            total += e.value
            if e.value < 0 {
                totalExpenses += e.value
            } else if e.value > 0 {
                totalEntrys += e.value
            }
        }
        
        return total
    }
    
    func getTotal() -> Double {
        return sumTotal()
    }
    
    init() {
        loadExpenses()
    }
}
