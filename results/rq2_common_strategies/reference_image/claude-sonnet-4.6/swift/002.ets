// Index.ets
// ArkTS conversion of the SwiftUI `AuthLoginApp` ContentView (Sign in screen).
// Preview: open this file in DevEco Studio and use the Previewer (right-hand panel),
// or run on a device/emulator from the entry module.

// MARK: - Design Tokens
class AppTokens {
  // Colors
  static readonly primary: string = '#111827';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly secondary: string = '#6B7280';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly tertiary: string = '#2563EB';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly background: string = '#F9FAFB';
  static readonly onBackground: string = '#0B1220';
  static readonly surface: string = '#FFFFFF';
  static readonly onSurface: string = '#111827';
  static readonly surfaceVariant: string = '#F3F4F6';
  static readonly outline: string = '#E5E7EB';

  // Typography (font sizes in fp)
  static readonly display: number = 22;
  static readonly headline: number = 16;
  static readonly title: number = 14;
  static readonly body: number = 12;
  static readonly label: number = 10;

  // Spacing (vp)
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;

  // Radii
  static readonly radiusSmall: number = 4;
  static readonly radiusMedium: number = 8;
  static readonly radiusLarge: number = 12;

  // Elevation shadows (alpha in the first byte of #AARRGGBB, matching .black.opacity(...))
  static readonly shadowCard: string = '#24000000'; // 0.14
  static readonly shadowHelp: string = '#1A000000'; // 0.10
}

// MARK: - Data Models
interface SocialItem {
  label: string;
  tint: string;
}

// MARK: - Main Content
@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.primary },
    { label: 'Continue with Google', tint: AppTokens.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.secondary }
  ];

  // MARK: - Reusable pieces
  @Builder
  FieldLabel(text: string) {
    Text(text)
      .fontSize(AppTokens.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.onSurface)
      .width('100%')
      .textAlign(TextAlign.Start)
  }

  @Builder
  LinkText(text: string) {
    Text(text)
      .fontSize(AppTokens.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.tertiary)
      .onClick(() => {
        // TODO: handle tap
      })
  }

  @Builder
  PrimaryActionButton(label: string, height: number, bgColor: string, fgColor: string) {
    Button(label)
      .type(ButtonType.Normal)
      .width('100%')
      .height(height)
      .borderRadius(AppTokens.radiusMedium)
      .backgroundColor(bgColor)
      .fontColor(fgColor)
      .fontSize(AppTokens.title)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
        // TODO: handle tap
      })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          // Header — extra bottom whitespace
          Text('Sign in')
            .fontSize(AppTokens.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.onSurface)
            .margin({ top: 36, bottom: 32 })

          // MARK: Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(AppTokens.headline)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Email field
            Column({ space: 4 }) {
              this.FieldLabel('Email')

              TextInput({ placeholder: '', text: this.email })
                .type(InputType.Normal)
                .height(40)
                .width('100%')
                .fontSize(AppTokens.body)
                .fontColor(AppTokens.onSurface)
                .placeholderColor(AppTokens.secondary)
                .caretColor(AppTokens.tertiary)
                .backgroundColor(Color.Transparent)
                .borderRadius(AppTokens.radiusMedium)
                .border({ width: 1, color: AppTokens.outline })
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                  this.email = value;
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Password field
            Column({ space: 4 }) {
              this.FieldLabel('Password')

              TextInput({ placeholder: '', text: this.password })
                .type(InputType.Password)
                .height(40)
                .width('100%')
                .fontSize(AppTokens.body)
                .fontColor(AppTokens.onSurface)
                .placeholderColor(AppTokens.secondary)
                .caretColor(AppTokens.tertiary)
                .backgroundColor(Color.Transparent)
                .borderRadius(AppTokens.radiusMedium)
                .border({ width: 1, color: AppTokens.outline })
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                  this.password = value;
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Links
            Row() {
              this.LinkText('Forgot password?')
              Blank()
              this.LinkText('Create account')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 6 })

            // Sign in button
            this.PrimaryActionButton('Sign in', 40, AppTokens.primary, AppTokens.onPrimary)

            // extra top gap for the CTA (SwiftUI: .padding(.top, 8) on the button)
            Row()
              .height(0)
              .width('100%')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(16)
          .backgroundColor(AppTokens.surface)
          .borderRadius(AppTokens.radiusLarge)
          .border({ width: 1, color: AppTokens.outline })
          .shadow({
            radius: 4,
            color: AppTokens.shadowCard,
            offsetX: 0,
            offsetY: 1
          })

          // MARK: Divider
          Row() {
            Row()
              .height(1)
              .layoutWeight(1)
              .backgroundColor(AppTokens.outline)

            Text('Or continue with')
              .fontSize(AppTokens.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.onSurface)
              .padding({ left: 8, right: 8 })

            Row()
              .height(1)
              .layoutWeight(1)
              .backgroundColor(AppTokens.outline)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16 })

          // MARK: Social buttons
          Column({ space: 6 }) {
            ForEach(
              this.socials,
              (item: SocialItem) => {
                this.PrimaryActionButton(item.label, 36, item.tint, AppTokens.onPrimary)
              },
              (item: SocialItem) => item.label
            )
          }
          .width('100%')

          // MARK: Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.secondary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ top: 16 })

          // MARK: Help section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(AppTokens.title)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              Row() {
                Text('Contact ')
                  .fontSize(AppTokens.body)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppTokens.onSurface)

                Text('support@example.com')
                  .fontSize(AppTokens.body)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppTokens.tertiary)
                  .decoration({
                    type: TextDecorationType.Underline,
                    color: AppTokens.tertiary
                  })
              }
              .alignItems(VerticalAlign.Center)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Button('Support')
              .type(ButtonType.Normal)
              .height(32)
              .borderRadius(AppTokens.radiusMedium)
              .backgroundColor(AppTokens.tertiary)
              .fontColor(AppTokens.onTertiary)
              .fontSize(AppTokens.title)
              .fontWeight(FontWeight.Medium)
              .padding({ left: 12, right: 12 })
              .onClick(() => {
                // TODO: handle tap
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding(16)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.radiusLarge)
          .border({ width: 1, color: AppTokens.outline })
          .shadow({
            radius: 2,
            color: AppTokens.shadowHelp,
            offsetX: 0,
            offsetY: 0.5
          })
          .margin({ top: 32 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        // horizontal padding for every block (card, divider, socials) + bottom spacer
        .padding({ left: 16, right: 16, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}