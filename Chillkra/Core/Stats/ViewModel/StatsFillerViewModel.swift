//
//  StatsFillerViewModel.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import Foundation

enum StatsFillerViewModel: Int,CaseIterable {
    case activity
    case bedtime
    
    var title: String {
        switch self {
        case .activity:
            return "Activity"
        case .bedtime:
            return "Bed time"
        }
    }
}
