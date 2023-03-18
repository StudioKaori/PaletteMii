//
//  EditViewModel.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-13.
//

import SwiftUI

class EditViewModel: ObservableObject {
  @Published var currentPickerColor: PickerColor?
  @Published var pickerColors: [PickerColor] = []
  
  var editSelectedColor: Color = .clear
  var editTargetPickerColorIndex = 0
}

struct PickerColor: Identifiable, Hashable {
  let id: UUID = UUID()
  var color: Color
}
