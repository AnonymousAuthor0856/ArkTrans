const PRIMARY: string = '#06B6D4'
const SECONDARY: string = '#3B82F6'
const TERTIARY: string = '#8B5CF6'
const BACKGROUND: string = '#F0F9FF'
const SURFACE_VARIANT: string = '#E0F2FE'
const ON_SURFACE: string = '#0F172A'

@Entry
@Component
struct MainPage {
  @State private spending: number = 500
  private readonly goal: number = 1000

  private progress(): number {
    return Math.max(0, Math.min(this.spending / this.goal, 1))
  }

  private money(value: number): string {
    return `$${Math.round(value)}`
  }

  build() {
    Column() {
      Text('Bill Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64)
        .lineHeight(64)

      Column() {
        Column() {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY)

          Text(`${this.money(this.spending)} / ${this.money(this.goal)}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)

          Row() {
            Row()
              .width(`${this.progress() * 100}%`)
              .height(8)
              .backgroundColor(PRIMARY)
              .borderRadius(4)

            Row() {
              Circle()
                .width(4)
                .height(4)
                .fill(PRIMARY)
            }
            .justifyContent(FlexAlign.End)
            .width(`${(1 - this.progress()) * 100}%`)
            .height(8)
            .backgroundColor(SURFACE_VARIANT)
            .borderRadius(4)
            .padding({ right: 2 })
          }
          .width('100%')
          .height(8)
          .clip(true)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .height(160)
      .backgroundColor('#F2F8FC')
      .borderRadius(20)
      .shadow({
        radius: 8,
        color: '#2E0F172A',
        offsetX: 0,
        offsetY: 4
      })

      Text('Adjust Spending')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
        .margin({ top: 0 })

      Slider({
        value: this.spending,
        min: 0,
        max: 2000,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(40)
        .blockColor(SECONDARY)
        .trackColor(SURFACE_VARIANT)
        .selectedColor(PRIMARY)
        .showSteps(false)
        .onChange((value: number) => {
          this.spending = value
        })

      Button('Reset', { type: ButtonType.Capsule })
        .width('100%')
        .height(48)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor(TERTIARY)
        .onClick(() => {
          this.spending = 0
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, bottom: 16 })
    .backgroundColor(BACKGROUND)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [SECONDARY, 0.3],
        [BACKGROUND, 0.62],
        [PRIMARY, 0.2]
      ]
    })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}
