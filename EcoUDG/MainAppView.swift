import SwiftUI

// MARK: - Vista Principal Dashboard
struct MainAppView: View {
    // Estados para gestionar la UI
    @State private var selectedTab: Int = 0
    @State private var showNotifications: Bool = false
    @State private var showProfile: Bool = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    // Datos simulados para notificaciones
    @State private var hasUnreadNotifications: Bool = true
    
    // Colores de tema
    let primaryColor: Color = Color(hex: "2E6DE5")
    let secondaryColor: Color = Color(hex: "4A9FFF")
    let backgroundColor: Color = Color(hex: "F7F9FC")
    
    var body: some View {
        ZStack {
            // Fondo con gradiente sutíl
            backgroundColor.ignoresSafeArea()
            
            // Contenido principal en TabView
            VStack(spacing: 0) {
                // Barra superior personalizada
                customNavigationBar
                
                // Área de búsqueda
                if isSearching {
                    searchBar
                }
                
                // Contenido principal que cambia según la pestaña seleccionada
                TabView(selection: $selectedTab) {
                    // Tab 1: Inicio (Dashboard)
                    ScrollView {
                        VStack(spacing: 25) {
                            // Banner destacado
                            featuredBanner
                            
                            // Acciones rápidas
                            quickActionsGrid
                            
                            // Reportes recientes
                            recentReportsSection
                            
                            // Próximos eventos
                            upcomingEventsSection
                            
                            // Espacios inclusivos
                            inclusiveSpacesSection
                            
                            // Estadísticas de impacto
                            impactStatsSection
                            
                            // Espacio para botón flotante
                            Color.clear.frame(height: 70)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                    .tag(0)
                    
                    // Tab 2: Mapa
                    ZStack {
                        Color(hex: "EDF2F7").ignoresSafeArea()
                        Text("Sección de Mapa")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .tag(1)
                    
                    // Tab 3: Comunidades
                    ZStack {
                        Color(hex: "EDF2F7").ignoresSafeArea()
                        Text("Sección de Comunidades")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .tag(2)
                    
                    // Tab 4: Reportes
                    ZStack {
                        Color(hex: "EDF2F7").ignoresSafeArea()
                        Text("Sección de Reportes")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // TabBar personalizado
                customTabBar
            }
            
            // Botón flotante de reporte rápido (centrado)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Acción para reportar
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(hex: "FF6B6B"),
                                                Color(hex: "FF8E8E")
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color(hex: "FF6B6B").opacity(0.4),
                                            radius: 10, x: 0, y: 5)
                            )
                    }
                    .offset(y: -15) // Ajusta este valor si lo quieres más arriba/abajo
                    Spacer()
                }
            }

            
            // Superposiciones para notificaciones y perfil
            if showNotifications {
                // Superposición semitransparente
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showNotifications = false
                        }
                    }
                
                NotificationsView(isShowing: $showNotifications)
                    .transition(.move(edge: .top))
            }
            
            if showProfile {
                // Superposición semitransparente
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showProfile = false
                        }
                    }
                
                ProfileView(isShowing: $showProfile)
                    .transition(.move(edge: .trailing))
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes de la UI
    
    // Barra de navegación personalizada
    var customNavigationBar: some View {
        HStack {
            // Logo y título
            HStack(spacing: 10) {
                Image(systemName: "megaphone.fill")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(primaryColor)
                
                Text("AltavozUDG")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(primaryColor)
            }
            
            Spacer()
            
            // Botón de búsqueda
            Button(action: {
                withAnimation {
                    isSearching.toggle()
                }
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(hex: "4A5568"))
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color(hex: "EDF2F7"))
                    )
            }
            
