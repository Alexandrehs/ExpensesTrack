//
//  Expense.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//

import Foundation
import CoreData
import UIKit

@objc(Expense)
class Expense: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var value: Double
    @NSManaged var createdAt: Date
    @NSManaged var category: String
    
//    convenience init(title: String, value: Double, createdAt: Date, category: String) {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        self.init(context: delegate.persistentContainer.viewContext)
//        self.id = UUID()
//        self.title = title
//        self.value = value
//        self.createdAt = createdAt
//        self.category = category
//    }
}

enum Category: String, CaseIterable{
    case CARTAODEBITO
    case CARTAOCREDITO
    case SUPERMERCADO
    case SACOLAO
    case FARMACIA
    case CARRO
    case GATOS
    case CASA
}
