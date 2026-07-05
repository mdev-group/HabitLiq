import SwiftUI

// MARK: - 1. THE LIQUID GLASS MODIFIER
// This reusable modifier creates the high-gloss, ultra-blurred border effect seen in your images.
struct LiquidGlassStyle: ViewModifier {
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .background(
                // Ultra-thin material for the blurred glass look
                Color.white.opacity(0.12)
                    .blur(radius: 0.5)
            )
            .background(
                // The underlying blur effect
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                // The glossy highlight stroke on the outer edges
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.6), .clear, .white.opacity(0.1), .white.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 10)
    }
}

extension View {
    func liquidGlass(radius: CGFloat = 20) -> some View {
        self.modifier(LiquidGlassStyle(cornerRadius: radius))
    }
}

// MARK: - 2. CORE APP VIEW
struct LiquidHabitApp: View {
    @State private var selectedTab = 0
    @State private var drinkWaterProgress: CGFloat = 0.6
    @State private var showDynamicIslandNotification = false
    
    var body: some View {
        ZStack {
            // A rich colorful gradient background so the glass panels can pop
            LinearGradient(colors: [Color(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.2431372549, alpha: 1)), Color(#colorLiteral(red: 0.2431372549, green: 0.3294117647, blue: 0.5607843137, alpha: 1))], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // FAKE DYNAMIC ISLAND (Top Interface)
                DynamicIslandWidget(isActive: $showDynamicIslandNotification)
                    .padding(.top, 10)
                
                // HEADER
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Today's Habits")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Finish strong today!")
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Spacer()
                    
                    // Liquid Glass Trigger Button
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            showDynamicIslandNotification.toggle()
                        }
                    }) {
                        Image(systemName: "bolt.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.cyan)
                            .padding(10)
                            .liquidGlass(radius: 50)
                    }
                }
                .padding(.horizontal)
                
                // HABIT CARD 1: WATER INTAKE (WITH LIQUID GLASS SLIDER)
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(.blue)
                        Text("Hydration Target")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(Int(drinkWaterProgress * 100))%")
                            .foregroundColor(.cyan)
                            .bold()
                    }
                    
                    // Custom Fluid Slider track
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.black.opacity(0.2))
                                .frame(height: 30)
                            
                            // Glowing fluid progress bar filling up
                            Capsule()
                                .fill(LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing))
                                .frame(width: geo.size.width * drinkWaterProgress, height: 30)
                            
                            // Floating "Liquid Glass" Slider Knob
                            Circle()
                                .liquidGlass(radius: 50)
                                .frame(width: 40, height: 40)
                                .offset(x: (geo.size.width * drinkWaterProgress) - 20)
                                .gesture(
                                    DragGesture().onChanged { value in
                                        let percent = value.location.x / geo.size.width
                                        self.drinkWaterProgress = min(max(0, percent), 1)
                                    }
                                )
                        }
                    }
                    .frame(height: 40)
                }
                .padding()
                .liquidGlass(radius: 24)
                .padding(.horizontal)
                
                // HABIT CARD 2: QUICK CHECKS
                VStack(spacing: 12) {
                    HabitRow(title: "Read 15 Pages", isDone: true, icon: "book.closed.fill", color: .green)
                    HabitRow(title: "Morning Meditation", isDone: false, icon: "brain.head.profile", color: .purple)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // LIQUID TAB BAR (Emulating your structural concept pictures)
                HStack(spacing: 0) {
                    TabBarButton(icon: "checkmark.circle.fill", label: "Habits", index: 0, currentTab: $selectedTab)
                    TabBarButton(icon: "chart.bar.fill", label: "Stats", index: 1, currentTab: $selectedTab)
                    TabBarButton(icon: "gearshape.fill", label: "Settings", index: 2, currentTab: $selectedTab)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .liquidGlass(radius: 35)
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - 3. DYNAMIC ISLAND VIEW COMPONENT
struct DynamicIslandWidget: View {
    @Binding var isActive: Bool
    
    var body: some View {
        HStack {
            if isActive {
                Image(systemName: "trophy.fill")
                    .foregroundColor(.yellow)
                    .transition(.scale)
                Text("Habit Streak Maintained! 🔥")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .transition(.opacity)
            } else {
                // Native Standard Pill Shape when idle
                Circle()
                    .fill(Color.clear)
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.horizontal, isActive ? 20 : 0)
        .frame(width: isActive ? 280 : 120, height: isActive ? 40 : 30)
        .background(Color.black)
        .cornerRadius(25)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isActive)
    }
}

// MARK: - 4. LIQUID TAB BUTTON SUB-VIEW
struct TabBarButton: View {
    let icon: String
    let label: String
    let index: Int
    @Binding var currentTab: Int
    
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7)) {
                currentTab = index
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            // Active selection creates that dynamic bubble shape inside the glass pod
            .background(
                Capsule()
                    .fill(currentTab == index ? Color.white.opacity(0.15) : Color.clear)
            )
            .foregroundColor(currentTab == index ? .white : .white.opacity(0.4))
        }
    }
}

// MARK: - 5. HABIT ROW LOGIC VIEW
struct HabitRow: View {
    let title: String
    @State var isDone: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            
            // Interactive status bubble
            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24))
                .foregroundColor(isDone ? .green : .white.opacity(0.3))
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isDone.toggle()
                    }
                }
        }
        .padding()
        .liquidGlass(radius: 16)
    }
}