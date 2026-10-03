// NAME: 082_WorkoutPlan_en
// UI_TYPE: Health Auth
// STYLE_THEME: Modern Blue
// LANG: en
// BASELINE_SIZE: 720x1280

class ColorTokens {
  primary: string = '#FF2563EB'
  secondary: string = '#FF38BDF8'
  tertiary: string = '#FF3B82F6'
  background: string = '#FFF8FAFC'
  surface: string = '#FFFFFFFF'
  surfaceVariant: string = '#FFE2E8F0'
  outline: string = '#FFCBD5E1'
  success: string = '#FF22C55E'
  warning: string = '#FFF59E0B'
  error: string = '#FFEF4444'
  onPrimary: string = '#FFFFFFFF'
  onSecondary: string = '#FF0F172A'
  onTertiary: string = '#FFFFFFFF'
  onBackground: string = '#FF0F172A'
  onSurface: string = '#FF1E293B'
}

class SpacingTokens {
  xs: Length = 4
  sm: Length = 8
  md: Length = 12
  lg: Length = 16
  xl: Length = 24
  xxl: Length = 36
}

@Observed
class AppTokens {
  static Colors: ColorTokens = new ColorTokens()
  static Spacing: SpacingTokens = new SpacingTokens()
}

@Component
struct TopBar {
  build() {
    Row() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct BottomBar {
  @State selectedIndex: number = 1

  build() {
    Row() {
      Text('Home')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedIndex === 0 ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .onClick(() => { this.selectedIndex = 0 })

      Text('Plan')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedIndex === 1 ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .onClick(() => { this.selectedIndex = 1 })

      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedIndex === 2 ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .onClick(() => { this.selectedIndex = 2 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })
  }
}

@Component
struct FloatingButton {
  build() {
    Stack() {
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(AppTokens.Colors.primary)
    .shadow({ radius: 8, color: 'rgba(37,99,235,0.4)', offsetY: 4 })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopBar()

        Column() {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: 16 })

          Stack({ alignContent: Alignment.Center }) {
            Text('Workout Preview')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin({ bottom: 16 })

          Button('Authenticate', { type: ButtonType.Normal })
            .width('80%')
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(16)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(56,189,248,0.1)', 0.0],
            ['rgba(37,99,235,0.15)', 1.0]
          ]
        })

        BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      FloatingButton()
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
