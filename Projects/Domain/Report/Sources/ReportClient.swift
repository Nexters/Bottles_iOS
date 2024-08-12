//
//  ReportClient.swift
//  DomainReport
//
//  Created by 임현규 on 8/12/24.
//

import DomainReportInterface
import CoreNetwork

import ComposableArchitecture
import Moya

extension ReportClient: DependencyKey {
  public static let liveValue: ReportClient = .live()
  
  private static func live() -> ReportClient {
    @Dependency(\.network) var networkManager
    
    return .init(
      reportUser: { userReportInfo in
        let requestData = ReportUserRequestDTO(reportReasonShortAnswer: userReportInfo.reason, userId: userReportInfo.userId)
        try await networkManager.reqeust(api: .apiType(ReportAPI.reportUser(requestData: requestData)))
      }
    )
  }
}

extension DependencyValues {
  public var reportClient: ReportClient {
    get { self[ReportClient.self] }
    set { self[ReportClient.self] = newValue }
  }
}
