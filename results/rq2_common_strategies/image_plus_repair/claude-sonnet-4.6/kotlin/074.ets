import { router } from '@kit.ArkUI'

interface ZoneData {
  name: string
  humidity: number
  temp: string
}

const ColorTokens = {
  primary: 0xFFD95F02,
  secondary: 0xFF1B9AAA,
  tertiary: 0xFFFEC601,
  background: 0xFFF9F4EB,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFF0E3D1,
  outline: 0xFFE1CDB2,
  success: 0xFF56C271,
  warning: 0xFFF4A259,
  error: 0xFFD7263D,
  onPrimary: 0xFF1B1B1B,
  onSecondary: 0xFF041012,
  onTertiary: 0xFF1E1200,
  onBackground: 0xFF2C2A29,
  onSurface: 0xFF2E2924,
}

@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: number = ColorTokens.secondary

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorTokens.onSurface)
        Text(`${Math.floor(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(this.accent)
        .backgroundColor(ColorTokens.surface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ZoneRow {
  zone: ZoneData = { name: '', humidity: 0, temp: '' }

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.onSurface)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(ColorTokens.secondary)
        .backgroundColor(ColorTokens.surface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor(0x80F0E3D1)
    .borderRadius(12)
  }
}

@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: ZoneData[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' },
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.secondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(ColorTokens.surface)
      .padding({ left: 8, right: 8 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 12 }) {
          // Filter chips
          Row({ space: 8 }) {
            ForEach(this.modes, (mode: string) => {
              Text(mode)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(ColorTokens.onSurface)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .backgroundColor(this.activeMode === mode ? 0x26D95F02 : ColorTokens.surface)
                .borderRadius(12)
                .border({ width: 1, color: ColorTokens.outline })
                .onClick(() => {
                  this.activeMode = mode
                })
            })
          }
          .width('100%')

          // Solar wash card
          Column({ space: 8 }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorTokens.onSurface)
              .width('100%')

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor(0xB32E2924)
              .width('100%')

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(ColorTokens.surfaceVariant)
              .selectedColor(ColorTokens.primary)
              .onChange((value: number) => {
                this.solarLevel = value / 100
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(ColorTokens.onSurface)
              Text(`${Math.floor(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(ColorTokens.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorTokens.onSurface)
              .width('100%')

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(ColorTokens.surfaceVariant)
              .selectedColor(ColorTokens.secondary)
              .onChange((value: number) => {
                this.ambientGlow = value / 100
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(4)
              .color(ColorTokens.secondary)
              .backgroundColor(ColorTokens.surfaceVariant)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(ColorTokens.surface)
          .borderRadius(20)

          // Orbit health card
          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorTokens.onSurface)
              .width('100%')

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: ColorTokens.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: ColorTokens.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: ColorTokens.tertiary })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(ColorTokens.surfaceVariant)
          .borderRadius(20)

          // Deck zones card
          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorTokens.onSurface)
              .width('100%')

            ForEach(this.zones, (zone: ZoneData) => {
              ZoneRow({ zone: zone })
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(ColorTokens.surface)
          .borderRadius(20)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(ColorTokens.background)

      // Bottom bar
      Row() {
        Column({ space: 4 }) {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorTokens.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorTokens.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Text('Engage eco hold')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorTokens.onPrimary)
          .padding({ left: 20, right: 20, top: 12, bottom: 12 })
          .backgroundColor(ColorTokens.primary)
          .borderRadius(16)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(ColorTokens.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorTokens.background)
  }
}