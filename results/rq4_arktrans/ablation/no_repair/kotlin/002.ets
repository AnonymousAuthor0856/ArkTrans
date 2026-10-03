@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 8 }) {
        // Card Container
        Column() {
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .width('100%')

            Column({ space: 6 }) {
              Text('Email')
                .fontSize(14)
                .fontColor('#111827')
              
              TextInput({ placeholder: 'Enter your email' })
                .type(InputType.Email)
                .height(44)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .onChange((value: string) => {
                  this.email = value
                })

              Text('Password')
                .fontSize(14)
                .fontColor('#111827')

              TextInput({ placeholder: 'Enter your password' })
                .type(InputType.Password)
                .height(44)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .onChange((value: string) => {
                  this.password = value
                })

              Row() {
                Text('Forgot password?')
                  .fontSize(14)
                  .fontColor('#2563EB')
                
                Blank()

                Text('Create account')
                  .fontSize(14)
                  .fontColor('#2563EB')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding({ top: 4 })
            }
            .width('100%')

            Button('Sign in')
              .width('100%')
              .height(44)
              .backgroundColor('#111827')
              .borderRadius(12)
              .fontColor(Color.White)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })

        // Divider Section
        Row() {
          Divider().color('#E5E7EB').layoutWeight(1)
          Blank().width(12)
          Text('Or continue with')
            .fontSize(14)
            .fontColor('#111827')
          Blank().width(12)
          Divider().color('#E5E7EB').layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })

        // Social Buttons
        Column({ space: 8 }) {
          Button('Continue with Apple')
            .width('100%')
            .height(48)
            .backgroundColor('#111827')
            .borderRadius(12)
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Button('Continue with Google')
            .width('100%')
            .height(48)
            .backgroundColor('#2563EB')
            .borderRadius(12)
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Button('Continue with GitHub')
            .width('100%')
            .height(48)
            .backgroundColor('#6B7280')
            .borderRadius(12)
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // Terms Text
        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(12)
          .fontColor('#6B7280')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 8, bottom: 8 })

        Blank().height(16)

        // Support Surface
        Column() {
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
              
              Text('Contact support@example.com')
                .fontSize(14)
                .fontColor('#111827')
            }
            
            Button('Support')
              .height(36)
              .backgroundColor('#2563EB')
              .borderRadius(8)
              .fontColor(Color.White)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .width('100%')
        .backgroundColor('#F3F4F6')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 1 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .alignItems(HorizontalAlign.Center)

      // Top App Bar Title (Overlaying the background)
      Text('Sign in')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .position({ x: 0, y: 40 })
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}