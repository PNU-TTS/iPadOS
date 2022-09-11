//
//  DailyChartModel.swift
//  TTS
//
//  Created by 안현주 on 2022/09/11.
//

import Foundation

struct ChartModel: Decodable {
    let count: Int
    let xData: [String]
    let yData: [Double]
    let average: Double
}

extension ChartModel {
    static let sampleData: String =
    """
        {
            "count": 12,
            "xData": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            "yData": [12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0, 20.0, 4.0, 6.0, 3.0],
            "average": 12.0
        }
    """
}
