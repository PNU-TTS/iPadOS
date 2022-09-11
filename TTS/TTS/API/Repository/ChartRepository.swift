//
//  ChartRepository.swift
//  TTS
//
//  Created by 안현주 on 2022/09/11.
//

import Moya
import RxSwift

class ChartRepository: BaseRepository<FabricAPI> {
    
    func getChartData(type: Int) -> Single<ChartModel> {
        return getProvider(mode: .test, debug: true).rx
            .request(.queryChartData(type: type))
            .map(ChartModel.self)
    }
}
