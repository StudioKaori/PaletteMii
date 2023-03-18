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
  
  let columns = [
    GridItem(.fixed(50)),
    GridItem(.fixed(50)),
    GridItem(.fixed(50)),
    GridItem(.fixed(50)),
    GridItem(.fixed(50)),
    GridItem(.fixed(50))
  ]
  
  var body: some View {
    VStack {
      ImageColorPickerView()
      
      LazyVGrid(columns: columns) {
        ForEach(Array(editVM.pickerColors.enumerated()), id: \.element.id) { index, pickerColor in
          Button {
            self.isShowColorPicker.toggle()
            editVM.editTargetPickerColorIndex = index
          } label: {
            Circle()
              .foregroundColor(pickerColor.color)
              .frame(width: 46, height: 46)
          }
          .frame(width: 46, height: 46)
          .onDrag {
            editVM.currentPickerColor = pickerColor
            return NSItemProvider(contentsOf: URL(string: "\(pickerColor.id)")!)!
          }
          .onDrop(of: [.url], delegate:
                    DropViewDelegate(pickerColor: pickerColor,
                                     editVM: editVM))
        }
        
        EyedropperView(editVM: editVM)
      }
    }
    .sheet(isPresented: $isShowColorPicker) {
      EditPickerColorView(editVM: editVM, isShowColorPicker: $isShowColorPicker)
    } // END: sheet
  }
}

struct GenerateFromImageView_Previews: PreviewProvider {
  static var previews: some View {
    GenerateFromImageView()
  }
}


// MARK: - drag and drop delegate
struct DropViewDelegate: DropDelegate {
  var pickerColor: PickerColor
  var editVM: EditViewModel
  
  func performDrop(info: DropInfo) -> Bool {
    return true
  }
  
  func dropEntered(info: DropInfo) {
    //from
    let fromIndex = editVM.pickerColors.firstIndex { (item) -> Bool in
      return item.id == editVM.currentPickerColor?.id
    } ?? 0
    
    //to
    let toIndex = editVM.pickerColors.firstIndex { (item) -> Bool in
      return item.id == self.pickerColor.id
    } ?? 0
    
    if fromIndex != toIndex {
      withAnimation(.default) {
        let formPage = editVM.pickerColors[fromIndex]
        editVM.pickerColors[fromIndex] = editVM.pickerColors[toIndex]
        editVM.pickerColors[toIndex] = formPage
      }
    }
  }
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    return DropProposal(operation: .move)
  }
}
