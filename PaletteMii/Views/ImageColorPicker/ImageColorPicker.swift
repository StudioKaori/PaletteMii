//
//  ImageColorPicker.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-10.
//

import SwiftUI

struct ImageColorPicker: View {
  @State private var bgColor =
  Color(.white)
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
