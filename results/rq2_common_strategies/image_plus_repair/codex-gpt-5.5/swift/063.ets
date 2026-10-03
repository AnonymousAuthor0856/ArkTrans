const PRIMARY: string = '#3B82F6'
const SECONDARY: string = '#22C55E'
const BACKGROUND: string = '#F5F5F4'
const SURFACE: string = '#FFFFFF'
const OUTLINE: string = '#D4D4D8'
const ON_BACKGROUND: string = '#111827'
const ACCENT: string = '#F59E0B'

@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  private simulateCharge(): void {
    this.progress += 0.1
    if (this.progress > 1.0) {
      this.progress = 0.0
    }
  }

  build() {
    Column() {
      Row() {
        Text('⚡')
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .width(58)
          .textAlign(TextAlign.Center)

        Text('Charging Progress')
          .fontSize(46)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_BACKGROUND)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Button() {
          Text('⚙')
            .fontSize(37)
            .fontWeight(FontWeight.Bold)
            .fontColor(ACCENT)
        }
        .type(ButtonType.Normal)
        .backgroundColor(SURFACE)
        .width(58)
        .height(58)
        .padding(0)
      }
      .width('100%')
      .height(90)
      .padding({ left: 16, right: 16 })
      .backgroundColor(SURFACE)
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Stack() {
            Column() {
            }
            .width(100)
            .height(180)
            .backgroundColor(PRIMARY)
            .borderRadius(16)

            Column() {
            }
            .width(40)
            .height(20)
            .backgroundColor(PRIMARY)
            .borderRadius(6)
            .offset({ y: -90 })

            Text('⚡')
              .fontSize(55)
              .fontWeight(FontWeight.Bold)
              .fontColor(SURFACE)
          }
          .width(120)
          .height(200)

          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(72)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_BACKGROUND)
            .margin({ top: 16 })
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 38 })

        Stack() {
          Row()
            .width('100%')
            .height('100%')
            .backgroundColor(SURFACE)
            .border({
              width: 1,
              color: OUTLINE
            })
            .borderRadius(20)

          Row()
            .width(`${Math.max(0, Math.min(this.progress, 1)) * 100}%`)
            .height('100%')
            .backgroundColor(PRIMARY)
            .borderRadius(20)
        }
        .width('70%')
        .height(24)
        .margin({ top: 59 })

        Button('Simulate Charge', { type: ButtonType.Capsule })
          .fontSize(28)
          .fontColor(SURFACE)
          .backgroundColor(SECONDARY)
          .width(315)
          .height(82)
          .margin({ top: 56 })
          .onClick(() => this.simulateCharge())

        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? PRIMARY : SECONDARY)
          .margin({ top: 47 })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(BACKGROUND)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
