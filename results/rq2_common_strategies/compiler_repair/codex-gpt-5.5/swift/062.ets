class AppColors {
  static primary: string = '#3B82F6'
  static secondary: string = '#06B6D4'
  static tertiary: string = '#0EA5E9'
  static background: string = '#F0F9FF'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E0F2FE'
  static outline: string = '#CBD5E1'
  static onPrimary: string = '#FFFFFF'
  static onBackground: string = '#0F172A'
  static onSurface: string = '#1E293B'
}

class AppSpacing {
  static sm: number = 8
  static md: number = 12
  static lg: number = 18
  static xl: number = 26
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 18
}

@Entry
@Component
struct Index {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  @Builder
  TopBar() {
    Row() {
      Text('T')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width(40)
        .textAlign(TextAlign.Center)

      Blank()
        .layoutWeight(1)

      Text('ThermoCurve')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Blank()
        .layoutWeight(1)

      Button('Sun')
        .fontSize(12)
        .fontColor(AppColors.secondary)
        .width(48)
        .height(36)
        .backgroundColor('#00FFFFFF')
        .onClick(() => {
          this.targetTemp += 1
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
  }

  @Builder
  TempButton(label: string, isPlus: boolean) {
    Button(label)
      .fontSize(20)
      .fontColor(AppColors.onPrimary)
      .width(60)
      .height(60)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShape.small)
      .onClick(() => {
        if (isPlus) {
          if (this.targetTemp < 35) {
            this.targetTemp += 1
          }
        } else {
          if (this.targetTemp > 10) {
            this.targetTemp -= 1
          }
        }
      })
  }

  @Builder
  ModeButton(label: string, iconText: string) {
    Column({ space: AppSpacing.sm }) {
      Text(iconText)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
      Text(label)
        .fontSize(12)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.mode === label ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(50)
    .shadow({ radius: 5, color: '#1A000000', offsetY: 5 })
    .onClick(() => {
      this.mode = label
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(this.targetTemp.toString() + ' C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          this.TempButton('-', false)
          this.TempButton('+', true)
        }
        .justifyContent(FlexAlign.Center)

        Rect()
          .width('80%')
          .height(1)
          .fill('#80CBD5E1')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          this.ModeButton('Cool', 'Wind')
          this.ModeButton('Heat', 'Sun')
        }
        .justifyContent(FlexAlign.Center)

        Text('Current Mode: ' + this.mode)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
  }
}
