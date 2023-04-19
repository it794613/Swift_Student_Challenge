//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/13.
//

import SwiftUI


extension CGSize {
  static func + (lhs: Self, rhs: Self) -> Self {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
  }
}
