@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  build() {
    Stack() {
      Column() {
        // Main Content Container
        Scroll() {
          Column() {
            // Header Title
            Text('Sign in')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .margin({ top: 40, bottom: 32 })
              .textAlign(TextAlign.Center)

            // Login Card
            Column() {
              Text('Welcome back')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 16 })

              // Email Field
              Column() {
                Text('Email')
                  .fontSize(12)
                  .fontColor('#111827')
                  .margin({ bottom: 8 })
                
                TextInput({ placeholder: 'Enter your email' })
                  .type(InputType.Email)
                  .height(44)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#E5E7EB' })
                  .padding({ left: 12 })
                  .onChange((value: string) => { this.email = value })
              }.width('100%').margin({ bottom: 16 })

              // Password Field
              Column() {
                Text('Password')
                  .fontSize(12)
                  .fontColor('#111827')
                  .margin({ bottom: 8 })
                
                TextInput({ placeholder: 'Enter your password' })
                  .type(InputType.Password)
                  .height(44)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#E5E7EB' })
                  .padding({ left: 12 })
                  .onChange((value: string) => { this.password = value })
              }.width('100%').margin({ bottom: 12 })

              // Links Row
              Row() {
                Text('Forgot password?')
                  .fontSize(12)
                  .fontColor('#2563EB')
                  .onClick(() => {})
                
                Blank()
                
                Text('Create account')
                  .fontSize(12)
                  .fontColor('#2563EB')
                  .onClick(() => {})
              }.width('100%').margin({ bottom: 20 })

              // Sign In Button
              Button('Sign in')
                .width('100%')
                .height(48)
                .backgroundColor('#111827')
                .borderRadius(8)
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding(24)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 10, color: '#00000014', offsetY: 4 })

            // Divider Section
            Row() {
              Divider().color('#E5E7EB').layoutWeight(1)
              Text('Or continue with')
                .fontSize(12)
                .fontColor('#111827')
                .padding({ left: 12, right: 12 })
              Divider().color('#E5E7EB').layoutWeight(1)
            }
            .width('100%')
            .margin({ top: 24, bottom: 16 })

            // Social Buttons
            Column() {
              Button('Continue with Apple')
                .width('100%')
                .height(48)
                .backgroundColor('#111827')
                .borderRadius(8)
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 12 })

              Button('Continue with Google')
                .width('100%')
                .height(48)
                .backgroundColor('#2563EB')
                .borderRadius(8)
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 12 })

              Button('Continue with GitHub')
                .width('100%')
                .height(48)
                .backgroundColor('#6B7280')
                .borderRadius(8)
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }.width('100%')

            // Terms Text
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(12)
              .fontColor('#6B7280')
              .textAlign(TextAlign.Center)
              .margin({ top: 20, bottom: 32 })
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            // Help Card
            Row() {
              Column() {
                Text('Need help?')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#111827')
                  .margin({ bottom: 4 })
                
                Text('Contact support@example.com')
                  .fontSize(14)
                  .fontColor('#111827')
              }.alignItems(HorizontalAlign.Start)

              Blank()

              Button('Support')
                .backgroundColor('#2563EB')
                .borderRadius(8)
                .fontColor('#FFFFFF')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#F3F4F6')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#0000001A', offsetY: 2 })

            Blank().height(32)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FAFAFA')
    }
    .width('100%')
    .height('100%')
  }
}