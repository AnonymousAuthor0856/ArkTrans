@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35
  @State atmosMix: number = 0.74
  @State hullTemp: number = 0.42
  @State shieldSync: number = 0.88

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: ZoneData[] = [
    { name: 'Command Deck', temp: '21°C', humidity: 0.4 },
    { name: 'Crew Quarters', temp: '22°C', humidity: 0.5 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scrollable Content Column ===
      Column() {
        // === Mode Chips Row ===
        Row({ space: 12 }) {
          ForEach(this.modes, (mode: string) => {
            Button(mode)
              .type(ButtonType.Capsule)
              .backgroundColor(this.activeMode === mode ? '#F0DCC8' : '#FFFFFF')
              .borderWidth(1)
              .borderColor('#E0D0B8')
              .fontColor('#2E2924')
              .onClick(() => { this.activeMode = mode })
          })
        }.width('100%').padding({ left: 24, right: 24, top: 16, bottom: 16 })

        // === Solar Wash Card ===
        Column() {
          Text('Solar wash')
            .fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2E2924')
          
          Text('Adjust orbital window glow')
            .fontSize(16).fontColor('#7A756E').margin({ top: 4 })

          Slider({ value: this.solarLevel, min: 0, max: 1 })
            .trackColor('#EAE0FF')
            .selectedColor('#D95F02')
            .blockColor('#D95F02')
            .showValue(false)
            .onChange((value: number) => { this.solarLevel = value })
            .margin({ top: 16 })

          Row() {
            Text('0%').fontSize(14).fontColor('#2E2924')
            Blank()
            Text(`${Math.round(this.solarLevel * 100)}%`)
              .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#D95F02')
          }.width('100%').margin({ top: 8 })

          Text('Ambient glow')
            .fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2E2924').margin({ top: 24 })

          Slider({ value: this.ambientGlow, min: 0, max: 1 })
            .trackColor('#EAE0FF')
            .selectedColor('#1B9AAA')
            .blockColor('#1B9AAA')
            .showValue(false)
            .onChange((value: number) => { this.ambientGlow = value })
            .margin({ top: 16 })

          Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
            .width('100%').height(6).color('#1B9AAA').margin({ top: 16 })
        }
        .width('100%').padding(24).backgroundColor('#FFFFFF').borderRadius(24)
        .shadow({ radius: 10, color: '#0A000000' }).margin({ top: 8 })

        // === Orbit Health Card ===
        Column() {
          Text('Orbit health')
            .fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2E2924')

          // Atmos mix
          Column() {
            Row() {
              Text('Atmos mix').fontSize(16).fontColor('#2E2924')
              Blank()
              Text(`${Math.round(this.atmosMix * 100)}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1B9AAA')
            }.width('100%')
            Progress({ value: this.atmosMix, total: 1, type: ProgressType.Linear })
              .width('100%').height(6).color('#1B9AAA').margin({ top: 4 })
          }.margin({ top: 16 })

          // Hull temp
          Column() {
            Row() {
              Text('Hull temp').fontSize(16).fontColor('#2E2924')
              Blank()
              Text(`${Math.round(this.hullTemp * 100)}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#D95F02')
            }.width('100%')
            Progress({ value: this.hullTemp, total: 1, type: ProgressType.Linear })
              .width('100%').height(6).color('#D95F02').margin({ top: 4 })
          }.margin({ top: 16 })

          // Shield sync
          Column() {
            Row() {
              Text('Shield sync').fontSize(16).fontColor('#2E2924')
              Blank()
              Text(`${Math.round(this.shieldSync * 100)}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FEC601')
            }.width('100%')
            Progress({ value: this.shieldSync, total: 1, type: ProgressType.Linear })
              .width('100%').height(6).color('#FEC601').margin({ top: 4 })
          }.margin({ top: 16 })
        }
        .width('100%').padding(24).backgroundColor('#F0E3D1').borderRadius(24)
        .shadow({ radius: 10, color: '#0A000000' }).margin({ top: 16 })

        // === Deck Zones Card (Partial) ===
        Column() {
          Text('Deck zones')
            .fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2E2924')
          
          ForEach(this.zones, (zone: ZoneData) => {
            Column() {
              Row() {
                Text(zone.name).fontSize(16).fontColor('#2E2924')
                Blank()
                Text(zone.temp).fontSize(14).fontColor('#D95F02')
              }.width('100%')
              Progress({ value: zone.humidity, total: 1, type: ProgressType.Linear })
                .width('100%').height(4).color('#1B9AAA').margin({ top: 4 })
            }
            .width('100%').padding(12).backgroundColor('#F0E3D1').borderRadius(12)
            .margin({ top: 8 })
          })
        }
        .width('100%').padding(24).backgroundColor('#FFFFFF').borderRadius(24)
        .shadow({ radius: 10, color: '#0A000000' }).margin({ top: 16 })
        
        // Spacer for scrolling
        Column().height(100)
      }
      .width('100%').layoutWeight(1).backgroundColor('#F9F4EB')
      .scrollable(true)

      // === Top App Bar ===
      Row() {
        Text('Dock').fontSize(16).fontColor('#2E2924')
        Blank()
        Text('Smart Orbit Panel').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E2924')
        Blank()
        Text('Alerts').fontSize(16).fontColor('#1B9AAA')
      }
      .width('100%').height(56).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 24, right: 24 })

      // === Bottom Action Bar ===
      Row() {
        Column() {
          Text('Grid draw').fontSize(14).fontColor('#2E2924')
          Text('18.4 kWh').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#D95F02')
        }
        Blank()
        Button('Engage eco hold')
          .type(ButtonType.Capsule)
          .backgroundColor('#D95F02')
          .fontColor('#FFFFFF')
          .height(48).width(160)
      }
      .width('100%').alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#0A000000' })
    }
    .width('100%').height('100%')
  }
}

interface ZoneData {
  name: string;
  temp: string;
  humidity: number;
}