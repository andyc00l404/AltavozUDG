import SwiftUI

// MARK: - Modelo de Página de Onboarding
struct OnboardingPage: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var imageName: String
    var bgColor: Color
    var accentColor: Color
}

// MARK: - Vista de Onboarding Integrada con Registro Individual
struct OnboardingView: View {
    // Binding para indicar que el flujo completo se terminó
    @Binding var onboardingComplete: Bool
    
    // Páginas de onboarding (antes del registro)
    let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "¡Hola! Somos AltavozUDG",
            description: "Tu voz importa. Aquí podrás hacer que la UDG sea un espacio donde todxs nos sintamos parte.",
            imageName: "megaphone.fill",
            bgColor: Color(hexString: "2E6DE5"),
            accentColor: .white
        ),
        OnboardingPage(
            title: "Reporta obstáculos",
            description: "¿Una rampa que no funciona? Toma una foto, marca en el mapa y ¡listo!",
            imageName: "exclamationmark.triangle.fill",
            bgColor: Color(hexString: "FF6B6B"),
            accentColor: .white
        ),
        OnboardingPage(
            title: "Descubre espacios inclusivos",
            description: "Encuentra baños neutros, salas de lactancia, áreas accesibles y más.",
            imageName: "map.fill",
            bgColor: Color(hexString: "5A7D5A"),
            accentColor: .white
        ),
        OnboardingPage(
            title: "Conéctate con tu gente",
            description: "Grupos de apoyo, estudiantes internacionales, comunidades indígenas, etc.",
            imageName: "person.3.fill",
            bgColor: Color(hexString: "3B5998"),
            accentColor: .white
        ),
        OnboardingPage(
            title: "Alza la voz, sin miedo",
            description: "¿Discriminación o acoso? Repórtalo de forma anónima y segura.",
            imageName: "bubble.left.and.exclamationmark.bubble.right.fill",
            bgColor: Color(hexString: "845EC2"),
            accentColor: .white
        )
    ]
    
    // Definimos 3 pasos de registro (plantel, rol, código)
    var registrationSteps: Int { 3 }
    var totalSteps: Int { pages.count + registrationSteps }
    
    // Estados para el flujo y animaciones
    @State private var currentPage = 0
    @State private var isAnimating = false
    
    // Variables de registro
    @State private var selectedCampus = "CuValles"
    @State private var selectedRole = "Alumno"
    @State private var code: String = ""
    
    // Datos para las tarjetas de campus
    let campuses = ["CuValles", "CuTonala", "CUCSH"]
    let campusImages = ["building.columns.fill", "building.2.fill", "books.vertical.fill"]
    let campusColors = [Color(hexString: "4A9FFF"), Color(hexString: "FF9A8B"), Color(hexString: "6FE7DD")]
    let campusDescriptions = [
        "Centro Universitario de los Valles",
        "Centro Universitario de Tonalá",
        "Centro de Ciencias Sociales y Humanidades"
    ]
    
    // Datos para las tarjetas de rol
    let roles = ["Profesor", "Alumno"]
    let roleImages = ["person.fill.badge.plus", "graduationcap.fill"]
    let roleColors = [Color(hexString: "845EC2"), Color(hexString: "FF9A8B")]
    let roleDescriptions = [
        "Docente, investigador o personal administrativo",
        "Estudiante activo de la universidad"
    ]
    
    var body: some View {
        // Fondo según la página actual
        let bgGradient: LinearGradient = {
            if currentPage < pages.count {
                let page = pages[currentPage]
                return LinearGradient(
                    gradient: Gradient(colors: [
                        page.bgColor,
                        page.bgColor.opacity(0.6),
                        Color(hexString: "4A9FFF").opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                // Fondo para el registro
                return LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hexString: "2E6DE5"),
                        Color(hexString: "2E6DE5").opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }()
        
        ZStack {
            bgGradient
                .ignoresSafeArea()
            
            // Elementos decorativos
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hexString: "FF9A8B").opacity(0.2),
                                    Color(hexString: "FF9A8B").opacity(0.05)
                                ]),
                                center: .center,
                                startRadius: 0,
                                endRadius: geometry.size.width * 0.5
                            )
                        )
                        .frame(width: geometry.size.width * 0.6)
                        .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.85)
                    
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hexString: "FFFD87").opacity(0.2),
                                    Color(hexString: "FFFD87").opacity(0.05)
                                ]),
                                center: .center,
                                startRadius: 0,
                                endRadius: geometry.size.width * 0.3
                            )
                        )
                        .frame(width: geometry.size.width * 0.4)
                        .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.2)
                    
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hexString: "6FE7DD").opacity(0.15),
                                    Color(hexString: "6FE7DD").opacity(0.03)
                                ]),
                                center: .center,
                                startRadius: 0,
                                endRadius: geometry.size.width * 0.2
                            )
                        )
                        .frame(width: geometry.size.width * 0.3)
                        .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.7)
                }
            }
            
            VStack {
                // Botón "Saltar" (lleva directamente al último paso de registro)
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            currentPage = totalSteps - 1
                        }
                    }) {
                        Text("Saltar")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.2))
                                    .background(Capsule().stroke(Color.white, lineWidth: 1.5))
                            )
                    }
                    .padding(.trailing, 25)
                    .padding(.top, 25)
                }
                
                Spacer()
                
                // Contenido: Onboarding o Registro según currentPage
                if currentPage < pages.count {
                    // Páginas de onboarding
                    VStack(spacing: 40) {
                        if currentPage == 0 {
                            HStack(spacing: 15) {
                                Image(systemName: "megaphone.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .foregroundColor(.white)
                                    .shadow(color: Color(hexString: "FF9A8B").opacity(0.7), radius: 15)
                                Text("AltavozUDG")
                                    .font(.system(size: 36, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color(hexString: "FF9A8B").opacity(0.7), radius: 10)
                            }
                            .padding(.bottom, 20)
                            .scaleEffect(isAnimating ? 1 : 0.9)
                            .opacity(isAnimating ? 1 : 0.8)
                            .animation(Animation.spring(response: 0.5, dampingFraction: 0.6).delay(0.1), value: isAnimating)
                        }
                        
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.3),
                                            Color.white.opacity(0.15),
                                            Color(hexString: "FFDFBA").opacity(0.1)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 220, height: 220)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                            
                            Image(systemName: pages[currentPage].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(pages[currentPage].accentColor)
                                .shadow(color: Color(hexString: "FF9A8B").opacity(0.5), radius: 10, x: 0, y: 5)
                                .overlay(
                                    ZStack {
                                        Color.white.opacity(0.2)
                                            .blur(radius: 20)
                                            .frame(width: 40, height: 40)
                                            .rotationEffect(.degrees(45))
                                            .offset(x: isAnimating ? 45 : -45, y: isAnimating ? -45 : 45)
                                            .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
                                    }
                                )
                        }
                        .scaleEffect(isAnimating ? 1 : 0.8)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(Animation.spring(response: 0.5, dampingFraction: 0.6).delay(0.2), value: isAnimating)
                        
                        VStack(spacing: 25) {
                            Text(pages[currentPage].title)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .shadow(color: Color.black.opacity(0.1), radius: 2)
                                .scaleEffect(isAnimating ? 1 : 0.9)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(Animation.spring(response: 0.5, dampingFraction: 0.6).delay(0.3), value: isAnimating)
                            
                            Text(pages[currentPage].description)
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .lineSpacing(5)
                                .padding(.horizontal, 30)
                                .fixedSize(horizontal: false, vertical: true)
                                .shadow(color: Color.black.opacity(0.1), radius: 2)
                                .scaleEffect(isAnimating ? 1 : 0.9)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(Animation.spring(response: 0.5, dampingFraction: 0.6).delay(0.4), value: isAnimating)
                        }
                    }
                } else {
                    // Registro: pasos individuales mejorados
                    if currentPage == pages.count {
                        // Paso 1: Selección de plantel (MEJORADO CON TARJETAS)
                        VStack(spacing: 20) {
                            Text("Selecciona tu plantel UDG")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            // Tarjetas de selección de campus
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<campuses.count, id: \.self) { index in
                                        CampusCard(
                                            name: campuses[index],
                                            description: campusDescriptions[index],
                                            imageName: campusImages[index],
                                            color: campusColors[index],
                                            isSelected: selectedCampus == campuses[index],
                                            action: {
                                                withAnimation(.spring()) {
                                                    selectedCampus = campuses[index]
                                                }
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.vertical)
                    }
                    else if currentPage == pages.count + 1 {
                        // Paso 2: Selección de rol (MEJORADO CON TARJETAS INTERACTIVAS)
                        VStack(spacing: 20) {
                            Text("Selecciona tu rol")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            // Tarjetas de rol en horizontal
                            HStack(spacing: 16) {
                                ForEach(0..<roles.count, id: \.self) { index in
                                    RoleCard(
                                        title: roles[index],
                                        description: roleDescriptions[index],
                                        imageName: roleImages[index],
                                        color: roleColors[index],
                                        isSelected: selectedRole == roles[index],
                                        action: {
                                            withAnimation(.spring()) {
                                                selectedRole = roles[index]
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical)
                    } else if currentPage == pages.count + 2 {
                        // Paso 3: Ingreso de código (MEJORADO VISUALMENTE)
                        VStack(spacing: 25) {
                            Text("Ingresa tu código")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            // Campo de código estilizado
                            VStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "qrcode")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.system(size: 22))
                                    
                                    TextField("", text: $code)
                                        .placeholder(when: code.isEmpty) {
                                            Text("Código de estudiante/profesor")
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .accentColor(.white)
                                        .autocapitalization(.none)
                                        .keyboardType(.numberPad)
                                        .padding(.leading, 8)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.2))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                        )
                                )
                                
                                Text("Ingresa el código proporcionado por tu institución")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .padding(.horizontal, 30)
                            
                            // Sección para escanear código QR (simulada)
                            Button(action: {
                                // Aquí iría la acción para escanear QR (si lo necesitas)
                            }) {
                                HStack {
                                    Image(systemName: "qrcode.viewfinder")
                                        .font(.system(size: 18))
                                    Text("Escanear código QR")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.15))
                                )
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                // Indicadores y botón de navegación
                VStack(spacing: 30) {
                    HStack(spacing: 10) {
                        ForEach(0..<totalSteps, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.white : Color.white.opacity(0.2))
                                .frame(width: 10, height: 10)
                                .scaleEffect(currentPage == index ? 1.2 : 1)
                                .shadow(color: currentPage == index ? Color.white.opacity(0.6) : Color.clear, radius: 3)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        if currentPage < totalSteps - 1 {
                            withAnimation {
                                currentPage += 1
                                isAnimating = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isAnimating = true
                                }
                            }
                        } else {
                            // En la última página (código), se completa el flujo si el código no está vacío
                            if !code.isEmpty {
                                onboardingComplete = true
                            }
                        }
                    }) {
                        HStack(spacing: 10) {
                            Text(currentPage < totalSteps - 1 ? "Siguiente" : "Completar")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Image(systemName: currentPage < totalSteps - 1 ? "chevron.right" : "hand.thumbsup.fill")
                                .font(.system(size: 18, weight: .bold))
                        }
                        .foregroundColor(currentPage < pages.count ? pages[currentPage].bgColor : Color(hexString: "2E6DE5"))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 5)
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isAnimating = true
            }
        }
        .onChange(of: currentPage) { _ in
            isAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Componente de Tarjeta de Campus
struct CampusCard: View {
    let name: String
    let description: String
    let imageName: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 15) {
                // Imagen y encabezado
                HStack {
                    Image(systemName: imageName)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                    }
                }
                
                // Información del campus
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(description)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(width: 200, height: 160)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color,
                                color.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
                            .brightness(0.1)
                    )
                    .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Componente de Tarjeta de Rol
struct RoleCard: View {
    let title: String
    let description: String
    let imageName: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                // Icono principal
                Image(systemName: imageName)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 3)
                
                // Información del rol
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    .lineLimit(2)
                
                // Indicador de selección
                if isSelected {
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                        Text("Seleccionado")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 15)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                    )
                    .padding(.top, 10)
                }
            }
            .frame(width: 160, height: 220)
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color,
                                color.opacity(0.8)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
                    )
                    .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Extensión para Placeholder en TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - Extensión para Color desde Hexadecimal
extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - ContentView
struct ContentView: View {
    @State private var onboardingComplete = false
    
    var body: some View {
        NavigationView {
            Group {
                if !onboardingComplete {
                    OnboardingView(onboardingComplete: $onboardingComplete)
                        .transition(.opacity)
                } else {
                    // Redirige a la vista de registro exitoso
                    FinalView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: onboardingComplete)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Vista de Registro Exitoso
struct FinalView: View {
    // Este estado permitirá navegar a la vista principal
    @State private var navigateToMainApp = false
    
    var body: some View {
        ZStack {
            // Fondo con gradiente
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hexString: "2E6DE5"),
                    Color(hexString: "4A9FFF")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Elementos decorativos
            GeometryReader { geometry in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: geometry.size.width * 0.8)
                    .position(x: geometry.size.width * 0.1,
                              y: geometry.size.height * 0.9)
                
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: geometry.size.width * 0.4)
                    .position(x: geometry.size.width * 0.85,
                              y: geometry.size.height * 0.15)
            }
            
            // Contenido principal
            VStack(spacing: 30) {
                // Animación de éxito
                SuccessAnimation()
                    .frame(width: 180, height: 180)
                    .padding(.top, 20)
                
                // Texto de bienvenida
                VStack(spacing: 16) {
                    Text("¡Bienvenido a\nAltavozUDG!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Tu registro se ha completado con éxito")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                // Tarjeta informativa
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        Image(systemName: "megaphone.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Color(hexString: "2E6DE5"))
                        
                        Text("¡Ahora formas parte\nde la comunidad!")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hexString: "2E6DE5"))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.top, 5)
                    
                    Text("Tu voz es importante para mejorar nuestra universidad. Explora la app y descubre todas las formas en que puedes contribuir a un campus más inclusivo y accesible.")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(Color(hexString: "4A5568"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 10)
                }
                .padding(25)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 5)
                )
                .padding(.horizontal, 25)
                
                Spacer()
                
                // Botón para continuar
                Button(action: {
                    // Aquí activamos la navegación a la vista principal
                    navigateToMainApp = true
                }) {
                    HStack(spacing: 12) {
                        Text("COMENZAR")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 50)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hexString: "FF6B6B"),
                                        Color(hexString: "FF8E8E")
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: Color(hexString: "FF6B6B").opacity(0.5), radius: 10, x: 0, y: 5)
                    )
                }
                .padding(.bottom, 40)
                
                // Esta es la navegación: cuando navigateToMainApp sea true, se activará
                NavigationLink(
                    destination: MainAppView(),
                    isActive: $navigateToMainApp,
                    label: { EmptyView() }
                )
            }
            .padding()
        }
    }
}

// MARK: - Animación de Éxito
struct SuccessAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Círculo exterior
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 15)
            
            // Círculo animado
            Circle()
                .trim(from: 0, to: isAnimating ? 1 : 0)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hexString: "6FE7DD"),
                            Color.white
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(Animation.easeOut(duration: 1.2).delay(0.3), value: isAnimating)
            
            // Círculo central
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.8),
                            Color.white.opacity(0.4)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 100, height: 100)
                .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
                .scaleEffect(isAnimating ? 1 : 0.5)
                .animation(Animation.spring(response: 0.6, dampingFraction: 0.6).delay(0.6), value: isAnimating)
            
            // Icono de check
            Image(systemName: "checkmark")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color(hexString: "2E6DE5"))
                .offset(y: isAnimating ? 0 : 20)
                .opacity(isAnimating ? 1 : 0)
                .animation(Animation.spring(response: 0.6, dampingFraction: 0.6).delay(0.9), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Componente para botones de sección
struct SectionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Acción para cada sección
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(color)
                    .frame(width: 36, height: 36)
                    .background(
                        Circle()
                            .fill(color.opacity(0.15))
                    )
                
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hexString: "2D3748"))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(hexString: "A0AEC0"))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

 

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
