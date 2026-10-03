@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: ZoneData[] = [
    new ZoneData('Atrium', 0.45, '72°F'),
    new ZoneData('Lab East', 0.62, '68°F'),
    new ZoneData('Hab Deck', 0.30, '70°F')
  ]

  // AppTokens Colors
  private primary: string = '#D95F02'
  private secondary: string = '#1B9AAA'
  private tertiary: string = '#FEC601'
  private background: string = '#F9F4EB'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#F0E3D1'
  private outline: string = '#E1CDB2'
  private success: string = '#56C271'
  private warning: string = '#F4A259'
  private error: string = '#D7263D'
  private onPrimary: string = '#1B1B1B'
  private onSecondary: string = '#041012'
  private onTertiary: string = '#1E1200'
  private onBackground: string = '#2C2A29'
  private onSurface: string = '#2E2924'

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column({ space: 4 }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(this.onSurface)
          .layoutWeight(1)
        Text(`${Math.round(value * 100)}%`)
          .fontSize(11)
          .fontColor(accent)
      }
      .width('100%')

      Progress({ value: value, total: 1.0, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(accent)
        .backgroundColor(this.surface)
        .borderRadius(3)
    }
    .width('100%')
  }

  @Builder
  ZoneRow(zone: ZoneData) {
    Column({ space: 4 }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)
          .layoutWeight(1)
        Text(zone.temp)
          .fontSize(11)
          .fontColor(this.primary)
      }
      .width('100%')

      Progress({ value: zone.humidity, total: 1.0, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(this.secondary)
        .backgroundColor(this.surface)
        .borderRadius(3)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
  }

  @Builder
  FilterChipBuilder(mode: string) {
    Text(mode)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.activeMode === mode ? '#26D95F02' : this.surface)
      .borderRadius(12)
      .border({
        width: 1,
        color: this.activeMode === mode ? this.primary : this.outline
      })
      .onClick(() => {
        this.activeMode = mode
      })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontColor(this.onSurface)
          .padding({ left: 16, right: 8, top: 12, bottom: 12 })
          .onClick(() => {})

        Blank()
          .layoutWeight(1)

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)

        Blank()
          .layoutWeight(1)

        Text('Alerts')
          .fontSize(11)
          .fontColor(this.secondary)
          .padding({ left: 8, right: 16, top: 12, bottom: 12 })
          .onClick(() => {})
      }
      .width('100%')
      .height(48)
      .backgroundColor(this.surface)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 12 }) {
          // Mode Filter Chips
          Row({ space: 8 }) {
            ForEach(this.modes, (mode: string) => {
              this.FilterChipBuilder(mode)
            })
          }
          .width('100%')

          // Solar Wash Card
          Column({ space: 8 }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor('#B32E2924')

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .blockColor(this.primary)
              .selectedColor(this.primary)
              .trackColor(this.surfaceVariant)
              .onChange((value: number) => {
                this.solarLevel = value
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontColor(this.onSurface)
                .layoutWeight(1)
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .blockColor(this.secondary)
              .selectedColor(this.secondary)
              .trackColor(this.surfaceVariant)
              .onChange((value: number) => {
                this.ambientGlow = value
              })

            Progress({ value: this.ambientGlow, total: 1.0, type: ProgressType.Linear })
              .width('100%')
              .height(6)
              .color(this.secondary)
              .backgroundColor(this.surfaceVariant)
              .borderRadius(3)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.surface)
          .borderRadius(20)

          // Orbit Health Card
          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)

            this.StatusRow('Atmos mix', 0.74, this.secondary)
            this.StatusRow('Hull temp', 0.42, this.primary)
            this.StatusRow('Shield sync', 0.88, this.tertiary)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(20)

          // Deck Zones Card
          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)

            ForEach(this.zones, (zone: ZoneData) => {
              this.ZoneRow(zone)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.surface)
          .borderRadius(20)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom Bar
      Row() {
        Column({ space: 4 }) {
          Text('Grid draw')
            .fontSize(11)
            .fontColor(this.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)
        }
        .layoutWeight(1)

        Button('Engage eco hold')
          .fontSize(11)
          .fontColor(this.onPrimary)
          .backgroundColor(this.primary)
          .borderRadius(16)
          .height(36)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}

class ZoneData {
  name: string
  humidity: number
  temp: string

  constructor(name: string, humidity: number, temp: string) {
    this.name = name
    this.humidity = humidity
    this.temp = temp
  }
}