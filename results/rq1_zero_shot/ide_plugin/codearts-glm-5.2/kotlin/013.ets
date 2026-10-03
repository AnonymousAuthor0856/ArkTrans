const AppColors = {
  primary: '#EF476F',
  secondary: '#FFD166',
  tertiary: '#06D6A0',
  background: '#FFFCF2',
  surface: '#FFF8E1',
  surfaceVariant: '#FCE7E7',
  outline: '#BDBDBD',
  success: '#06D6A0',
  warning: '#FFA600',
  error: '#D62828',
  onPrimary: '#FFFFFF',
  onSecondary: '#1F1F1F',
  onTertiary: '#1F1F1F',
  onBackground: '#1F1F1F',
  onSurface: '#1F1F1F'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State knobX: number = 300
  @State knobY: number = 300

  build() {
    Column() {
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(240)
            .height(240)
            .border({ width: 12, color: AppColors.secondary })
            .borderRadius(120)

          Column()
            .width(40)
            .height(40)
            .backgroundColor(AppColors.primary)
            .borderRadius(20)
            .margin({ left: this.knobX - 140, top: this.knobY - 140 })
        }
        .width(280)
        .height(280)
        .backgroundColor(AppColors.surface)
        .border({ width: 3, color: AppColors.outline, radius: 16 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.knobX = event.fingerList[0].localX
              this.knobY = event.fingerList[0].localY
            })
        )

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Row() {
          Button('Play')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(12)
            .width(120)
            .height(48)

          Button('Pause')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(12)
            .width(120)
            .height(48)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Text(`Knob X:${Math.floor(this.knobX)} Y:${Math.floor(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)

        Blank().height(AppSpacing.xxl)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}