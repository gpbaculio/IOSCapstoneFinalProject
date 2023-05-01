import SwiftUI
import CoreData

struct ProfileView: View {
    @State private var imagePath: String? = nil
    @State private var showImagePicker = false
    @State private var imageUpdated = false // added state variable
    @AppStorage("profileImage") private var profileImage: Data = Data()
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("email") var email = ""


    private var imageURL: URL? {
        
        guard !profileImage.isEmpty else { return nil }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         let imageURL = documentsDirectory.appendingPathComponent("profileImage.jpg")
         
         do {
             try profileImage.write(to: imageURL)
             return imageURL
         } catch {
             print("Error writing image data to disk: \(error.localizedDescription)")
             return nil
         }
    }

    var body: some View {
        VStack {
            if let imageURL = imageURL,
               let imageData = try? Data(contentsOf: imageURL),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200) 
                    .clipShape(Circle())
                    .id(imageUpdated)
                    .padding(.bottom, 18)
            }
            
            Button(action: {
                self.showImagePicker = true
            }) {
                Text(imageURL != nil ? "Change Image" : "Select Image")
                    .padding()
                    .background(mainColor)
                    .foregroundColor(secondaryColor)
                    .cornerRadius(10)
                    .fontWeight(.medium)
            }
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top, 6)
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top, 6)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 6)
                .padding(.bottom, 12)
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.saveImageToDisk(image)
                self.imageUpdated.toggle() // added toggle to update view
            }
        }
        .padding(.horizontal, 30)
        .background(mainBg)
        .padding(.bottom, 15)
    }

    private func saveImageToDisk(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "profileImage")
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias UIImagePickerResult = (UIImage) -> Void

    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: UIImagePickerResult

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let onImagePicked: UIImagePickerResult

        init(onImagePicked: @escaping UIImagePickerResult) {
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
            if let image = selectedImage {
                onImagePicked(image)
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
