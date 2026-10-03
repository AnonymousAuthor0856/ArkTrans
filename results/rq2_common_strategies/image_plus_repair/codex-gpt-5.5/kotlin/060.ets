const PRIMARY: ResourceColor = '#2563EB'
const SECONDARY: ResourceColor = '#38BDF8'
const BACKGROUND_TOP: ResourceColor = '#D9F3FF'
const BACKGROUND_BOTTOM: ResourceColor = '#DCE8FA'
const SURFACE: ResourceColor = '#FFFFFF'
const SURFACE_VARIANT: ResourceColor = '#E2E8F0'
const OUTLINE: ResourceColor = '#CBD5E1'
const ON_BACKGROUND: ResourceColor = '#0F172A'
const ON_SURFACE: ResourceColor = '#1E293B'
const ACTIVE_SURFACE: ResourceColor = '#A6DDF8'

const MARKERS: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

@Entry
@Component
struct UnitConverterPage {
  @State activeUnit: string = 'Length'

  @Builder
  MapArea(selected: string) {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)

      Text(`Active Unit: ${selected}`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
        .margin({ top: 10 })
    }
    .width('100%')
    .height(240)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(14)
    .backgroundColor(SURFACE_VARIANT)
    .border({
      width: 1,
      color: OUTLINE,
      radius: 14
    })
  }

  @Builder
  MarkerBox(unit: string, value: string, active: boolean) {
    Row() {
      Column() {
        Text(unit)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(ON_SURFACE)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 10, right: 10 })
    .backgroundColor(active ? ACTIVE_SURFACE : SURFACE)
    .border({
      width: 1,
      color: OUTLINE,
      radius: 10
    })
    .onClick(() => {
      this.activeUnit = unit
    })
  }

  @Builder
  UnitButton(unit: string) {
    Button(unit)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeUnit === unit ? '#FFFFFF' : ON_SURFACE)
      .height(40)
      .padding({ left: 14, right: 14 })
      .backgroundColor(this.activeUnit === unit ? PRIMARY : SURFACE_VARIANT)
      .borderRadius(20)
      .onClick(() => {
        this.activeUnit = unit
      })
  }

  build() {
    Column({ space: 14 }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_BACKGROUND)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 4, bottom: 22 })

      this.MapArea(this.activeUnit)

      ForEach(MARKERS, (unit: string) => {
        this.MarkerBox(unit, 'Tap to convert', this.activeUnit === unit)
      }, (unit: string) => unit)

      Blank()
        .height(10)

      Row({ space: 10 }) {
        ForEach(MARKERS, (unit: string) => {
          this.UnitButton(unit)
        }, (unit: string) => unit)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 14, right: 14, top: 15, bottom: 14 })
    .linearGradient({
      angle: 180,
      colors: [[BACKGROUND_TOP, 0.0], [BACKGROUND_BOTTOM, 1.0]]
    })
  }
}
