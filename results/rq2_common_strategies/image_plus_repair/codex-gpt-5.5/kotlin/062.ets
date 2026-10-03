const PRIMARY: ResourceColor = '#3B82F6'
const SECONDARY: ResourceColor = '#06B6D4'
const INK: ResourceColor = '#1E293B'
const BACKGROUND_TOP: ResourceColor = '#DDF5FB'
const BACKGROUND_BOTTOM: ResourceColor = '#C9DFFF'
const SURFACE_VARIANT: ResourceColor = '#E0F2FE'
const OUTLINE: ResourceColor = '#CBD5E1'
const WHITE: ResourceColor = '#FFFFFF'

@Entry
@Component
struct ThermoCurvePage {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  @Builder
  ThermometerIcon() {
    Stack() {
      Column() {
        Text('·')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(WHITE)
          .height(18)
          .margin({ top: -3 })
      }
      .width(12)
      .height(24)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(PRIMARY)
      .borderRadius(6)
      .position({ x: 5, y: 0 })
      Circle()
        .width(20)
        .height(20)
        .fill(PRIMARY)
        .position({ x: 1, y: 17 })
    }
    .width(24)
    .height(40)
  }

  @Builder
  SunIcon(color: ResourceColor) {
    Stack() {
      Circle()
        .width(23)
        .height(23)
        .fill(color)
      Text('✦')
        .fontSize(36)
        .fontColor(color)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .position({ x: -8, y: -8 })
    }
    .width(24)
    .height(24)
  }

  @Builder
  FanIcon(color: ResourceColor) {
    Stack() {
      Circle()
        .width(14)
        .height(14)
        .fill(color)
      Text('✣')
        .fontSize(47)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
        .position({ x: -21, y: -21 })
    }
    .width(16)
    .height(16)
  }

  @Builder
  ModeButton(label: string, selected: boolean) {
    Column({ space: 7 }) {
      if (label === 'Cool') {
        this.FanIcon(selected ? WHITE : INK)
      } else {
        this.SunIcon(selected ? WHITE : INK)
      }
      Text(label)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? WHITE : INK)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(selected ? PRIMARY : SURFACE_VARIANT)
    .borderRadius(50)
    .border({ width: selected ? 0 : 1, color: OUTLINE })
    .shadow({ radius: 2, color: '#260F172A', offsetY: 2 })
    .onClick(() => {
      this.mode = label
    })
  }

  build() {
    Column() {
      Row() {
        this.ThermometerIcon()
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(INK)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button() {
          this.SunIcon(SECONDARY)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.mode = 'Heat'
          if (this.targetTemp < 35) {
            this.targetTemp += 1
          }
        })
      }
      .width('100%')
      .height(64)
      .padding({ left: 12, right: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE_VARIANT)

      Column() {
        Text('Target Temperature')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(INK)
          .margin({ top: 24 })

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .margin({ top: 40 })

        Row({ space: 12 }) {
          Button('−')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(WHITE)
            .width(62)
            .height(40)
            .backgroundColor(PRIMARY)
            .borderRadius(30)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })
          Button('+')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(WHITE)
            .width(62)
            .height(40)
            .backgroundColor(PRIMARY)
            .borderRadius(30)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
        }
        .margin({ top: 38 })
        .justifyContent(FlexAlign.Center)

        Divider()
          .width('80%')
          .height(1)
          .color(OUTLINE)
          .margin({ top: 42, bottom: 30 })

        Text('Mode')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(INK)

        Row({ space: 24 }) {
          this.ModeButton('Cool', this.mode === 'Cool')
          this.ModeButton('Heat', this.mode === 'Heat')
        }
        .margin({ top: 38 })
        .justifyContent(FlexAlign.Center)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(15)
          .fontColor(INK)
          .margin({ top: 46 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 18, right: 18, bottom: 18 })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [[BACKGROUND_TOP, 0.0], [BACKGROUND_BOTTOM, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_BOTTOM)
  }
}
