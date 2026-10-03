import { Window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

@Entry
@Component
struct LoginScreen {
  @State email: string = '';
  @State password: string = '';

  // AppTokens Colors
  private readonly primary: ResourceColor = '#111827';
  private readonly onPrimary: ResourceColor = '#FFFFFF';
  private readonly secondary: ResourceColor = '#6B7280';
  private readonly tertiary: ResourceColor = '#2563EB';
  private readonly background: ResourceColor = '#F9FAFB';
  private readonly surface: ResourceColor = '#FFFFFF';
  private readonly onSurface: ResourceColor = '#111827';
  private readonly outline: ResourceColor = '#E5E7EB';
  private readonly surfaceVariant: ResourceColor = '#F3F4F6';

  // Spacing
  private readonly spacingXs: number = 2;
  private readonly spacingSm: number = 4;
  private readonly spacingMd: number = 6;
  private readonly spacingLg: number = 8;
  private readonly spacingXl: number = 12;
  private readonly spacingXxl: number = 16;
  private readonly spacingXxxl: number = 24;

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column() {
          // Main Card
          Column() {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)
              .margin({ bottom: this.spacingLg })

            // Email Field
            Column() {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurface)
                .margin({ bottom: this.spacingSm })

              TextInput({ placeholder: '' })
                .type(InputType.Email)
                .text(this.email)
                .onChange((value: string) => {
                  this.email = value;
                })
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(this.outline)
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                .height(44)
            }
            .width('100%')
            .margin({ bottom: this.spacingMd })

            // Password Field
            Column() {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurface)
                .margin({ bottom: this.spacingSm })

              TextInput({ placeholder: '' })
                .type(InputType.Password)
                .text(this.password)
                .onChange((value: string) => {
                  this.password = value;
                })
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(this.outline)
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                .height(44)
            }
            .width('100%')
            .margin({ bottom: this.spacingSm })

            // Links Row
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.tertiary)
                .onClick(() => {
                  // Handle forgot password
                })

              Blank()

              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.tertiary)
                .onClick(() => {
                  // Handle create account
                })
            }
            .width('100%')
            .margin({ top: this.spacingSm, bottom: this.spacingLg })

            // Sign In Button
            Button('Sign in')
              .width('100%')
              .height(44)
              .backgroundColor(this.primary)
              .fontColor(this.onPrimary)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
              .onClick(() => {
                // Handle sign in
              })
          }
          .width('100%')
          .padding({ left: this.spacingXl, right: this.spacingXl, top: this.spacingXl, bottom: this.spacingXl })
          .backgroundColor(this.surface)
          .borderRadius(12)
          .border({ width: 1, color: this.outline })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
          .margin({ bottom: this.spacingLg })

          // Divider Section
          Row() {
            Divider().color(this.outline).layoutWeight(1)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurface)
              .margin({ left: this.spacingMd, right: this.spacingMd })
            Divider().color(this.outline).layoutWeight(1)
          }
          .width('100%')
          .margin({ left: this.spacingXl, right: this.spacingXl, bottom: this.spacingSm })

          // Social Buttons
          Column() {
            Button('Continue with Apple')
              .width('100%')
              .height(40)
              .backgroundColor('#111827')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
              .margin({ bottom: this.spacingSm })

            Button('Continue with Google')
              .width('100%')
              .height(40)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
              .margin({ bottom: this.spacingSm })

            Button('Continue with GitHub')
              .width('100%')
              .height(40)
              .backgroundColor('#6B7280')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
          }
          .width('100%')
          .margin({ bottom: this.spacingSm })

          // Terms Text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: this.spacingSm, bottom: this.spacingXxl })

          // Support Card
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurface)
                .margin({ bottom: this.spacingXs })
              
              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(this.onSurface)
            }
            
            Button('Support')
              .height(36)
              .backgroundColor(this.tertiary)
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
              .margin({ left: this.spacingMd })
          }
          .width('100%')
          .padding({ left: this.spacingXl, right: this.spacingXl, top: this.spacingLg, bottom: this.spacingLg })
          .backgroundColor(this.surfaceVariant)
          .borderRadius(12)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.10)', offsetY: 0.5 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          
          // Bottom Spacer
          Column().height(this.spacingXxl)
        }
        .width('100%')
        .padding({ left: this.spacingXl, right: this.spacingXl })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(Efffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}