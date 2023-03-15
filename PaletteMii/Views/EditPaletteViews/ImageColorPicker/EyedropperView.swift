//
//  EyedropperView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-15.
//

import SwiftUI

struct EyedropperView: View {
  //let bgColor: Color
  //var pickerColor: PickerColor
  @ObservedObject var editVM: EditViewModel
  //@State var color: Color =
  //@State var isSelected: Bool = false
  
  var body: some View {
    ZStack {
      
//      Circle()
////        .foregroundColor(pickerColor.color)
////        .frame(width: 46, height: 46)
      
      Image(systemName: "circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 44, height: 44)
        .foregroundColor(Color.theme.textFieldBg)
      
      CustomColorPicker(editVM: editVM)
        .frame(width: 74, height: 50, alignment: .topLeading)
        .clipped()
        .offset(x: 26, y: -3)
      
//      if !isSelected {
//
//      } else {
//        Button {
//          isShowColorPicker.toggle()
//        } label: {
//          Circle()
//            .foregroundColor(pickerColor.color)
//            .frame(width: 46, height: 46)
//        }
//
//      }
      
    } // END: zstack

  }
}

//struct EyedropperView_Previews: PreviewProvider {
//    static var previews: some View {
//        EyedropperView()
//    }
//}
