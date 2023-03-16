//
//  CustomColorPicker.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-11.
//
//  Video https://www.youtube.com/watch?v=J9-4WM74p2Q

import SwiftUI

// MARK: -cutsom Color picker with the help of UIColor picker
struct CustomColorPicker: UIViewControllerRepresentable {
  
  var editVM: EditViewModel
  var pickerColor: PickerColor
  let isEditMode: Bool
  
  init(editVM: EditViewModel, pickerColor: PickerColor) {
    print("init edit")
    self.editVM = editVM
    self.pickerColor = pickerColor
    self.isEditMode = true
  }
  
  init(editVM: EditViewModel) {
    self.editVM = editVM
    self.pickerColor = PickerColor(color: .clear)
    self.isEditMode = false
    print("init new: \(self.pickerColor.id)")
  }
  
  // This event is called before UIKit view is called, and execute the initialiser
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    
    let picker = UIColorPickerViewController()
    picker.supportsAlpha = false
    
    // connecting delegate
    picker.delegate = context.coordinator
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
  
  // MARK: - Delegate methods
  class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
    
    // The management subject of UIkit view
    var parent: CustomColorPicker
    
    init(parent: CustomColorPicker) {
      self.parent = parent
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
      print("colorPickerViewController0")
      //parent.pickerColor.color = Color(viewController.selectedColor)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
      
      if parent.isEditMode {
        print("colorPickerViewController21  :\(Color(color).description)")
        parent.pickerColor.color = Color(color)
      } else {
        print("colorPickerViewController22:  \(Color(color).description)")
        parent.pickerColor = PickerColor(color: Color(color))
        parent.editVM.pickerColors.append(parent.pickerColor)
      }
      //print("colorPickerViewController2: \(parent.editVM.pickerColors)")
    }
  }
}
