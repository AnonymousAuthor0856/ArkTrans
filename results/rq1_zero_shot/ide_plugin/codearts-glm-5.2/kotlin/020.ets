const AppColors = {
  primary: '#FF7A00',
  secondary: '#FFC300',
  tertiary: '#FFF3C0',
  background: '#FFF8E7',
  surface: '#FFFFFF',
  surfaceVariant: '#FFEBC8',
  outline: '#BCA789',
  success: '#28A745',
  warning: '#FFC107',
  error: '#DC3545',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
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
  @State knobX: number = 0
  @State knobY: number = 0
  @State powerOn: boolean = false

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(400)
            .height(400)
            .backgroundColor('#33FFC300')
            .borderRadius(200)

          Column()
            .width(48)
            .height(48)
            .backgroundColor(AppColors.primary)
            .borderRadius(24)
            .margin({ left: this.knobX, top: this.knobY })
        }
        .width(280)
        .height(280)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(24)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.knobX = event.fingerList[0].localX - 140
              this.knobY = event.fingerList[0].localY - 140
            })
        )

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppColors.success : AppColors.error)

        Row() {
          Button(this.powerOn ? 'Off' : 'On')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(40)
            .width(80)
            .height(80)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

          Button('Reset')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(40)
            .width(80)
            .height(80)
            .onClick(() => {
              this.knobX = 0
              this.knobY = 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Progress({
          value: (this.knobX + this.knobY) % 400 / 400,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}