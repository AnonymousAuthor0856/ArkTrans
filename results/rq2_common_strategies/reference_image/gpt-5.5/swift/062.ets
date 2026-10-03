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

class AppTypography {
  static readonly displaySize: number = 26
  static readonly headlineSize: number = 18
  static readonly titleSize: number = 14
  static readonly bodySize: number = 12
}

class AppShapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 12
  static readonly largeCornerRadius: number = 18
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 18
  static readonly xl: number = 26
}

@Component
struct ThermometerIcon {
  @Prop iconColor: string = AppColors.primary

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Blank()
        .width(10)
        .height(25)
        .border({
          width: 2,
          color: this.iconColor
        })
        .borderRadius(6)
        .backgroundColor(AppColors.surfaceVariant)
        .translate({ y: -3 })

      Blank()
        .width(16)
        .height(16)
        .border({
          width: 2,
          color: this.iconColor
        })
        .borderRadius(8)
        .backgroundColor(AppColors.surfaceVariant)
        .translate({ y: 10 })

      Blank()
        .width(4)
        .height(18)
        .borderRadius(2)
        .backgroundColor(this.iconColor)
        .translate({ y: 2 })

      Column({ space: 3 }) {
        Blank()
          .width(8)
          .height(2)
          .borderRadius(1)
          .backgroundColor(this.iconColor)

        Blank()
          .width(6)
          .height(2)
          .borderRadius(1)
          .backgroundColor(this.iconColor)

        Blank()
          .width(8)
          .height(2)
          .borderRadius(1)
          .backgroundColor(this.iconColor)
      }
      .translate({ x: 13, y: -5 })
    }
    .width(32)
    .height(32)
  }
}

@Component
struct ModeButton {
  @Prop label: string = ''
  @Prop iconName: string = ''
  @Prop currentMode: string = ''
  onSelect: (value: string) => void = () => {
  }

  private isSelected(): boolean {
    return this.label === this.currentMode
  }

  build() {
    Button({ type: ButtonType.Normal }) {
      Column({ space: 6 }) {
        if (this.iconName === 'wind') {
          Text('≋')
            .fontSize(38)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected() ? AppColors.onPrimary : AppColors.onSurface)
            .height(38)
            .textAlign(TextAlign.Center)
            .rotate({ angle: -8 })
        } else {
          Text('☀')
            .fontSize(35)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected() ? AppColors.onPrimary : AppColors.onSurface)
            .height(38)
            .textAlign(TextAlign.Center)
        }

        Text(this.label)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isSelected() ? AppColors.onPrimary : AppColors.onSurface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(100)
    .padding(0)
    .borderRadius(50)
    .backgroundColor(this.isSelected() ? AppColors.primary : AppColors.surfaceVariant)
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 5
    })
    .stateEffect(false)
    .onClick(() => {
      this.onSelect(this.label)
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private targetTemp: number = 22
  @State private mode: string = 'Cool'

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        ThermometerIcon({ iconColor: AppColors.primary })
          .align(Alignment.Start)
          .margin({ left: AppSpacing.md })

        Text('ThermoCurve')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Button({ type: ButtonType.Normal }) {
          Text('☀')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.secondary)
            .textAlign(TextAlign.Center)
        }
        .width(48)
        .height(56)
        .padding(0)
        .backgroundColor('#00000000')
        .stateEffect(false)
        .align(Alignment.End)
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          this.targetTemp += 1
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surfaceVariant)

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          Button({ type: ButtonType.Normal }) {
            Text('–')
              .fontSize(28)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
              .textAlign(TextAlign.Center)
          }
          .width(60)
          .height(60)
          .padding(0)
          .borderRadius(AppShapes.smallCornerRadius)
          .backgroundColor(AppColors.primary)
          .stateEffect(false)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1
            }
          })

          Button({ type: ButtonType.Normal }) {
            Text('+')
              .fontSize(28)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
              .textAlign(TextAlign.Center)
          }
          .width(60)
          .height(60)
          .padding(0)
          .borderRadius(AppShapes.smallCornerRadius)
          .backgroundColor(AppColors.primary)
          .stateEffect(false)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Divider()
          .width('80%')
          .height(1)
          .strokeWidth(1)
          .color(AppColors.outline)
          .opacity(0.5)

        Text('Mode')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: 'wind',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: 'sun',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(6, 182, 212, 0.15)', 0.0],
          ['rgba(59, 130, 246, 0.20)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}