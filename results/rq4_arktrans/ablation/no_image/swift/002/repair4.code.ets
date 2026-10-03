@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === NavigationView ===
      // props: {"_positional_raw":["StackNavigationViewStyle()"],"hidden":"true"}
      // modifiers: ["statusBar(hidden: true)","navigationViewStyle(StackNavigationViewStyle())"]
      // children: 1
      Stack() {
        // === ZStack ===
        // props: {"_positional_raw":["true"]}
        // modifiers: ["navigationBarHidden(true)"]
        // children: 1
        Stack() {
          // === ScrollView ===
          // children: 1
          Scroll() {
            // === VStack ===
            // props: {"spacing":"0"}
            // children: 7
            Column({ space: 0 }) {
              // === Text ===
              // props: {"text":"Sign in","_text_raw":"\"Sign in\"","_positional_raw":["AppTokens.Typography.display","AppTokens.Colors.onSurface",".top","36",".bottom","32"]}
              // modifiers: ["padding(.bottom, 32)","padding(.top, 36)","foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.display)"]
              Text('Sign in').padding({ bottom: 32 }).padding({ top: 36 }).fontColor('#FF111827').fontSize(22)

              // === VStack ===
              // props: {"alignment":".leading","spacing":"12","_positional_raw":["16","AppTokens.Colors.surface","12",".horizontal","16"],"RoundedRectangle(cornerRadius":"12) .stroke(AppTokens.Colors.outline, lineWidth: ...
              // modifiers: ["padding(.horizontal, 16)","shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 1)","overlay( RoundedRectangle(cornerRadius: 12) .stroke(AppTokens.Colors.outline,...","cornerRadius(12)","backg...
              // children: 5
              Column({ space: 12 }) {
                // === Text ===
                // props: {"text":"Welcome back","_text_raw":"\"Welcome back\"","_positional_raw":["AppTokens.Typography.headline","AppTokens.Colors.onSurface"]}
                // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.headline)"]
                Text('Welcome back').fontColor('#FF111827').fontSize(16)

                // === VStack ===
                // props: {"alignment":".leading","spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  // === Text ===
                  // props: {"text":"Email","_text_raw":"\"Email\"","_positional_raw":["AppTokens.Typography.label","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.label)"]
                  Text('Email').fontColor('#FF111827').fontSize(10)
                  // === TextField ===
                  // props: {"text":"$email","_text_raw":"\"\"","height":"40"}
                  // modifiers: ["frame(height: 40)","textFieldStyle(LoginTextFieldStyle())"]
                  // children: 1
                  TextInput().height(40)
                }

                // === VStack ===
                // props: {"alignment":".leading","spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  // === Text ===
                  // props: {"text":"Password","_text_raw":"\"Password\"","_positional_raw":["AppTokens.Typography.label","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.label)"]
                  Text('Password').fontColor('#FF111827').fontSize(10)
                  // === SecureField ===
                  // props: {"text":"$password","_text_raw":"\"\"","height":"40"}
                  // modifiers: ["frame(height: 40)","textFieldStyle(LoginTextFieldStyle())"]
                  // children: 1
                  TextInput().height(40)
                }

                // === HStack ===
                // props: {"_positional_raw":[".top","6"]}
                // modifiers: ["padding(.top, 6)"]
                // children: 3
                Row() {
                  // === Button ===
                  // props: {"text":"Forgot password?","_text_raw":"\"Forgot password?\"","_positional_raw":["AppTokens.Typography.label","AppTokens.Colors.tertiary"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.tertiary)","font(AppTokens.Typography.label)"]
                  Button() {
                    Text('Forgot password?')
                  }.fontColor('#FF2563EB').fontSize(10)
                  // === Spacer ===
                  Blank()
                  // === Button ===
                  // props: {"text":"Create account","_text_raw":"\"Create account\"","_positional_raw":["AppTokens.Typography.label","AppTokens.Colors.tertiary"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.tertiary)","font(AppTokens.Typography.label)"]
                  Button() {
                    Text('Create account')
                  }.fontColor('#FF2563EB').fontSize(10)
                }.padding({ top: 6 })

                // === Button ===
                // props: {"action":"{}","_positional_raw":["AppTokens.Colors.primary","8",".top","8"]}
                // modifiers: ["padding(.top, 8)","cornerRadius(8)","background(AppTokens.Colors.primary)"]
                Button() {
                  Text('Sign In')
                }.padding({ top: 8 }).borderRadius(8).backgroundColor('#FF111827')
              }.padding({ left: 16, right: 16 }).shadow({ radius: 4, color: '#24000000', offsetY: 1 }).borderRadius(12).border({ width: 1, color: '#FFE5E7EB' })

              // === HStack ===
              // props: {"_positional_raw":[".top","16",".bottom","16",".horizontal","16"]}
              // modifiers: ["padding(.horizontal, 16)","padding(.bottom, 16)","padding(.top, 16)"]
              // children: 3
              Row() {
                // === Rectangle ===
                // props: {"_positional_raw":["AppTokens.Colors.outline"],"height":"1"}
                // modifiers: ["frame(height: 1)","fill(AppTokens.Colors.outline)"]
                Rect().height(1).fill('#FFE5E7EB')
                // === Text ===
                // props: {"text":"Or continue with","_text_raw":"\"Or continue with\"","_positional_raw":["AppTokens.Typography.label","AppTokens.Colors.onSurface",".horizontal","8"]}
                // modifiers: ["padding(.horizontal, 8)","foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.label)"]
                Text('Or continue with').padding({ left: 8, right: 8 }).fontColor('#FF111827').fontSize(10)
                // === Rectangle ===
                // props: {"_positional_raw":["AppTokens.Colors.outline"],"height":"1"}
                // modifiers: ["frame(height: 1)","fill(AppTokens.Colors.outline)"]
                Rect().height(1).fill('#FFE5E7EB')
              }.padding({ left: 16, right: 16 }).padding({ top: 16, bottom: 16 })

              // === VStack ===
              // props: {"spacing":"6","_positional_raw":[".horizontal","16"]}
              // modifiers: ["padding(.horizontal, 16)"]
              // children: 1
              Column({ space: 6 }) {
                // === ForEach ===
                // props: {"_positional_raw":["socials"],"id":"\\.label"}
                // children: 1
                interface SocialItem {
                  label: string;
                  tint: string;
                }
                ForEach([
                  { label: 'Google', tint: '#FFDB4437' },
                  { label: 'Apple', tint: '#FF000000' }
                ] as SocialItem[], (item: SocialItem) => {
                  // === Button ===
                  // props: {"action":"{}","_positional_raw":["social.tint","8"]}
                  // modifiers: ["cornerRadius(8)","background(social.tint)"]
                  Button() {
                    Text(item.label)
                  }.borderRadius(8).backgroundColor(item.tint)
                })
              }.padding({ left: 16, right: 16 })

              // === Text ===
              // props: {"text":"By continuing you agree to the Terms and Privacy Policy","_text_raw":"\"By continuing you agree to the Terms and Privacy Policy\"","_positional_raw":"['AppTokens.Typography.label', 'AppTok...
              // modifiers: ["padding(.horizontal, 32)","padding(.top, 16)","multilineTextAlignment(.center)","foregroundColor(AppTokens.Colors.secondary)","font(AppTokens.Typography.label)"]
              Text('By continuing you agree to the Terms and Privacy Policy').padding({ left: 32, right: 32 }).padding({ top: 16 }).textAlign(TextAlign.Center).fontColor('#FF6B7280').fontSize(10)

              // === HStack ===
              // props: {"alignment":".center","_positional_raw":["16","AppTokens.Colors.surfaceVariant","12",".top","32",".horizontal","16"],"RoundedRectangle(cornerRadius":"12) .stroke(AppTokens.Colors.outline, lineWidt...
              // modifiers: ["padding(.horizontal, 16)","padding(.top, 32)","shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: 0.5)","overlay( RoundedRectangle(cornerRadius: 12) .stroke(AppTokens.Colors.outline,...","co...
              // children: 3
              Row() {
                // === VStack ===
                // props: {"alignment":".leading","spacing":"2"}
                // children: 2
                Column({ space: 2 }) {
                  // === Text ===
                  // props: {"text":"Need help?","_text_raw":"\"Need help?\"","_positional_raw":["AppTokens.Typography.title","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.title)"]
                  Text('Need help?').fontColor('#FF111827').fontSize(14)
                  // === Text ===
                  // props: {"text":"Contact support@example.com","_text_raw":"\"Contact support@example.com\"","_positional_raw":["AppTokens.Typography.body","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.Typography.body)"]
                  Text('Contact support@example.com').fontColor('#FF111827').fontSize(12)
                }
                // === Spacer ===
                Blank()
                // === Button ===
                // props: {"action":"{}","_positional_raw":["AppTokens.Colors.tertiary","8"]}
                // modifiers: ["cornerRadius(8)","background(AppTokens.Colors.tertiary)"]
                Button() {
                  Text('Help')
                }.borderRadius(8).backgroundColor('#FF2563EB')
              }.padding({ left: 16, right: 16 }).padding({ top: 32 }).shadow({ radius: 2, color: '#1A000000', offsetY: 0.5 }).borderRadius(12).border({ width: 1, color: '#FFE5E7EB' })

              // === Spacer ===
              // props: {"height":"32"}
              // modifiers: ["frame(height: 32)"]
              Blank().height(32)
            }
          }
        }
      }
    }.width('100%').height('100%')
  }
}