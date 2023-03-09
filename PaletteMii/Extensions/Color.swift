//
//  Color.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-09.
//

import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let primaryText = Color("PrimaryText")
  let listDivider = Color("ListDivider")
  let textFieldFont = Color("TextFieldFont")
  let textFieldIcon = Color("TextFieldIcon")
  let textFieldBg = Color("TextFieldBg")
}
