//
//  GenerateFromImageView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-15.
//

import SwiftUI

struct GenerateFromImageView: View {
  @ObservedObject var EditVM = EditViewModel()
  var body: some View {
    VStack {
      ImageColorPickerView()
      
      HStack {
        ForEach(0 ..< EditVM.pickerColors.count) { index in
          EyedropperView(bgColor: .white, at: index)
        }
      }
  
    }
  }
}

struct GenerateFromImageView_Previews: PreviewProvider {
  static var previews: some View {
    GenerateFromImageView()
  }
}
