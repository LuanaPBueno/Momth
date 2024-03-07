//import SwiftUI
//
//
//class ChildrenViewModel: ObservableObject {
//    @Published var children = [Child]()
//    
//}
//
//struct BabyView: View {
//    @StateObject private var childrenViewModel = ChildrenViewModel()
//    @State private var isAddingChild = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("background4")
//                    .scaledToFill()
//                    .ignoresSafeArea(.all)
//                
//                VStack {
//                    Text(" ")
//                        .padding(.top, 100)
//                    Text("Your Children")
//                        .fontWeight(.bold)
//                        .font(.system(size: 35))
//                        .foregroundColor(.white)
//                        .padding(.bottom, 25)
//                    
//                    ScrollView(){
//                        VStack(spacing: 20){
//                            ForEach(childrenViewModel.children, id: \.id) { child in
//                                ChildRow(child: child)
//                            }
//                        }
//                    }
//                    .navigationBarItems(trailing:
//                                            Button(action: {
//                                                isAddingChild = true
//                                            }) {
//                                                Image(systemName: "plus")
//                                                    .foregroundColor(Color("ColorGreen2"))
//                                                
//                                            }
//                    )
//                }
//            }
//            .sheet(isPresented: $isAddingChild) {
//                ChildFormView(isAddingChild: $isAddingChild, childrenViewModel: childrenViewModel)
////                let x = childrenViewModel.children.first!.image!.pngData() ?? Data()
////                let image = Image(uiImage: UIImage(data: x) ?? UIImage(systemName: "person.fill")!)
//            }
//        }
//    }
//}
//
//struct ChildRow: View {
//    let child: Child
//    @State private var isSelected = false
//    
//    var body: some View {
//        HStack {
//            ZStack {
//                Rectangle()
//                    .frame(width: 350, height: 150)
//                    .cornerRadius(20)
//                    .foregroundColor(Color("ColorGreen"))
//                HStack{
//                    if let image = child.image {
//                        Image(uiImage: UIImage(data: image) ?? UIImage(systemName: "person.fill")!)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 120, height: 120)
//                            .clipShape(Circle())
//                            .padding(.leading, 10)
//                    }
//                    Text(" ")
//                    VStack{
//                        Text(child.name)
//                            .font(.title)
//                            .foregroundColor(.white)
//                        Text(child.age)
//                            .font(.title2)
//                            .foregroundColor(Color("ColorGreen2"))
//                        Text(child.gender)
//                            .font(.title2)
//                            .foregroundColor(Color("ColorGreen2"))
//                    }
//                }
//            }
//        }
//        .padding()
//        .onTapGesture {
//            isSelected.toggle()
//            
//        }
//        .sheet(isPresented: $isSelected) {
//            ChildFormView(child: child, isAddingChild: .constant(false), childrenViewModel: ChildrenViewModel())
//        }
//    }
//}
//
//struct ChildFormView: View {
//    @Binding var isAddingChild: Bool
//    @ObservedObject var childrenViewModel: ChildrenViewModel
//    var child: Child?
//    @State private var profileImage: UIImage?
//    @State private var isImagePickerPresented: Bool = false
//    @State private var childName: String = ""
//    @State private var childAge: String = ""
//    @State private var childGender: String = ""
//    
//    init(child: Child? = nil, isAddingChild: Binding<Bool>, childrenViewModel: ChildrenViewModel) {
//        self.child = child
//        self._isAddingChild = isAddingChild
//        self.childrenViewModel = childrenViewModel
//        
//        _childName = State(initialValue: child?.name ?? "")
//        _childAge = State(initialValue: child?.age ?? "")
//        _childGender = State(initialValue: child?.gender ?? "")
//        
//        
//        let imageData = UserDefaults.standard.data(forKey: "profileImage")
//            
//        let childImageData = self.child?.image
//        
//        if let childImageData = childImageData {
//            _profileImage = State(initialValue: UIImage(data: childImageData)!)
//            print("ACHEI PROFILE IMAGE DO CHILD")
//        }
//        else {
//            self.profileImage = UIImage(data: imageData ?? Data())
//            print("ACHEI PROFILE IMAGE DO DISCO")
//
//        }
//        
//        
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("background2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                
//                VStack{
//                    Text(" ")
//                    Text(" ")
//                    Button(action: {
//                        self.isImagePickerPresented = true
//                    }) {
//                        profileImageIcon
//                    }
//                    .sheet(isPresented: $isImagePickerPresented) {
//                        ImagePicker(selectedImage: self.$profileImage)
//                    }
//                    Spacer()
//                    
//                    TextField("First Name", text: $childName)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal,50)
//                    
//                    TextField("Age", text: $childAge)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal,50)
//                    
//                    TextField("Gender", text: $childGender)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal,50)
//                    
//                    Button("Save") {
//                        if let child = child {
//                            guard let index = childrenViewModel.children.firstIndex(where: { $0.id == child.id }) else {
//                                return
//                            }
//                            childrenViewModel.children[index] = Child(name: childName, age: childAge, gender: childGender, image: profileImage?.jpegData(compressionQuality: 1.0))
//                            
//                        } else {
//                            let newChild = Child(name: childName, age: childAge, gender: childGender, image: profileImage?.jpegData(compressionQuality: 1.0))
//                            
//                            print(profileImage?.jpegData(compressionQuality: 1.0) == nil)
//                            childrenViewModel.children.append(newChild)
//                        }
//                        isAddingChild = false
//                    }
//                    .padding()
//                    Spacer()
//                }
//                .navigationBarItems(trailing:
//                                        Button("Cancel") {
//                                            isAddingChild = false
//                                        }
//                )
//            }
//        }
//    }
//    
//    var profileImageIcon: some View {
//        ZStack{
//            Circle()
//                .foregroundColor(Color("ColorGreen"))
//                .frame(width: 170, height: 170)
//                .padding(.top,50)
//            if let profileImage = profileImage {
//                Image(uiImage: profileImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 150, height: 150)
//                    .clipShape(Circle())
//                    .shadow(radius: 20)
//                    .padding(.top,50)
//            }
//        }
//    }
//}
//
//struct ChildDetailView: View {
//    let child: Child
//    
//    var body: some View {
//        VStack {
//            Text("Detail View for \(child.name)")
//            Text("Age: \(child.age)")
//            Text("Gender: \(child.gender)")
//        }
//    }
//}
//
//struct Child: Codable  {
//    let id = UUID()
//    let name: String
//    let age: String
//    let gender: String
//    var image: Data? // Adicionando a propriedade da imagem
//}
//
//struct BabyView_Previews: PreviewProvider {
//    static var previews: some View {
//        BabyView()
//    }
//}
