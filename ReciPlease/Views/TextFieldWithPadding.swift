//
//  TextFieldWithPadding.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/24/20.
//

import UIKit

class TextFieldWithPadding: UITextField {
   
   var textPadding = UIEdgeInsets(
      top: 0,
      left: 15,
      bottom: 0,
      right: 0
   )
   
   override func textRect(forBounds bounds: CGRect) -> CGRect {
      let rect = super.textRect(forBounds: bounds)
      return rect.inset(by: textPadding)
   }
   
   override func editingRect(forBounds bounds: CGRect) -> CGRect {
      let rect = super.editingRect(forBounds: bounds)
      return rect.inset(by: textPadding)
   }
   
   
}