            // Botón de notificaciones
            Button(action: {
                withAnimation {
                    showNotifications.toggle()
                }
            }) {
                ZStack {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(hex: "4A5568"))
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color(hex: "EDF2F7"))
                        )
                    
                    // Indicador de notificaciones no leídas
                    if hasUnreadNotifications {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 8, y: -8)
                    }
                }
            }
            
            // Botón de perfil
            Button(action: {
                withAnimation {
                    showProfile.toggle()
                }
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(hex: "4A5568"))
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color(hex: "EDF2F7"))
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
        .background(Color.white)
    }
    
    // Barra de búsqueda
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "A0AEC0"))
            
            TextField("Buscar en AltavozUDG...", text: $searchText)
                .font(.system(size: 16))
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(hex: "A0AEC0"))
                }
            }
        }
        .padding(12)
        .background(Color(hex: "EDF2F7"))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.white)
    }
    
    // Banner destacado
    var featuredBanner: some View {
        ZStack(alignment: .topLeading) {
            // Fondo con gradiente
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            primaryColor,
                            secondaryColor
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    // Elementos decorativos
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 150)
                            .offset(x: 220, y: 20)
                        
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 80)
                            .offset(x: -40, y: 100)
                    }
                )
            
            // Contenido del banner
            VStack(alignment: .leading, spacing: 15) {
                Text("¿Conoces un espacio inclusivo?")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("Comparte ubicaciones accesibles que conozcas para ayudar a otros")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
                
                Button(action: {
                    // Acción para compartir espacio
                }) {
                    Text("Compartir lugar")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(primaryColor)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                }
                .padding(.top, 5)
            }
            .padding(25)
        }
        .frame(height: 210)
        .shadow(color: primaryColor.opacity(0.3), radius: 15, x: 0, y: 10)
    }
    
    // Grid de acciones rápidas
    var quickActionsGrid: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Acciones rápidas")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "2D3748"))
            
            // Grid de 2x2 para acciones rápidas
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                QuickActionButton(
                    title: "Reportar\nObstáculo",
                    icon: "exclamationmark.triangle.fill",
                    color: Color(hex: "FF6B6B")
                )
                
                QuickActionButton(
                    title: "Encontrar\nEspacios",
                    icon: "location.magnifyingglass",
                    color: Color(hex: "5A7D5A")
                )
                
                QuickActionButton(
                    title: "Unirse a\nGrupo",
                    icon: "person.3.fill",
                    color: Color(hex: "3B5998")
                )
                
                QuickActionButton(
                    title: "Reportar\nIncidente",
                    icon: "exclamationmark.bubble.fill",
                    color: Color(hex: "845EC2")
                )
            }
        }
    }
    
    // Sección de reportes recientes
    var recentReportsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Reportes recientes")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                
                Spacer()
                
                Button(action: {
                    // Ver todos los reportes
                }) {
                    Text("Ver todos")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(primaryColor)
                }
            }
            
            // Lista de reportes recientes
            VStack(spacing: 12) {
                ReportCard(
                    title: "Rampa inaccesible",
                    location: "Edificio P, entrada principal",
                    date: "Hoy",
                    imageName: "ramp.unavailable",
                    color: Color(hex: "FF6B6B")
                )
                
                ReportCard(
                    title: "Baño neutro cerrado",
                    location: "Edificio H, 2do piso",
                    date: "Ayer",
                    imageName: "toilet",
                    color: Color(hex: "5A7D5A")
                )
                
                ReportCard(
                    title: "Señalización inadecuada",
                    location: "Nuevo edificio",
                    date: "2 días",
                    imageName: "signpost",
                    color: Color(hex: "3B5998")
                )
            }
        }
    }
    
    // Sección de próximos eventos
    var upcomingEventsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Próximos eventos")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                
                Spacer()
                
                Button(action: {
                    // Ver todos los eventos
                }) {
                    Text("Ver todos")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(primaryColor)
                }
            }
            
            // Carrusel horizontal de eventos
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    EventCard(
                        title: "Taller de Inclusión",
                        date: "15 Abr",
                        time: "10:00",
                        location: "Auditorio Central",
                        color: Color(hex: "845EC2")
                    )
                    
                    EventCard(
                        title: "Foro Diversidad",
                        date: "20 Abr",
                        time: "12:30",
                        location: "Plaza Roja",
                        color: Color(hex: "FF9671")
                    )
                    
                    EventCard(
                        title: "Accesibilidad Digital",
                        date: "25 Abr",
                        time: "16:00",
                        location: "Lab. Multimedia",
                        color: Color(hex: "00C9A7")
                    )
                }
            }
        }
    }
    
    // Sección de espacios inclusivos
    var inclusiveSpacesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Espacios inclusivos")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "2D3748"))
            
            // Grid de espacios
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                SpaceInfoCard(
                    title: "Baños Neutros",
                    count: 12,
                    icon: "toilet",
                    color: Color(hex: "4A9FFF")
                )
                
                SpaceInfoCard(
                    title: "Rampas",
                    count: 23,
                    icon: "figure.roll",
                    color: Color(hex: "FF6B6B")
                )
                
                SpaceInfoCard(
                    title: "Salas Lactancia",
                    count: 8,
                    icon: "figure.child.and.lock",
                    color: Color(hex: "FF9A8B")
                )
                
                SpaceInfoCard(
                    title: "Áreas Silenciosas",
                    count: 5,
                    icon: "ear.trianglebadge.exclamationmark",
                    color: Color(hex: "845EC2")
                )
            }
        }
    }
    
    // Sección de estadísticas de impacto
    var impactStatsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Nuestro impacto")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "2D3748"))
            
            // Tarjeta de estadísticas
            HStack(spacing: 20) {
                // Estadística 1
                VStack {
                    Text("158")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(primaryColor)
                    
                    Text("Reportes\nresueltos")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(hex: "4A5568"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                
                // Separador vertical
                Rectangle()
                    .fill(Color(hex: "E2E8F0"))
                    .frame(width: 1, height: 60)
                
                // Estadística 2
                VStack {
                    Text("24")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(primaryColor)
                    
                    Text("Espacios\nidentificados")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(hex: "4A5568"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                
                // Separador vertical
                Rectangle()
                    .fill(Color(hex: "E2E8F0"))
                    .frame(width: 1, height: 60)
                
                // Estadística 3
                VStack {
                    Text("1.2K")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(primaryColor)
                    
                    Text("Usuarios\nactivos")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(hex: "4A5568"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
        }
    }
    
var customTabBar: some View {
    HStack(spacing: 0) {
        // Tab 1: Inicio
        TabBarButton(
            title: "Inicio",
            icon: "house.fill",
            isSelected: selectedTab == 0,
            action: { selectedTab = 0 }
        )
        
        // Tab 2: Mapa
        TabBarButton(
            title: "Mapa",
            icon: "map.fill",
            isSelected: selectedTab == 1,
            action: { selectedTab = 1 }
        )
        
        // **Hueco para el botón flotante**
        // (Con un ancho aproximado al diámetro del botón)
        Spacer().frame(width: 60)
        
        // Tab 3: Grupos
        TabBarButton(
            title: "Grupos",
            icon: "person.3.fill",
            isSelected: selectedTab == 2,
            action: { selectedTab = 2 }
        )
        
        // Tab 4: Reportes
        TabBarButton(
            title: "Reportes",
            icon: "list.bullet.clipboard.fill",
            isSelected: selectedTab == 3,
            action: { selectedTab = 3 }
        )
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 15)
    .background(
        Color.white
            .edgesIgnoringSafeArea(.bottom)
            .shadow(color: Color.black.opacity(0.1), radius: 10, y: -5)
    )
}


}

// MARK: - Subcomponentes de la UI

// Botón del TabBar
struct TabBarButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: isSelected ? 20 : 18))
                    .foregroundColor(isSelected ? Color(hex: "2E6DE5") : Color(hex: "A0AEC0"))
                
                Text(title)
                    .font(.system(size: 12, weight: isSelected ? .semibold : .medium, design: .rounded))
                    .foregroundColor(isSelected ? Color(hex: "2E6DE5") : Color(hex: "A0AEC0"))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// Botón de acción rápida
struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Acción del botón
        }) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                    .multilineTextAlignment(.center)
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
    }
}

