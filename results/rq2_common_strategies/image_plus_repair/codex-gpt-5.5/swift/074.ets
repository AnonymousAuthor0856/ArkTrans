class Zone {
  name: string
  humidity: number
  temp: string

  constructor(name: string, humidity: number, temp: string) {
    this.name = name
    this.humidity = humidity
    this.temp = temp
  }
}

@Entry
@Component
struct SmartOrbitPanel {
  private readonly primary: string = '#D95F02'
  private readonly secondary: string = '#1B9AAA'
  private readonly tertiary: string = '#FEC601'
  private readonly bgColor: string = '#F9F4EB'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#F0E3D1'
  private readonly chipBorderColor: string = '#E1CDB2'
  private readonly text: string = '#2E2924'
  private readonly mutedText: string = '#706B68'
  private readonly track: string = '#E4E4E4'

  @State private activeMode: string = 'Orbit'
  @State private solarLevel: number = 0.6
  @State private ambientGlow: number = 0.35
  @State private ecoHold: boolean = false

  private readonly modes: Array<string> = ['Orbit', 'Eclipse', 'Manual']
  private readonly zones: Array<Zone> = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ]

  @Builder
  private progressBar(value: number, color: string, height: number = 6) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(height)
        .backgroundColor(this.track)
        .borderRadius(height / 2)
      Row()
        .width(`${Math.max(0, Math.min(1, value)) * 100}%`)
        .height(height)
        .backgroundColor(color)
        .borderRadius(height / 2)
    }
    .width('100%')
    .height(height)
  }

  @Builder
  private statusRow(label: string, value: number, color: string) {
    Column({ space: 6 }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(this.text)
        Blank()
        Text(`${Math.round(value * 100)}%`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(color)
      }
      .width('100%')
      this.progressBar(value, color, 5)
    }
    .width('100%')
  }

  @Builder
  private zoneRow(zone: Zone) {
    Column({ space: 7 }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.text)
        Blank()
        Text(zone.temp)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)
      }
      .width('100%')
      this.progressBar(zone.humidity, this.secondary, 5)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#F7F0E8')
    .borderRadius(12)
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Dock')
          .fontSize(16)
          .fontColor(this.text)
        Blank()
        Text('Smart Orbit Panel')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.text)
        Blank()
        Text('Alerts')
          .fontSize(16)
          .fontColor(this.secondary)
      }
      .width('100%')
      .height(56)
      .padding({ left: 32, right: 32 })
      .backgroundColor(this.surface)

      Scroll() {
        Column({ space: 16 }) {
          Row({ space: 14 }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode)
                .fontSize(16)
                .fontColor(this.text)
                .height(48)
                .padding({ left: 24, right: 24 })
                .backgroundColor(this.activeMode === mode ? '#F3DEC7' : this.surface)
                .border({
                  width: 1,
                  color: this.chipBorderColor,
                  radius: 16
                })
                .onClick(() => {
                  this.activeMode = mode
                })
            }, (mode: string) => mode)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          Column({ space: 14 }) {
            Text('Solar wash')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.text)
            Text('Adjust orbital window glow')
              .fontSize(18)
              .fontColor(this.mutedText)

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .selectedColor(this.primary)
              .blockColor(this.surface)
              .trackColor(this.track)
              .onChange((value: number) => {
                this.solarLevel = value
              })

            Row() {
              Text('0%')
                .fontSize(16)
                .fontColor(this.text)
              Blank()
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(20)
                .fontColor(this.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.text)
              .margin({ top: 6 })

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .selectedColor(this.secondary)
              .blockColor(this.surface)
              .trackColor(this.track)
              .onChange((value: number) => {
                this.ambientGlow = value
              })

            this.progressBar(this.ambientGlow, this.secondary, 5)
          }
          .width('100%')
          .padding(32)
          .backgroundColor(this.surface)
          .borderRadius(20)
          .shadow({
            radius: 8,
            color: '#22000000',
            offsetX: 0,
            offsetY: 4
          })

          Column({ space: 14 }) {
            Text('Orbit health')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.text)
            this.statusRow('Atmos mix', 0.74, this.secondary)
            this.statusRow('Hull temp', 0.42, this.primary)
            this.statusRow('Shield sync', 0.88, this.tertiary)
          }
          .width('100%')
          .padding(32)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(20)
          .shadow({
            radius: 8,
            color: '#22000000',
            offsetX: 0,
            offsetY: 4
          })

          Column({ space: 14 }) {
            Text('Deck zones')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.text)
            ForEach(this.zones, (zone: Zone) => {
              this.zoneRow(zone)
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(32)
          .backgroundColor(this.surface)
          .borderRadius(20)
          .shadow({
            radius: 8,
            color: '#22000000',
            offsetX: 0,
            offsetY: 4
          })
        }
        .width('100%')
        .padding({ left: 32, right: 32, top: 16, bottom: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      Row() {
        Column({ space: 4 }) {
          Text('Grid draw')
            .fontSize(16)
            .fontColor(this.text)
          Text('18.4 kWh')
            .fontSize(20)
            .fontColor(this.primary)
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Button(this.ecoHold ? 'Eco hold active' : 'Engage eco hold')
          .fontSize(16)
          .fontColor('#1B1B1B')
          .height(48)
          .padding({ left: 24, right: 24 })
          .backgroundColor(this.primary)
          .borderRadius(24)
          .onClick(() => {
            this.ecoHold = !this.ecoHold
          })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 12, bottom: 12 })
      .backgroundColor(this.surface)
      .shadow({
        radius: 10,
        color: '#26000000',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}
