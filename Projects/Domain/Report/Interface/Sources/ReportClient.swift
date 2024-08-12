//
//  ReportClient.swift
//  DomainReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

public struct ReportClient {
  private let reportUser: (UserReportInfo) async throws -> Void
  
  public init(reportUser: @escaping (UserReportInfo) async throws -> Void) {
    self.reportUser = reportUser
  }
  
  public func reportUser(userReportInfo: UserReportInfo) async throws -> Void {
    try await reportUser(userReportInfo)
  }
}
