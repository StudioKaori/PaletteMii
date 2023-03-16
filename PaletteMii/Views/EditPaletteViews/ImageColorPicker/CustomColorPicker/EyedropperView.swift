//
//  EyedropperView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-15.
//

import SwiftUI

struct EyedropperView: View {
  @ObservedObject var editVM: EditViewModel
  
  var body: some View {
    ZStack {
      
      Image(systemName: "circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 44, height: 44)
        .foregroundColor(Color.theme.textFieldBg)
      
      CustomColorPickerForEyedropper(editVM: editVM)
        .frame(width: 74, height: 50, alignment: .topLeading)
        .clipped()
        .offset(x: 26, y: -3)
      
    } // END: zstack

  }
}

//struct EyedropperView_Previews: PreviewProvider {
//    static var previews: some View {
//        EyedropperView()
//    }
//}
