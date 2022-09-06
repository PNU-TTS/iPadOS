//
//  IntToDateConverter.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/06.
//

import UIKit

struct DateTimeConverter {
    
    static func fromInt(input: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm:ss"
        
        let date = Date(timeIntervalSince1970: TimeInterval(input))
        return dateFormatter.string(from: date)
    }
}
