@Entry
@Component
struct ContentView {
  @State email: string = ''
  @State password: string = ''

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column() {
        Blank()
      }.width('100%').height('100%').backgroundColor('#F9FAFB')

      // Scrollable Content
      Scroll() {
        Column() {
          // Header
          Text('Sign in')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#111827')
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ top: 36, bottom: 32 })

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
              
              TextInput({ placeholder: '' })
                .type(InputType.Email)
                .text(this.email)
                .onChange((value: string) => { this.email = value })
                .width('100%')
                .height(40)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .padding({ left: 12 })
                .fontColor('#111827')
                .fontSize(12)
            }

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              TextInput({ placeholder: '' })
                .type(InputType.Password)
                .text(this.password)
                .onChange((value: string) => { this.password = value })
                .width('100%')
                .height(40)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .padding({ left: 12 })
                .fontColor('#111827')
                .fontSize(12)
            }

            // Links
            Row() {
              Button('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB')
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .stateEffect(false)
              
              Blank()

              Button('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB')
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .stateEffect(false)
            }
            .width('100%')
            .padding({ top: 6 })

            // Sign In Button
            Button('Sign in')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#111827')
              .borderRadius(8)
              .width('100%')
              .height(40)
              .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E5E7EB' })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
          .margin({ left: 16, right: 16 })

          // Divider
          Row() {
            Divider().color('#E5E7EB')
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ left: 8, right: 8 })
            Divider().color('#E5E7EB')
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social Buttons
          Column({ space: 6 }) {
            Button('Continue with Apple')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#111827')
              .borderRadius(8)
              .width('100%')
              .height(36)

            Button('Continue with Google')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#2563EB')
              .borderRadius(8)
              .width('100%')
              .height(36)

            Button('Continue with GitHub')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#6B7280')
              .borderRadius(8)
              .width('100%')
              .height(36)
          }
          .width('100%')
          .margin({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6B7280')
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 16, left: 32, right: 32 })

          // Help Section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
              
              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .fontColor('#111827')
            }
            
            Blank()

            Button('Support')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#2563EB')
              .borderRadius(8)
              .height(32)
              .padding({ left: 12, right: 12 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F3F4F6')
          .borderRadius(12)
          .border({ width: 1, color: '#E5E7EB' })
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.10)' })
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom Spacer
          Blank().height(32)
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}