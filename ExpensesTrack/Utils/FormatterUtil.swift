//
//  FormatterUtil.swift
//  ExpensesTrack
//
//  Created by Alexandre Henrique da Silva on 03/12/24.
//
import Foundation

class FormatterUtil {
    static func dateFormatter(date: Date) -> String{
        let now = Date.now
        let diff = Calendar.current.dateComponents([.hour, .minute, .second], from: date, to: now)
        
        if diff.hour! > 0, diff.hour! < 24 {
            return "feito a \(diff.hour!) horas"
        } else if diff.hour! <= 0, diff.minute! > 0, diff.minute! < 60 {
            return "feito a \(diff.minute!) minutos"
        } else {
            return "feito agora"
        }
    }
    
    static func numberFormatter(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "error"
    }
}
