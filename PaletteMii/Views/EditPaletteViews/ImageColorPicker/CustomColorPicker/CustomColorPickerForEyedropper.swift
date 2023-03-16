//
//  CustomColorPickerForEyedropper.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-16.
//

import SwiftUI

// MARK: -cutsom Color picker with the help of UIColor picker
struct CustomColorPickerForEyedropper: UIViewControllerRepresentable {
  
  var editVM: EditViewModel
  
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
    var parent: CustomColorPickerForEyedropper
    
    init(parent: CustomColorPickerForEyedropper) {
      self.parent = parent
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
      // This is not called in customer color picker
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
      
      let newPickerColor = PickerColor(color: Color(color))
      parent.editVM.pickerColors.append(newPickerColor)
      //print("colorPickerViewController2: \(parent.editVM.pickerColors)")
    }
  }
}

