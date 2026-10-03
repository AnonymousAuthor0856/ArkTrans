class AppTokens {
  static readonly Colors = {
    primary: '#FF06B6D4',
    secondary: '#FF3B82F6',
    tertiary: '#FF8B5CF6',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
    surface90: '#E6FFFFFF'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }
}

@Entry
@Component
struct BillCalendar {
  @State spending: number = 500.0
  private goal: number = 1000.0

  build() {
    Column() {
      Stack() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Scroll() {
        Column() {
          Stack() {
            Column() {
              Text('Current Spending')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.primary)

              Blank()

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
                .width('100%')
                .height(8)
                .color(AppTokens.Colors.primary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(160)
          .borderRadius(20)
          .backgroundColor(AppTokens.Colors.surface90)
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 16 })

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.spending = value
            })

          Button('Reset') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.tertiary)
          .margin({ top: 16 })
          .onClick(() => {
            this.spending = 0.0
          })
        }
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}