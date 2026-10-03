const C_PRIMARY: string = '#D95F02'
const C_SECONDARY: string = '#1B9AAA'
const C_TERTIARY: string = '#FEC601'
const C_BACKGROUND: string = '#F9F4EB'
const C_SURFACE: string = '#FFFFFF'
const C_SURFACE_VARIANT: string = '#F0E3D1'
const C_ON_SURFACE: string = '#2E2924'
const C_ON_PRIMARY: string = '#1B1B1B'

interface Zone {
  name: string
  humidity: number
  temp: string
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column({ space: 4 }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(C_ON_SURFACE)
        Text(Math.round(value * 100) + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(value * 100), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(accent)
        .backgroundColor(C_SURFACE)
    }
    .width('100%')
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column({ space: 4 }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_PRIMARY)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(zone.humidity * 100), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(C_SECONDARY)
        .backgroundColor(C_SURFACE)
    }
    .width('100%')
    .padding(8)
    .borderRadius(12)
    .backgroundColor('#F7F1E8')
  }

  build() {
    Column() {
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
        Blank()
        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
        Blank()
        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_SECONDARY)
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor(C_SURFACE)

      Scroll() {
        Column({ space: 12 }) {
          Row({ space: 8 }) {
            ForEach(this.modes, (mode: string) => {
              Button() {
                Text(mode)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
              }
              .height(36)
              .padding({ left: 16, right: 16 })
              .borderRadius(12)
              .backgroundColor(this.activeMode === mode ? '#F9E7D9' : C_SURFACE)
              .onClick(() => {
                this.activeMode = mode
              })
            }, (mode: string) => mode)
          }
          .width('100%')

          Column({ space: 8 }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(C_ON_SURFACE)
            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .lineHeight(18)
              .fontColor('#6D6966')

            Slider({ value: this.solarLevel, min: 0, max: 1 })
              .selectedColor(C_PRIMARY)
              .blockColor(C_PRIMARY)
              .trackColor(C_SURFACE_VARIANT)
              .onChange((value: number) => {
                this.solarLevel = value
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(C_ON_SURFACE)
              Text(Math.round(this.solarLevel * 100) + '%')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(C_PRIMARY)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(C_ON_SURFACE)

            Slider({ value: this.ambientGlow, min: 0, max: 1 })
              .selectedColor(C_SECONDARY)
              .blockColor(C_SECONDARY)
              .trackColor(C_SURFACE_VARIANT)
              .onChange((value: number) => {
                this.ambientGlow = value
              })

            Progress({ value: Math.round(this.ambientGlow * 100), total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color(C_SECONDARY)
              .backgroundColor(C_SURFACE_VARIANT)
          }
          .width('100%')
          .padding(16)
          .borderRadius(20)
          .backgroundColor(C_SURFACE)

          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(C_ON_SURFACE)
            this.StatusRow('Atmos mix', 0.74, C_SECONDARY)
            this.StatusRow('Hull temp', 0.42, C_PRIMARY)
            this.StatusRow('Shield sync', 0.88, C_TERTIARY)
          }
          .width('100%')
          .padding(16)
          .borderRadius(20)
          .backgroundColor(C_SURFACE_VARIANT)

          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(C_ON_SURFACE)
            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRow(zone)
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(16)
          .borderRadius(20)
          .backgroundColor(C_SURFACE)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      Row() {
        Column({ space: 4 }) {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_PRIMARY)
        }
        Button() {
          Text('Engage eco hold')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_PRIMARY)
        }
        .height(40)
        .borderRadius(16)
        .backgroundColor(C_PRIMARY)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(C_SURFACE)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}
