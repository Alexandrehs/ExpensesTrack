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
    @NSManaged var entry: Bool
}

enum Category: String, CaseIterable{
    case CARTAODEBITO
    case CARTAOCREDITO
    case FLASH
    case FUTIL
    case SUPERMERCADO
    case SACOLAO
    case FARMACIA
    case CARRO
    case GATOS
    case CASA
    case DENTISTA
    case SALARIO
    case OUTRO
}
