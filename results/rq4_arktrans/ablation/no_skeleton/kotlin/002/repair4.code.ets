@Entry
@Component
struct RootScreen {
  @State email: string = ''
  @State password: string = ''

  build() {
    Column() {
      // Top Bar
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0B1220')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 48, bottom: 24 })

      // Main Card
      Column() {
        Text('Welcome back')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ bottom: 12 })

        // Email Field
        Column() {
          Text('Email')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: 4 })
          
          TextInput({ placeholder: '' })
            .height(44)
            .backgroundColor('#FFF')
            .borderRadius(8)
            .border({ width: 1, color: '#E5E7EB' })
            .onChange((value: string) => { this.email = value })
        }
        .margin({ bottom: 12 })

        // Password Field
        Column() {
          Text('Password')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: 4 })
          
          TextInput({ placeholder: '' })
            .type(InputType.Password)
            .height(44)
            .backgroundColor('#FFF')
            .borderRadius(8)
            .border({ width: 1, color: '#E5E7EB' })
            .onChange((value: string) => { this.password = value })
        }
        .margin({ bottom: 8 })

        // Links Row
        Row() {
          Text('Forgot password?')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
          Blank()
          Text('Create account')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
        }
        .width('100%')
        .margin({ bottom: 12 })

        // Sign In Button
        Button('Sign in')
          .width('100%')
          .height(44)
          .backgroundColor('#111827')
          .fontColor('#FFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
      .border({ width: 1, color: '#E5E7EB' })

      // Divider Section
      Row() {
        Divider().color('#E5E7EB').layoutWeight(1)
        Text('Or continue with')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .margin({ left: 6, right: 6 })
        Divider().color('#E5E7EB').layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 16, bottom: 12 })

      // Social Buttons
      Column() {
        Button('Continue with Apple')
          .width('100%')
          .height(40)
          .backgroundColor('#111827')
          .fontColor('#FFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
        
        Button('Continue with Google')
          .width('100%')
          .height(40)
          .backgroundColor('#2563EB')
          .fontColor('#FFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .margin({ top: 4 })
        
        Button('Continue with GitHub')
          .width('100%')
          .height(40)
          .backgroundColor('#6B7280')
          .fontColor('#FFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .margin({ top: 4 })
      }
      .width('100%')

      // Policy Text
      Text('By continuing you agree to the Terms and Privacy Policy')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#6B7280')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 8, bottom: 16 })

      Blank().layoutWeight(1)

      // Support Card
      Row() {
        Column() {
          Text('Need help?')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Text('Contact support@example.com')
            .fontSize(12)
            .fontColor('#0B1220')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        
        Button('Support')
          .height(36)
          .backgroundColor('#2563EB')
          .fontColor('#FFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F3F4F6')
      .borderRadius(12)
      .shadow({ radius: 2, color: '#1A000000', offsetY: 0.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
    .padding({ left: 12, right: 12, top: 0, bottom: 12 })
  }
}