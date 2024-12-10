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
        } else if diff.hour! > 23{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return "feito em \(formatter.string(from: date))"
        } else if diff.hour! <= 0, diff.minute! > 0, diff.minute! < 60 {
            return "feito a \(diff.minute!) minutos"
        } else {
            return "feito agora"
        }
    }
    
    static func numberFormatter(number: Double) -> String {
        let numberFormated = number
//        if number < 0 {
//            numberFormated = number * -1
//        }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return "R$ " + formatter.string(from: NSNumber(value: numberFormated))!
    }
}
