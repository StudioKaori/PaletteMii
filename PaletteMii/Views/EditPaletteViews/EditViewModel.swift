//
//  EditViewModel.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-13.
//

import SwiftUI

class EditViewModel: ObservableObject {
  @Published var pickerColors: [Color] = [.clear, .clear, .clear, .clear, .clear]
  
  func deleteColor(at: Int) {
    
  }
}
