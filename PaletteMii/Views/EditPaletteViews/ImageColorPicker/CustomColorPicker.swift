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
  
  // MARK: picker values
//  var pickerColor: PickerColor
//  @Binding var isSelected: Bool
  
  let editVM: EditViewModel
  let pickerColor: PickerColor
  
  // This event is called before UIKit view is called, and execute the initialiser
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    
    let picker = UIColorPickerViewController()
    picker.supportsAlpha = false
    //picker.selectedColor = UIColor(color)
    
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
      // Updating color
      //parent.pickerColor.color = Color(viewController.selectedColor)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
      //parent.pickerColor.color = Color(color)
      //parent.isSelected = true
      parent.editVM.pickerColors.append(PickerColor(color: Color(viewController.selectedColor)))
    }
  }
}
