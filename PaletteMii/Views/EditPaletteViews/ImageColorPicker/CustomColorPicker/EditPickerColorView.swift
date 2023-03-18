//
//  EditPickerColorView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-18.
//

import SwiftUI

struct EditPickerColorView: View {
  let editVM: EditViewModel
  @Binding var isShowColorPicker: Bool
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      CustomColorPicker(editVM: editVM)
      
      HStack {
        // Delete button
        Button {
          editVM.pickerColors.remove(at: editVM.editTargetPickerColorIndex)
          self.isShowColorPicker = false
        } label: {
          Image(systemName: "trash.circle")
            .font(.system(size: 24))
            .foregroundColor(Color.theme.primaryText)
        }
        
        // Close custom color picker button
        Button {
          editVM.pickerColors[editVM.editTargetPickerColorIndex].color = editVM.editSelectedColor
          self.isShowColorPicker = false
        } label: {
          Image(systemName: "xmark.circle")
            .font(.system(size: 24))
            .foregroundColor(Color.theme.primaryText)
        }
      }
      .padding()
    }
    .presentationDetents([.height(550)])
  }
}

struct EditPickerColorView_Previews: PreviewProvider {
  static var previews: some View {
    EditPickerColorView(editVM: EditViewModel(), isShowColorPicker: .constant(true))
  }
}
