//
//  CustomColorPicker.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-11.
//
//  Video https://www.youtube.com/watch?v=J9-4WM74p2Q

import SwiftUI

// MARK: - Custom View for color picker
struct EyedropperView: View {
  let bgColor: Color
  let at: Int
  @ObservedObject var EditVM = EditViewModel()
  //@State var color: Color =
  @State var isSelected: Bool = false
  @State var isShowColorPicker: Bool = false
  
  var body: some View {
    ZStack {
      
      Circle()
        .foregroundColor(EditVM.pickerColors[at])
        .frame(width: 46, height: 46)
      
      Image(systemName: "circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 44, height: 44)
        .foregroundColor(Color.theme.textFieldBg)
      if !isSelected {
        CustomColorPicker(color: $EditVM.pickerColors[at], isSelected: $isSelected)
          .frame(width: 74, height: 50, alignment: .topLeading)
          .clipped()
          .offset(x: 26, y: -3)
      } else {
        Button {
          isShowColorPicker.toggle()
        } label: {
          Circle()
            .foregroundColor(EditVM.pickerColors[at])
            .frame(width: 46, height: 46)
        }
        
      }
      
    } // END: zstack
    .sheet(isPresented: $isShowColorPicker) {
      ZStack(alignment: .topTrailing) {
        CustomColorPicker(color: $EditVM.pickerColors[at], isSelected: $isSelected)

        HStack {
          // Delete button
          Button {
            EditVM.pickerColors.remove(at: at)
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

// MARK: -cutsom Color picker with the help of UIColor picker
struct CustomColorPicker: UIViewControllerRepresentable {
  
  // MARK: picker values
  @Binding var color: Color
  @Binding var isSelected: Bool
  
  // This event is called before UIKit view is called, and execute the initialiser
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    
    let picker = UIColorPickerViewController()
    picker.supportsAlpha = false
    picker.selectedColor = UIColor(color)
    
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
      parent.color = Color(viewController.selectedColor)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
      parent.color = Color(color)
      parent.isSelected = true
    }
  }
}
