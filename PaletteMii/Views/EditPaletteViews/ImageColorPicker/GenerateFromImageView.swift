//
//  GenerateFromImageView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-15.
//

import SwiftUI

struct GenerateFromImageView: View {
  @ObservedObject var editVM = EditViewModel()
  @State var isShowColorPicker: Bool = false
  
  func move(from source: IndexSet, to destination: Int) {
    editVM.pickerColors.move(fromOffsets: source, toOffset: destination)
  }
  
  var body: some View {
    VStack {
      ImageColorPickerView()
      
      HStack {
        ForEach(editVM.pickerColors) { pickerColor in
          Button {
            self.isShowColorPicker.toggle()
          } label: {
            Circle()
              .foregroundColor(pickerColor.color)
              .frame(width: 46, height: 46)
          }
        }
        .onMove(perform: move)
        
        EyedropperView(editVM: editVM)
        Spacer()
      }
    }
    .sheet(isPresented: $isShowColorPicker) {
      ZStack(alignment: .topTrailing) {
        CustomColorPicker(editVM: editVM)
        
        HStack {
          // Delete button
          Button {
            //editVM.pickerColors.remove(pickerColor)
          } label: {
            Image(systemName: "trash.circle")
              .font(.system(size: 24))
              .foregroundColor(Color.theme.primaryText)
          }
          
          // Close custom color picker button
          Button {
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
    } // END: sheet
  }
}

//struct GenerateFromImageView_Previews: PreviewProvider {
//  static var previews: some View {
//    GenerateFromImageView()
//  }
//}
