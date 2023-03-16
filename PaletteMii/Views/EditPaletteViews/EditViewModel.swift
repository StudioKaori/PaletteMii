//
//  EditViewModel.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-13.
//

import SwiftUI

class EditViewModel: ObservableObject {
  @Published var pickerColors: [PickerColor] = []
}

struct PickerColor: Identifiable {
  let id: UUID = UUID()
  var color: Color
}
