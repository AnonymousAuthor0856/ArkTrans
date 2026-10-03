// Index.ets — Authentication Login (Minimal Monochrome)
// HarmonyOS ArkTS / ArkUI

interface SocialItem {
  label: string;
  tint: string;
}

// ---------------------------------------------------------------- tokens
const COLOR_PRIMARY: string = '#111827';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_SECONDARY: string = '#6B7280';
const COLOR_TERTIARY: string = '#2563EB';
const COLOR_BACKGROUND: string = '#F9FAFB';
const COLOR_ON_BACKGROUND: string = '#0B1220';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#111827';
const COLOR_SURFACE_VARIANT: string = '#F3F4F6';
const COLOR_OUTLINE: string = '#E5E7EB';

const SPACE_XS: number = 2;
const SPACE_SM: number = 4;
const SPACE_MD: number = 6;
const SPACE_LG: number = 8;
const SPACE_XL: number = 12;
const SPACE_XXL: number = 16;
const SPACE_XXXL: number = 24;

const RADIUS_SMALL: number = 4;
const RADIUS_MEDIUM: number = 8;
const RADIUS_LARGE: number = 12;

const FS_DISPLAY: number = 22;
const LH_DISPLAY: number = 28;
const FS_HEADLINE: number = 16;
const LH_HEADLINE: number = 22;
const FS_TITLE: number = 14;
const LH_TITLE: number = 18;
const FS_BODY: number = 12;
const LH_BODY: number = 16;
const FS_LABEL: number = 10;
const LH_LABEL: number = 14;

const ELEV_1: number = 1;
const ELEV_2: number = 2;

const SOCIALS: SocialItem[] = [
  { label: 'Continue with Apple', tint: COLOR_PRIMARY },
  { label: 'Continue with Google', tint: COLOR_TERTIARY },
  { label: 'Continue with GitHub', tint: COLOR_SECONDARY }
];

@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';

  build() {
    Column() {
      // -------- CenterAlignedTopAppBar --------
      Row() {
        Text('Sign in')
          .fontSize(FS_DISPLAY)
          .lineHeight(LH_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // -------- scrollable body --------
      Scroll() {
        Column({ space: SPACE_LG }) {
          // ================= Card: sign-in form =================
          Column({ space: SPACE_LG }) {
            Text('Welcome back')
              .fontSize(FS_HEADLINE)
              .lineHeight(LH_HEADLINE)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_SURFACE)

            Column({ space: SPACE_MD }) {
              Text('Email')
                .fontSize(FS_LABEL)
                .lineHeight(LH_LABEL)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)

              TextInput({ text: this.email, placeholder: '' })
                .type(InputType.Email)
                .maxLines(1)
                .width('100%')
                .height(44)
                .fontSize(FS_BODY)
                .fontColor(COLOR_ON_SURFACE)
                .backgroundColor(COLOR_SURFACE)
                .borderRadius(RADIUS_MEDIUM)
                .borderWidth(1)
                .borderColor(COLOR_OUTLINE)
                .padding({ left: SPACE_XL, right: SPACE_XL })
                .caretColor(COLOR_TERTIARY)
                .onChange((value: string) => {
                  this.email = value;
                })

              Text('Password')
                .fontSize(FS_LABEL)
                .lineHeight(LH_LABEL)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .maxLines(1)
                .width('100%')
                .height(44)
                .fontSize(FS_BODY)
                .fontColor(COLOR_ON_SURFACE)
                .backgroundColor(COLOR_SURFACE)
                .borderRadius(RADIUS_MEDIUM)
                .borderWidth(1)
                .borderColor(COLOR_OUTLINE)
                .padding({ left: SPACE_XL, right: SPACE_XL })
                .caretColor(COLOR_TERTIARY)
                .onChange((value: string) => {
                  this.password = value;
                })

              Row() {
                Text('Forgot password?')
                  .fontSize(FS_LABEL)
                  .lineHeight(LH_LABEL)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_TERTIARY)

                Text('Create account')
                  .fontSize(FS_LABEL)
                  .lineHeight(LH_LABEL)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_TERTIARY)
              }
              .width('100%')
              .margin({ top: SPACE_SM })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button() {
              Text('Sign in')
                .fontSize(FS_TITLE)
                .lineHeight(LH_TITLE)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_PRIMARY)
            }
            .type(ButtonType.Normal)
            .width('100%')
            .height(44)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(RADIUS_MEDIUM)
            .onClick(() => {
            })
          }
          .width('100%')
          .padding({ left: SPACE_XL, right: SPACE_XL, top: SPACE_XL, bottom: SPACE_XL })
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(RADIUS_LARGE)
          .borderWidth(1)
          .borderColor(COLOR_OUTLINE)
          .shadow({
            radius: 4,
            color: '#24000000',
            offsetX: 0,
            offsetY: ELEV_2
          })

          // ================= Divider row =================
          Row({ space: SPACE_MD }) {
            Divider()
              .layoutWeight(1)
              .color(COLOR_OUTLINE)
              .strokeWidth(1)
              .vertical(false)

            Text('Or continue with')
              .fontSize(FS_LABEL)
              .lineHeight(LH_LABEL)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)

            Divider()
              .layoutWeight(1)
              .color(COLOR_OUTLINE)
              .strokeWidth(1)
              .vertical(false)
          }
          .width('100%')
          .padding({ left: SPACE_XL, right: SPACE_XL })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          // ================= Social buttons =================
          Column({ space: SPACE_SM }) {
            ForEach(SOCIALS, (item: SocialItem) => {
              Button() {
                Text(item.label)
                  .fontSize(FS_TITLE)
                  .lineHeight(LH_TITLE)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_PRIMARY)
              }
              .type(ButtonType.Normal)
              .width('100%')
              .height(40)
              .backgroundColor(item.tint)
              .borderRadius(RADIUS_MEDIUM)
              .onClick(() => {
              })
            }, (item: SocialItem) => item.label)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // ================= Legal note =================
          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(FS_LABEL)
              .lineHeight(LH_LABEL)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_SECONDARY)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .padding({ top: SPACE_SM, bottom: SPACE_SM })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          // ================= Support surface =================
          Row() {
            Column({ space: SPACE_XS }) {
              Text('Need help?')
                .fontSize(FS_TITLE)
                .lineHeight(LH_TITLE)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)

              Text('Contact support@example.com')
                .fontSize(FS_BODY)
                .lineHeight(LH_BODY)
                .fontColor(COLOR_ON_SURFACE)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Button() {
              Text('Support')
                .fontSize(FS_TITLE)
                .lineHeight(LH_TITLE)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_PRIMARY)
            }
            .type(ButtonType.Normal)
            .height(36)
            .padding({ left: SPACE_XXL, right: SPACE_XXL })
            .backgroundColor(COLOR_TERTIARY)
            .borderRadius(RADIUS_MEDIUM)
            .onClick(() => {
            })
          }
          .width('100%')
          .padding({ left: SPACE_XL, right: SPACE_XL, top: SPACE_LG, bottom: SPACE_LG })
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(RADIUS_LARGE)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: ELEV_1
          })

          Blank().height(SPACE_XXL)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ left: SPACE_XL, right: SPACE_XL, top: SPACE_LG, bottom: SPACE_LG })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }
}