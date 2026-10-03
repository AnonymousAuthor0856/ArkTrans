// index.ets

import { BusinessError } from '@kit.BasicServicesKit';
import { common, window } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct LoginView {
  @State email: string = ''
  @State password: string = ''
  
  // Design Tokens
  private readonly colors = {
    primary: '#111827',
    onPrimary: '#FFFFFF',
    secondary: '#6B7280',
    onSecondary: '#FFFFFF',
    tertiary: '#2563EB',
    onTertiary: '#FFFFFF',
    background: '#F9FAFB',
    onBackground: '#0B1220',
    surface: '#FFFFFF',
    onSurface: '#111827',
    surfaceVariant: '#F3F4F6',
    outline: '#E5E7EB'
  }

  build() {
    Column() {
      Column() {
        // Header
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.colors.onSurface)
          .margin({ top: 36, bottom: 32 })
        
        // Login Card
        Column({ space: 12 }) {
          Text('Welcome back')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.colors.onSurface)
          
          // Email Field
          Column({ space: 4 }) {
            Text('Email')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
            
            TextInput({ placeholder: 'Enter your email' })
              .type(InputType.Email)
              .width('100%')
              .height(40)
              .borderRadius(8)
              .border({ width: 1, color: this.colors.outline })
              .backgroundColor(Color.White)
              .padding({ left: 12 })
              .fontSize(12)
              .fontColor(this.colors.onSurface)
              .onChange((value: string) => {
                this.email = value
              })
          }
          
          // Password Field
          Column({ space: 4 }) {
            Text('Password')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
            
            TextInput({ placeholder: 'Enter your password' })
              .type(InputType.Password)
              .width('100%')
              .height(40)
              .borderRadius(8)
              .border({ width: 1, color: this.colors.outline })
              .backgroundColor(Color.White)
              .padding({ left: 12 })
              .fontSize(12)
              .fontColor(this.colors.onSurface)
              .onChange((value: string) => {
                this.password = value
              })
          }
          
          // Links
          Row() {
            Button('Forgot password?')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.tertiary)
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .onClick(() => {
                // Handle forgot password
              })
            
            Blank()
            
            Button('Create account')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.tertiary)
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .onClick(() => {
                // Handle create account
              })
          }
          .margin({ top: 6 })
          
          // Sign In Button
          Button('Sign in')
            .width('100%')
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onPrimary)
            .backgroundColor(this.colors.primary)
            .borderRadius(8)
            .margin({ top: 8 })
            .onClick(() => {
              // Handle sign in
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .backgroundColor(this.colors.surface)
        .borderRadius(12)
        .border({ width: 1, color: this.colors.outline })
        .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
        .margin({ horizontal: 16 })
        
        // Divider
        Row() {
          Divider()
            .color(this.colors.outline)
            .layoutWeight(1)
          
          Text('Or continue with')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
            .margin({ horizontal: 8 })
          
          Divider()
            .color(this.colors.outline)
            .layoutWeight(1)
        }
        .margin({ top: 16, bottom: 16, horizontal: 16 })
        
        // Social buttons
        Column({ space: 6 }) {
          Button('Continue with Apple')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onPrimary)
            .backgroundColor(this.colors.primary)
            .borderRadius(8)
            .onClick(() => {
              // Handle Apple login
            })
          
          Button('Continue with Google')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onPrimary)
            .backgroundColor(this.colors.tertiary)
            .borderRadius(8)
            .onClick(() => {
              // Handle Google login
            })
          
          Button('Continue with GitHub')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onPrimary)
            .backgroundColor(this.colors.secondary)
            .borderRadius(8)
            .onClick(() => {
              // Handle GitHub login
            })
        }
        .margin({ horizontal: 16 })
        
        // Terms and Privacy
        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.secondary)
          .textAlign(TextAlign.Center)
          .margin({ top: 16, horizontal: 32 })
        
        // Help section
        Row() {
          Column({ space: 2 }) {
            Text('Need help?')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
            
            Text('Contact support@example.com')
              .fontSize(12)
              .fontColor(this.colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)
          
          Blank()
          
          Button('Support')
            .height(32)
            .padding({ left: 12, right: 12 })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onTertiary)
            .backgroundColor(this.colors.tertiary)
            .borderRadius(8)
            .onClick(() => {
              // Handle support
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.colors.surfaceVariant)
        .borderRadius(12)
        .border({ width: 1, color: this.colors.outline })
        .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
        .margin({ top: 32, horizontal: 16 })
        
        // Bottom spacer
        Blank()
          .height(32)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.colors.background)
        .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}