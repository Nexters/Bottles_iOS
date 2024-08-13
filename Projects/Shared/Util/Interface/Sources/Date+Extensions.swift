//
//  Date+Extensions.swift
//  SharedUtilInterface
//
//  Created by 임현규 on 8/13/24.
//

import Foundation

extension Date {
  
  /// 현재 시간을 기준으로 보틀 도착 시간과의 시간 차이를 계산
  public func newBottleArrivaleTime() -> Int {
    let current = self
    let calendar = Calendar.current
    
    let today12pm = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: current)!
    let today18pm = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: current)!
    
    let arrivalTime: Date
    
    if current < today12pm {
      // 현재 시간이 12:00 이전인 경우
      arrivalTime = today12pm
    } else if current < today18pm {
      // 현재 시간이 12:00, 18:00 사이 인 경우
      arrivalTime = today18pm
    } else {
      // 현재 시간이 18:00 이후인 경우
      arrivalTime = calendar.date(byAdding: .day, value: 1, to: today12pm)!
    }
    
    // 도착 시간과 현재 시간의 시간 차이
    let timeDifference = calendar.dateComponents([.hour], from: current, to: arrivalTime)
    
    return timeDifference.hour ?? 0
  }
}
