@Entry
@Component
struct SmartOrbitPanelApp {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F9F4EB')

      // Main VStack
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Button() {
            Text('Dock')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
          }
          Blank()
          Text('Smart Orbit Panel')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#2E2924')
          Blank()
          Button() {
            Text('Alerts')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#1B9AAA')
          }
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        // Scrollable content
        Column({ space: 12 }) {
          // Mode chips
          Row({ space: 8 }) {
            ForEach(this.modes, (mode: string) => {
              Button() {
                Text(mode)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.activeMode === mode ? '#FFFFFF' : '#2E2924')
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              }
              .backgroundColor(this.activeMode === mode ? '#D95F02' : '#FFFFFF')
              .borderRadius(12)
              .border({ width: this.activeMode === mode ? 0 : 1, color: '#E1CDB2', radius: 12 })
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
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
              .width('100%')
            Text('Adjust orbital window glow')
              .fontSize(13)
              .foregroundColor('#2E2924')
              .opacity(0.7)
              .width('100%')

            Slider({ value: this.solarLevel, min: 0, max: 1, step: 0.01 })
              .width('100%')
              .onChange((val: number) => { this.solarLevel = val })

            Row({ space: 0 }) {
              Text('0%')
                .fontSize(11)
                .foregroundColor('#2E2924')
              Blank()
              Text((this.solarLevel * 100).toFixed(0) + '%')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#D95F02')
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
              .width('100%')

            Slider({ value: this.ambientGlow, min: 0, max: 1, step: 0.01 })
              .width('100%')
              .onChange((val: number) => { this.ambientGlow = val })

            Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
              .height(4)
              .width('100%')
              .color('#1B9AAA')
              .backgroundColor('#FFFFFF')
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

          // Orbit health card
          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
              .width('100%')

            this.buildStatusRow('Atmos mix', 0.74, '#1B9AAA')
            this.buildStatusRow('Hull temp', 0.42, '#D95F02')
            this.buildStatusRow('Shield sync', 0.88, '#FEC601')
          }
          .padding(16)
          .backgroundColor('#F0E3D1')
          .borderRadius(20)
          .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

          // Deck zones card
          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
              .width('100%')

            ForEach(this.zones, (zone: Zone) => {
              this.buildZoneRow(zone)
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })

        // Bottom bar
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('Grid draw')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E2924')
            Text('18.4 kWh')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#D95F02')
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
          Button() {
            Text('Engage eco hold')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#1B1B1B')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }
          .backgroundColor('#D95F02')
          .borderRadius(16)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildStatusRow(label: string, value: number, accent: string) {
    Column({ space: 4 }) {
      Row({ space: 0 }) {
        Text(label)
          .fontSize(13)
          .foregroundColor('#2E2924')
        Blank()
        Text((value * 100).toFixed(0) + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .foregroundColor(accent)
      }
      .width('100%')
      Progress({ value: value, total: 1, type: ProgressType.Linear })
        .height(4)
        .width('100%')
        .color(accent)
        .backgroundColor('#FFFFFF')
    }
    .width('100%')
  }

  @Builder
  buildZoneRow(zone: Zone) {
    Column({ space: 4 }) {
      Row({ space: 0 }) {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#2E2924')
        Blank()
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#D95F02')
      }
      .width('100%')
      Progress({ value: zone.humidity, total: 1, type: ProgressType.Linear })
        .height(4)
        .width('100%')
        .color('#1B9AAA')
        .backgroundColor('#FFFFFF')
    }
    .padding(8)
    .backgroundColor('#F0E3D1')
    .borderRadius(12)
    .width('100%')
  }
}

interface Zone {
  name: string
  humidity: number
  temp: string
}