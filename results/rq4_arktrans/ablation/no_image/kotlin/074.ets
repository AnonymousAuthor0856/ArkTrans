@Entry
@Component
struct Index {
  @State mode: string = '0'
  @State solarWash: number = 0
  @State adjustOrbitalWindowGlow: number = 0
  @State fontSize: number = 24
  @State zeroPercent: string = '0%'
  @State ambientGlowLabel: string = 'Ambient glow'
  @State ambientGlow: number = 0.3
  @State syncProgress: number = 0.3
  @State orbitHealth: string = 'Orbit health'
  @State label: string = ''
  @State value: number = 0.3
  @State deckZones: string = 'Deck zones'
  @State zone: string = ''
  @State zoneName: string = ''
  @State zoneTemp: string = ''
  @State zoneHumidity: number = 0.3
  @State smartOrbitPanel: string = 'Smart Orbit Panel'
  @State dock: string = 'Dock'
  @State alerts: string = 'Alerts'
  @State gridDraw: string = 'Grid draw'
  @State energyUsage: string = '18.4 kWh'
  @State engageEcoHold: string = 'Engage eco hold'

  // Mock data for lists to satisfy compilation without external dependencies
  private modes: string[] = ['Mode A', 'Mode B']
  private zones: Array<{ name: string, temp: string, humidity: number }> = [
    { name: 'Zone 1', temp: '22°C', humidity: 0.5 },
    { name: 'Zone 2', temp: '24°C', humidity: 0.6 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 8 }) {
          ForEach(this.modes, (mode: string) => {
            Button(mode)
              .backgroundColor('#F9F4EB')
              .borderRadius(16)
              .fontColor('#2E2924')
              .onClick(() => {
                this.mode = mode
              })
          })
        }.width('100%')

        Column() {
          Column({ space: 8 }) {
            Text('Solar wash')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E2924')

            Text('Adjust orbital window glow')
              .fontSize(14)
              .fontColor('#2E2924')

            Slider({ value: this.solarWash, min: 0, max: 100 })
              .width('100%')
              .selectedColor('#D95F02')

            Row() {
              Text('0%')
                .fontSize(12)
                .fontColor('#2E2924')
              Blank()
              Text(`${Math.round(this.solarWash * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#D95F02')
            }.width('100%')

            Text('Ambient glow')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E2924')

            Slider({ value: this.ambientGlow, min: 0, max: 1 })
              .width('100%')
              .selectedColor('#1B9AAA')

            Progress({
              value: this.ambientGlow,
              total: 1,
              type: ProgressType.Linear
            })
              .width('100%')
              .color('#1B9AAA')
              .trackColor('#F0E3D1')
          }.padding(24)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Column() {
          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E2924')

            // StatusRow 1: Atmos mix
            Column({ space: 4 }) {
              Row() {
                Text('Atmos mix')
                  .fontSize(14)
                  .fontColor('#2E2924')
                Blank()
                Text(`${Math.round(0.74 * 100)}%`)
                  .fontSize(12)
                  .fontColor('#1B9AAA')
              }.width('100%')
              Progress({
                value: 0.74,
                total: 1,
                type: ProgressType.Linear
              })
                .width('100%')
                .color('#1B9AAA')
                .trackColor('#FFFFFF')
            }

            // StatusRow 2: Hull temp
            Column({ space: 4 }) {
              Row() {
                Text('Hull temp')
                  .fontSize(14)
                  .fontColor('#2E2924')
                Blank()
                Text(`${Math.round(0.42 * 100)}%`)
                  .fontSize(12)
                  .fontColor('#D95F02')
              }.width('100%')
              Progress({
                value: 0.42,
                total: 1,
                type: ProgressType.Linear
              })
                .width('100%')
                .color('#D95F02')
                .trackColor('#FFFFFF')
            }

            // StatusRow 3: Shield sync
            Column({ space: 4 }) {
              Row() {
                Text('Shield sync')
                  .fontSize(14)
                  .fontColor('#2E2924')
                Blank()
                Text(`${Math.round(0.88 * 100)}%`)
                  .fontSize(12)
                  .fontColor('#FEC601')
              }.width('100%')
              Progress({
                value: 0.88,
                total: 1,
                type: ProgressType.Linear
              })
                .width('100%')
                .color('#FEC601')
                .trackColor('#FFFFFF')
            }
          }.padding(24)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Column() {
          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E2924')

            ForEach(this.zones, (zone: { name: string, temp: string, humidity: number }) => {
              Column({ space: 4 }) {
                Row() {
                  Text(zone.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2E2924')
                  Blank()
                  Text(zone.temp)
                    .fontSize(12)
                    .fontColor('#D95F02')
                }.width('100%')
                Progress({
                  value: zone.humidity,
                  total: 1,
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .color('#1B9AAA')
                  .trackColor('#FFFFFF')
              }
              .backgroundColor('#F0E3D1')
              .borderRadius(8)
              .padding(8)
            })
          }.padding(24)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      // Top App Bar Simulation
      Row() {
        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E2924')
        Blank()
        Button('Dock')
          .backgroundColor(Color.Transparent)
          .fontColor('#2E2924')
          .onClick(() => {})
        Button('Alerts')
          .backgroundColor(Color.Transparent)
          .fontColor('#1B9AAA')
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24 })
      .position({ x: 0, y: 0 })

      // Bottom Surface Simulation
      Column() {
        Row() {
          Column({ space: 4 }) {
            Text('Grid draw')
              .fontSize(12)
              .fontColor('#2E2924')
            Text('18.4 kWh')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#D95F02')
          }
          Blank()
          Button('Engage eco hold')
            .backgroundColor('#D95F02')
            .borderRadius(8)
            .fontColor('#FFFFFF')
            .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: -60 }) // Approximate positioning relative to stack if needed, or use layoutWeight in main column
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F4EB')
  }
}