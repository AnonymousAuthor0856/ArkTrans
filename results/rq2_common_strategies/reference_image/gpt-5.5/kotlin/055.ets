const NAME: string = '082_WorkoutPlan_en'
const UI_TYPE: string = 'Health Auth'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#38BDF8'
  static readonly tertiary: string = '#3B82F6'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#1E293B'
  static readonly secondaryTint: string = '#1A38BDF8'
  static readonly primaryTint: string = '#262563EB'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)

        Column({ space: AppSpacing.lg }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')

          Stack({ alignContent: Alignment.Center }) {
            Text('Workout Preview')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({
            width: 1,
            color: AppColors.outline
          })

          Button('Authenticate', { type: ButtonType.Normal, stateEffect: true })
            .width('80%')
            .height(52)
            .borderRadius(26)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.secondaryTint, 0.0],
            [AppColors.primaryTint, 1.0]
          ]
        })

        Row() {
          Text('Home')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Text('Plan')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 8,
          color: '#24000000',
          offsetX: 0,
          offsetY: -2
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Text('+')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .shadow({
        radius: 12,
        color: '#33000000',
        offsetX: 0,
        offsetY: 6
      })
      .margin({
        right: AppSpacing.lg,
        bottom: 96
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}