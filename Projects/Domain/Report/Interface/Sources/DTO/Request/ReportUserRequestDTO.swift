//
//  ReportUserRequestDTO.swift
//  DomainReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

public struct ReportUserRequestDTO: Encodable {
  let reportReasonShortAnswer: String
  let userId: Int
  
  public init(reportReasonShortAnswer: String, userId: Int) {
    self.reportReasonShortAnswer = reportReasonShortAnswer
    self.userId = userId
  }
}
