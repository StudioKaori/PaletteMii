//
//  ImageColorPicker.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-10.
//

import SwiftUI

struct ImageColorPicker: View {
  @State private var bgColor =
  Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
  var body: some View {
    VStack {
      ColorPicker("", selection: $bgColor, supportsOpacity: false)
    }
  }
}

struct ImageColorPicker_Previews: PreviewProvider {
  static var previews: some View {
    ImageColorPicker()
  }
}