// Tarjeta de reporte
struct ReportCard: View {
    let title: String
    let location: String
    let date: String
    let imageName: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            // Icono del reporte
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color)
                )
            
            // Información del reporte
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                
                Text(location)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(Color(hex: "718096"))
            }
            
            Spacer()
            
            // Estado o fecha
            Text(date)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(Color(hex: "A0AEC0"))
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    Capsule()
                        .fill(Color(hex: "EDF2F7"))
                )
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// Tarjeta de evento
struct EventCard: View {
    let title: String
    let date: String
    let time: String
    let location: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Fecha y hora
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(date)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(time)
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                Image(systemName: "calendar")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
            )
            
            // Detalles del evento
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "718096"))
                    
                    Text(location)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(hex: "718096"))
                        .lineLimit(1)
                }
                
                Button(action: {
                    // Acción para asistir al evento
                }) {
                    Text("Asistir")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                        .background(
                            Capsule()
                                .fill(color)
                        )
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
        .frame(width: 200)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

// Tarjeta de espacio inclusivo
struct SpaceInfoCard: View {
    let title: String
    let count: Int
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Icono y contador
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                    )
                
                Spacer()
                
                Text("\(count)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
            }
            
            // Título del espacio
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color(hex: "4A5568"))
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// Vista de notificaciones
struct NotificationsView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Encabezado
            HStack {
                Text("Notificaciones")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isShowing = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "718096"))
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color(hex: "EDF2F7"))
                        )
                }
            }
            .padding()
            
            Divider()
            
            // Lista de notificaciones (ejemplos)
            ScrollView {
                VStack(spacing: 0) {
                    NotificationItem(
                        title: "Reporte actualizado",
                        description: "La rampa reportada en Edificio P ha sido reparada",
                        time: "Hace 2 horas",
                        icon: "checkmark.circle.fill",
                        color: Color.green
                    )
                    
                    NotificationItem(
                        title: "Nuevo evento",
                        description: "Taller sobre inclusión digital este viernes",
                        time: "Hace 1 día",
                        icon: "calendar",
                        color: Color(hex: "845EC2")
                    )
                    
                    NotificationItem(
                        title: "Comentario en tu reporte",
                        description: "Administración ha respondido a tu reporte #45",
                        time: "Hace 2 días",
                        icon: "bubble.left.fill",
                        color: Color(hex: "4A9FFF")
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
        )
        .offset(y: 50)
        .padding(.horizontal)
    }
}

