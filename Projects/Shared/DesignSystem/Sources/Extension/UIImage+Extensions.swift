//
//  UIImage+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/13/24.
//

import UIKit

public extension UIImage {
  func compressImageData(targetMB: Double = 1.0) -> Data? {
    guard var imageSize = self.jpegData(compressionQuality: 0.8)?.count else { return nil }
    let resizeLength = 2048
    var compressedImage: UIImage? = self
    var resizeScale = 1.0
    while Double(imageSize) > targetMB * pow(2, 20) {
      compressedImage = self.resized(toLength: Double(resizeLength) * resizeScale)
      imageSize = compressedImage?.jpegData(compressionQuality: 0.8)?.count ?? 0
      resizeScale = 0.75
    }
    
    return compressedImage?.jpegData(compressionQuality: 0.8)
  }
  
  func resized(toLength length: CGFloat) -> UIImage? {
    let canvasSize = size.width > size.height
    ? CGSize(
      width: length,
      height: CGFloat(ceil(length/size.width * size.height))
    )
    : CGSize(
      width: CGFloat(ceil(length/size.height * size.width)),
      height: length
    )
    
    UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(origin: .zero, size: canvasSize))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
