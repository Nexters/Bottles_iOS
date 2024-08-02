//
//  ChipListLayout.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

import CoreLoggerInterface

struct ClipListLayout: Layout {
  var spacing: Spacer.BottleSpacingType = .xs
  var rowSpacing: Spacer.BottleSpacingType = .sm
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let maxWidth = proposal.width ?? 0
    var height: CGFloat = 0
    let rows = generateRows(maxWidth, proposal, subviews)
    
    // rows들로 height 계산
    for (index, row) in rows.enumerated() {
      if index == (rows.count - 1) {
        height += row.maxHeight(proposal)
      } else {
        height += row.maxHeight(proposal) + rowSpacing.minLength
      }
    }
    
    return .init(width: maxWidth, height: height)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    var origin = bounds.origin
    let maxWidth = bounds.width
    let rows = generateRows(maxWidth, proposal, subviews)
    
    // 첫 번째 열부터 view 배치
    for row in rows {
      origin.x = bounds.minX
      
      for view in row {
        let viewSize = view.sizeThatFits(proposal)
        view.place(at: origin, proposal: proposal)
        origin.x += (viewSize.width + spacing.minLength)
      }
      
      origin.y += row.maxHeight(proposal) + rowSpacing.minLength
    }
  }
  
  func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
    var row = [LayoutSubviews.Element]()
    var rows = [[LayoutSubviews.Element]]()
    
    var origin = CGRect.zero.origin
    
    for view in subviews {
      let viewSize = view.sizeThatFits(proposal)
      
      // view를 배치했을 떄 최대 너비보다 큰 경우
      if (origin.x + viewSize.width + spacing.minLength) > maxWidth {
        // 현재까지 row에 담겨있는 view를 rows에 추가한 뒤 row 초기화
        rows.append(row)
        row.removeAll()
        
        origin.x = 0
        // row에 view 추가 -> 새로운 row
        row.append(view)
        
        origin.x += (viewSize.width + spacing.minLength)
      } else {
        // view 배치했을 때 최대 너비보다 작은 경우
        // row에 view 추가
        row.append(view)
        origin.x += (viewSize.width + spacing.minLength)
      }
    }
    
    // 마지막 row 처리
    if !row.isEmpty {
      rows.append(row)
      row.removeAll()
    }
    
    return rows
  }
}

// MARK: - Private Extension
private extension [LayoutSubviews.Element] {
  func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
    return self.compactMap { view in
      return view.sizeThatFits(proposal).height
    }.max() ?? 0
  }
}