// Item de notificación
struct NotificationItem: View {
    let title: String
    let description: String
    let time: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Icono
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill(color)
                )
                .padding(.top, 2)
            
            // Contenido
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hex: "2D3748"))
                
                Text(description)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(Color(hex: "718096"))
                    .lineLimit(2)
                
                Text(time)
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color(hex: "A0AEC0"))
                    .padding(.top, 2)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: "E2E8F0"))
                .offset(x: 0, y: 35),
            alignment: .bottom
        )
    }
}

// Vista de perfil
struct ProfileView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Cabecera
            VStack(spacing: 20) {
                // Botón para cerrar
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isShowing = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.25))
                            )
                    }
                    .padding(.trailing)
                }
                
                // Imagen de perfil
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .foregroundColor(.white)
                
                // Información del usuario
                VStack(spacing: 5) {
                    Text("Mario Moreno")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Estudiante • CuValles")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                }
                
                // Estadísticas del usuario
                HStack(spacing: 30) {
                    VStack {
                        Text("12")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Reportes")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    VStack {
                        Text("5")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Eventos")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    VStack {
                        Text("3")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Grupos")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
            .padding(.top, 20)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "2E6DE5"),
                        Color(hex: "4A9FFF")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            // Opciones de perfil
            ScrollView {
                VStack(spacing: 0) {
                    ProfileMenuItem(
                        title: "Editar perfil",
                        icon: "person.fill",
                        color: Color(hex: "4A9FFF")
                    )
                    
                    ProfileMenuItem(
                        title: "Mis reportes",
                        icon: "doc.text.fill",
                        color: Color(hex: "FF6B6B")
                    )
                    
                    ProfileMenuItem(
                        title: "Mis grupos",
                        icon: "person.3.fill",
                        color: Color(hex: "3B5998")
                    )
                    
                    ProfileMenuItem(
                        title: "Eventos guardados",
                        icon: "calendar",
                        color: Color(hex: "845EC2")
                    )
                    
                    ProfileMenuItem(
                        title: "Configuración",
                        icon: "gear",
                        color: Color(hex: "718096")
                    )
                    
                    ProfileMenuItem(
                        title: "Ayuda y soporte",
                        icon: "questionmark.circle",
                        color: Color(hex: "00C9A7")
                    )
                    
                    ProfileMenuItem(
                        title: "Cerrar sesión",
                        icon: "arrow.right.square",
                        color: Color(hex: "E53E3E"),
                        isDestructive: true
                    )
                }
                .padding(.vertical, 10)
            }
        }
        .frame(width: 300)
        .background(Color.white)
        .edgesIgnoringSafeArea(.vertical)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: -10, y: 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
}

// Item del menú de perfil
struct ProfileMenuItem: View {
    let title: String
    let icon: String
    let color: Color
    var isDestructive: Bool = false
    
    var body: some View {
        Button(action: {
            // Acción del menú
        }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                    )
                
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(isDestructive ? Color(hex: "E53E3E") : Color(hex: "2D3748"))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "A0AEC0"))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
    }
}

// MARK: - Extensión para Color desde Hexadecimal
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
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
// MARK: - Previsualización
struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
