//
//  ContentView.swift
//  AuthLoginApp
//
//  Created by hang on 2025/10/12.
//

import SwiftUI

// MARK: - Design Tokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF111827)
        static let onPrimary = Color.white
        static let secondary = Color(hex: 0xFF6B7280)
        static let onSecondary = Color.white
        static let tertiary = Color(hex: 0xFF2563EB)
        static let onTertiary = Color.white
        static let background = Color(hex: 0xFFF9FAFB)
        static let onBackground = Color(hex: 0xFF0B1220)
        static let surface = Color.white
        static let onSurface = Color(hex: 0xFF111827)
        static let surfaceVariant = Color(hex: 0xFFF3F4F6)
        static let outline = Color(hex: 0xFFE5E7EB)
    }
    
    struct Typography {
        static let display = Font.system(size: 22, weight: .semibold)
        static let headline = Font.system(size: 16, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 10, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 2
        static let sm: CGFloat = 4
        static let md: CGFloat = 6
        static let lg: CGFloat = 8
        static let xl: CGFloat = 12
        static let xxl: CGFloat = 16
        static let xxxl: CGFloat = 24
    }
    
    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 4)
        static let medium = RoundedRectangle(cornerRadius: 8)
        static let large = RoundedRectangle(cornerRadius: 12)
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

// MARK: - Data Models
struct SocialItem {
    let label: String
    let tint: Color
}

// MARK: - Main Content View
struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    
    private let socials = [
        SocialItem(label: "Continue with Apple", tint: AppTokens.Colors.primary),
        SocialItem(label: "Continue with Google", tint: AppTokens.Colors.tertiary),
        SocialItem(label: "Continue with GitHub", tint: AppTokens.Colors.secondary)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTokens.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header - 增加下方空白
                        Text("Sign in")
                            .font(AppTokens.Typography.display)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.top, 36)
                            .padding(.bottom, 32) // 从20增加到32
                        
                        // Login Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Welcome back")
                                .font(AppTokens.Typography.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                            // Email Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Email")
                                    .font(AppTokens.Typography.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                TextField("", text: $email)
                                    .textFieldStyle(LoginTextFieldStyle())
                                    .frame(height: 40)
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Password")
                                    .font(AppTokens.Typography.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                SecureField("", text: $password)
                                    .textFieldStyle(LoginTextFieldStyle())
                                    .frame(height: 40)
                            }
                            
                            // Links
                            HStack {
                                Button("Forgot password?") {}
                                    .font(AppTokens.Typography.label)
                                    .foregroundColor(AppTokens.Colors.tertiary)
                                
                                Spacer()
                                
                                Button("Create account") {}
                                    .font(AppTokens.Typography.label)
                                    .foregroundColor(AppTokens.Colors.tertiary)
                            }
                            .padding(.top, 6)
                            
                            // Sign In Button
                            Button(action: {}) {
                                Text("Sign in")
                                    .font(AppTokens.Typography.title)
                                    .foregroundColor(AppTokens.Colors.onPrimary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                            }
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(8)
                            .padding(.top, 8)
                        }
                        .padding(16)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 1)
                        .padding(.horizontal, 16)
                        
                        // Divider
                        HStack {
                            Rectangle()
                                .fill(AppTokens.Colors.outline)
                                .frame(height: 1)
                            
                            Text("Or continue with")
                                .font(AppTokens.Typography.label)
                                .foregroundColor(AppTokens.Colors.onSurface)
                                .padding(.horizontal, 8)
                            
                            Rectangle()
                                .fill(AppTokens.Colors.outline)
                                .frame(height: 1)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                        
                        // Social buttons
                        VStack(spacing: 6) {
                            ForEach(socials, id: \.label) { social in
                                Button(action: {}) {
                                    Text(social.label)
                                        .font(AppTokens.Typography.title)
                                        .foregroundColor(AppTokens.Colors.onPrimary)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 36)
                                }
                                .background(social.tint)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        // Terms and Privacy
                        Text("By continuing you agree to the Terms and Privacy Policy")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)
                            .padding(.horizontal, 32)
                        
                        // Help section
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Need help?")
                                    .font(AppTokens.Typography.title)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                Text("Contact support@example.com")
                                    .font(AppTokens.Typography.body)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("Support")
                                    .font(AppTokens.Typography.title)
                                    .foregroundColor(AppTokens.Colors.onTertiary)
                                    .frame(height: 32)
                                    .padding(.horizontal, 12)
                            }
                            .background(AppTokens.Colors.tertiary)
                            .cornerRadius(8)
                        }
                        .padding(16)
                        .background(AppTokens.Colors.surfaceVariant)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: 0.5)
                        .padding(.top, 32)
                        .padding(.horizontal, 16)
                        
                        // Bottom spacer
                        Spacer()
                            .frame(height: 32)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .statusBar(hidden: true)
    }
}

// MARK: - Custom TextField Style
struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 12)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTokens.Colors.outline, lineWidth: 1)
            )
            .font(AppTokens.Typography.body)
            .foregroundColor(AppTokens.Colors.onSurface)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}