class AppColors {
  static readonly primary: ResourceColor = '#2563EB'
  static readonly secondary: ResourceColor = '#38BDF8'
  static readonly tertiary: ResourceColor = '#60A5FA'
  static readonly background: ResourceColor = '#E6F0FF'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E2E8F0'
  static readonly outline: ResourceColor = '#CBD5E1'
  static readonly success: ResourceColor = '#22C55E'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#0F172A'
  static readonly onTertiary: ResourceColor = '#FFFFFF'
  static readonly onBackground: ResourceColor = '#0F172A'
  static readonly onSurface: ResourceColor = '#1E293B'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.primary)

          Text('<')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width(24)
        .height(24)
        .margin({ left: AppSpacing.lg })
        .onClick(() => {
        })

        Blank()

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .maxLines(1)

        Blank()

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.secondary)

          Text('?')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .width(24)
        .height(24)
        .margin({ right: AppSpacing.lg })
        .onClick(() => {
        })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(160)
            .height(160)
            .fill(AppColors.surface)
            .stroke(AppColors.outline)
            .strokeWidth(2)

          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Sign In')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}