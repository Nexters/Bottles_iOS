//
//  View+Padding.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension View {
  func padding(_ edges: Edge.Set = .all, _ paddingType: BottlePaddingType? = nil) -> some View {
    self.padding(edges, paddingType?.length)
  }
  
  func padding(_ paddingType: BottlePaddingType) -> some View {
    self.padding(paddingType.length)
  }
}
