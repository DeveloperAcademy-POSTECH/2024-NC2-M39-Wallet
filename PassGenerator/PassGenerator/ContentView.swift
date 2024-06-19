import SwiftUI
import UIKit

struct ContentView: View {
    @State private var passName: String = ""
    @State private var memo: String = ""
    @State private var barcodeNum: String = ""
    @State private var showDocumentPicker = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedFormat: String = "PKBarcodeFormatQR"

    let formats = ["PKBarcodeFormatQR", "PKBarcodeFormatPDF417", "PKBarcodeFormatAztec"]

    var body: some View {
        VStack {
            // Header
            VStack(alignment: .leading) {
                Text("Pass Maker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text("쿠폰, 티켓, 항공권 등 원하는 티켓을")
                    .font(.callout)
                    .foregroundColor(.gray)
                Text("Apple Wallet에 추가할 수 있습니다.")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }
            .padding()
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Icon
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 157, height: 113)
                    .padding(20)
            } else {
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .frame(width: 157, height: 113)
                        .padding(20)
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }

            // Text Fields
            VStack(alignment: .leading, spacing: 15) {
                CustomTextField(title: "패스 이름", text: $passName, placeholder: "패스이름을 입력해주세요.")
                CustomTextField(title: "바코드 번호", text: $barcodeNum, placeholder: "바코드 번호")
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("포맷 선택")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    
                    Menu {
                        ForEach(formats, id: \.self) { format in
                            Button(action: {
                                selectedFormat = format
                            }) {
                                Text(format)
                            }
                        }
                    } label: {
                            Text(selectedFormat)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
            }
            .padding(.horizontal)

            // 컬러 선택기
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("쿠폰 컬러")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    HStack {
                        Text("배경")
                        ColorPicker("", selection: .constant(Color.red))
                            .labelsHidden()
                    }
                    HStack {
                        Text("텍스트 컬러")
                        ColorPicker("", selection: .constant(Color.green))
                            .labelsHidden()
                    }
                }
                .padding(.horizontal)
            }
            .padding()


            // Pass 만들기 버튼
            Button(action: {
                showDocumentPicker.toggle()
            }) {
                HStack {
                    Image(systemName: "wallet.pass") // Wallet 이미지
                        .frame(alignment: .leading)
                        .padding(.trailing, 10)
                    Text("패스 만들기")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker()
            }

        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

// Custom TextField View
struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 1)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .foregroundColor(.black)
        }
    }
}

// Document Picker
struct DocumentPicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.data])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else {
                return
            }

            // Here you can handle the selected pkpass file
            // For example, you can pass it to PassKit to add to the wallet
            print("Selected file URL: \(selectedFileURL)")

            // Add to Apple Wallet logic goes here
        }
    }
}

// Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ContentView()
}
