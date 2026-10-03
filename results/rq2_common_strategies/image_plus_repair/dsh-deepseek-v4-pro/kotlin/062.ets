class AppColors {
  static readonly primary: string = '#3B82F6'
  static readonly secondary: string = '#06B6D4'
  static readonly tertiary: string = '#0EA5E9'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#CBD5E1'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#1E293B'
}

@Entry
@Component
struct ThermoCurvePage {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  @Builder
  ModeButton(label: string, icon: string, current: string, onSelect: (s: string) => void) {
    Button() {
      Column() {
        Text(icon)
          .fontSize(32)
        Text(label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(label === current ? AppColors.primary : AppColors.surfaceVariant)
    .fontColor(label === current ? AppColors.onPrimary : AppColors.onSurface)
    .onClick(() => {
      onSelect(label)
    })
  }

  build() {
    Column() {
      Row() {
        Text('🌡️')
          .fontSize(28)
          .fontColor(AppColors.primary)
          .margin({ left: 12 })
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('☀️')
          .fontSize(22)
          .fontColor(AppColors.secondary)
          .margin({ right: 12 })
          .onClick(() => {
            this.targetTemp++
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      Column({ space: 26 }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: 12 }) {
          Button('–')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++
              }
            })
        }
        .alignItems(VerticalAlign.Center)

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color('#80CBD5E1')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Row({ space: 18 }) {
          this.ModeButton('Cool', '💨', this.mode, (s: string) => {
            this.mode = s
          })
          this.ModeButton('Heat', '☀️', this.mode, (s: string) => {
            this.mode = s
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(18)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
