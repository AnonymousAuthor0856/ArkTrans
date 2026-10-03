@Entry
@Component
struct AuthLoginApp {
  @State email: string = ''
  @State password: string = ''

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: '#111827' },
    { label: 'Continue with Google', tint: '#2563EB' },
    { label: 'Continue with GitHub', tint: '#6B7280' }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .padding({ top: 36, bottom: 32 })

        List() {
          // Login Card
          ListItem() {
            Column({ space: 12 }) {
              Text('Welcome back')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')

              // Email field
              Column({ space: 4 }) {
                Text('Email')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#111827')
                TextInput({ placeholder: '', text: this.email })
                  .width('100%')
                  .height(40)
                  .border({ width: 1, color: '#E5E7EB' })
                  .borderRadius(8)
                  .padding({ left: 12 })
                  .onChange((value: string) => { this.email = value })
              }

              // Password field
              Column({ space: 4 }) {
                Text('Password')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#111827')
                TextInput({ placeholder: '', text: this.password })
                  .width('100%')
                  .height(40)
                  .border({ width: 1, color: '#E5E7EB' })
                  .borderRadius(8)
                  .padding({ left: 12 })
                  .type(InputType.Password)
                  .onChange((value: string) => { this.password = value })
              }

              // Links row
              Row() {
                Button() {
                  Text('Forgot password?')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2563EB')
                }
                .onClick(() => {})
                Blank()
                Button() {
                  Text('Create account')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2563EB')
                }
                .onClick(() => {})
              }
              .padding({ top: 6 })

              // Sign In button
              Button() {
                Text('Sign in')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .width('100%')
                  .height(40)
              }
              .backgroundColor('#111827')
              .borderRadius(8)
              .width('100%')
              .height(40)
              .onClick(() => {})
            }
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#E5E7EB' })
            .shadow({ radius: 4, color: '#24000000' })
          }

          // Divider with text
          ListItem() {
            Row() {
              Divider().height(1).color('#E5E7EB')
              Text('Or continue with')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
                .padding({ left: 8, right: 8 })
              Divider().height(1).color('#E5E7EB')
            }
            .padding({ top: 16, bottom: 16 })
          }

          // Social buttons
          ListItem() {
            Column({ space: 6 }) {
              ForEach(this.socials, (social: SocialItem) => {
                Button() {
                  Text(social.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                    .width('100%')
                    .height(36)
                }
                .backgroundColor(social.tint)
                .borderRadius(8)
                .width('100%')
                .height(36)
                .onClick(() => {})
              })
            }
          }

          // Terms text
          ListItem() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#6B7280')
              .textAlign(TextAlign.Center)
              .padding({ top: 16, left: 32, right: 32 })
          }

          // Help section
          ListItem() {
            Row() {
              Column({ space: 2 }) {
                Text('Need help?')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#111827')
                Text('Contact support@example.com')
                  .fontSize(12)
                  .fontColor('#111827')
              }
              Blank()
              Button() {
                Text('Support')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .height(32)
                  .padding({ left: 12, right: 12 })
              }
              .backgroundColor('#2563EB')
              .borderRadius(8)
              .height(32)
              .onClick(() => {})
            }
            .padding(16)
            .backgroundColor('#F3F4F6')
            .borderRadius(12)
            .border({ width: 1, color: '#E5E7EB' })
            .shadow({ radius: 2, color: '#1A000000' })
          }

          // Bottom spacer (fixed: use Column instead of Blank)
          ListItem() {
            Column().height(32)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F9FAFB')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
  }
}

interface SocialItem {
  label: string
  tint: string
}