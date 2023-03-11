//
//  ImageColorPickerView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-11.
//

import SwiftUI

struct ImageColorPickerView: View {
  // For image picker
  @State private var image = Image(systemName: "photo")
  @State var imageData: Data = .init(capacity:0)
  @State var isImagePicker = false
  @State var source:UIImagePickerController.SourceType = .photoLibrary
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      if let data = imageData, let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        Image(systemName: "photo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .foregroundColor(Color.theme.textFieldBg)
          .frame(width: 300)
      }
      
      ImageUploaderView(imageData: $imageData,
                        source: $source,
                        isImagePicker: $isImagePicker)
      .padding()
    }
  }
}

struct ImageColorPickerView_Previews: PreviewProvider {
  static var previews: some View {
    ImageColorPickerView()
  }
}
