// Translated from Kotlin/Compose (038.kt) to ArkTS/ArkUI

const COLOR_PRIMARY = '#06B6D4'
const COLOR_SECONDARY = '#3B82F6'
const COLOR_TERTIARY = '#8B5CF6'
const COLOR_BACKGROUND = '#F0F9FF'
const COLOR_SURFACE = '#FFFFFF'
const COLOR_SURFACE_VARIANT = '#E0F2FE'
const COLOR_OUTLINE = '#BAE6FD'
const COLOR_SUCCESS = '#22C55E'
const COLOR_WARNING = '#FACC15'
const COLOR_ERROR = '#EF4444'
const COLOR_ON_SURFACE = '#0F172A'

const COLOR_SECONDARY_ALPHA_30 = '#4D3B82F6'
const COLOR_PRIMARY_ALPHA_30 = '#4D06B6D4'
const COLOR_SURFACE_ALPHA_90 = '#E6FFFFFF'

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct InvoiceScannerPage {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  @State scanning: boolean = false

  build() {
    Column() {
      // Top bar (CenterAlignedTopAppBar)
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      // Main content
      Column({ space: 16 }) {
        // Surface card with canvas markers
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 320, height: 320 })
            .fill(COLOR_SURFACE_VARIANT)

          ForEach(this.markers, (m: Marker, i: number) => {
            Circle({ width: 24, height: 24 })
              .fill(COLOR_PRIMARY)
              .position({ x: m.x, y: m.y })
          }, (m: Marker, i: number) => m.label + '_' + i)
        }
        .width('100%')
        .height(400)
        .backgroundColor(COLOR_SURFACE_ALPHA_90)
        .borderRadius(20)

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(COLOR_SECONDARY)
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Add Marker')
          .width('100%')
          .height(48)
          .backgroundColor(COLOR_PRIMARY)
          .fontColor(COLOR_SURFACE)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const nx: number = Math.floor(Math.random() * 500) + 80
              const ny: number = Math.floor(Math.random() * 500) + 150
              this.markers.push(new Marker(nx, ny, 'N' + (this.markers.length + 1)))
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [COLOR_SECONDARY_ALPHA_30, 0.0],
          [COLOR_BACKGROUND, 0.5],
          [COLOR_PRIMARY_ALPHA_30, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
