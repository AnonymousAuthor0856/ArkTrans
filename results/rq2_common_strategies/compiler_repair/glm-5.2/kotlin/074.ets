// Index.ets

class Zone {
  name: string;
  humidity: number;
  temp: string;

  constructor(name: string, humidity: number, temp: string) {
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontColor('#2E2924')
          .padding({ left: 8, right: 8 })
        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E2924')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('Alerts')
          .fontSize(11)
          .fontColor('#1B9AAA')
          .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Mode Chips
          Row() {
            ForEach(this.modes, (mode: string) => {
              Text(mode)
                .fontSize(11)
                .fontColor('#2E2924')
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : '#FFFFFF')
                .borderRadius(12)
                .border({ width: 1, color: '#E1CDB2' })
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')
          .margin({ bottom: 12 })

          // Solar Wash Card
          Column() {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E2924')
              .margin({ bottom: 4 })
            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor('#992E2924')
              .margin({ bottom: 8 })

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .selectedColor('#D95F02')
              .trackColor('#F0E3D1')
              .blockColor('#D95F02')
              .width('100%')
              .onChange((value: number) => {
                this.solarLevel = value;
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontColor('#2E2924')
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#D95F02')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 4, bottom: 12 })

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E2924')
              .margin({ bottom: 8 })

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .selectedColor('#1B9AAA')
              .trackColor('#F0E3D1')
              .blockColor('#1B9AAA')
              .width('100%')
              .onChange((value: number) => {
                this.ambientGlow = value;
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color('#1B9AAA')
              .backgroundColor('#F0E3D1')
              .width('100%')
              .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .margin({ bottom: 12 })

          // Orbit Health Card
          Column() {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E2924')
              .margin({ bottom: 8 })

            this.StatusRow('Atmos mix', 0.74, '#1B9AAA')
            this.StatusRow('Hull temp', 0.42, '#D95F02')
            this.StatusRow('Shield sync', 0.88, '#FEC601')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F0E3D1')
          .borderRadius(20)
          .margin({ bottom: 12 })

          // Deck Zones Card
          Column() {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E2924')
              .margin({ bottom: 8 })

            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRow(zone)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Bar
      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(11)
            .fontColor('#2E2924')
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#D95F02')
        }
        .alignItems(HorizontalAlign.Start)

        Button('Engage eco hold')
          .fontSize(11)
          .fontColor('#1B1B1B')
          .backgroundColor('#D95F02')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F4EB')
  }

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column() {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor('#2E2924')
        Text(`${Math.round(value * 100)}%`)
          .fontSize(11)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 4 })

      Progress({ value: value * 100, total: 100, type: ProgressType.Linear })
        .color(accent)
        .backgroundColor('#FFFFFF')
        .width('100%')
    }
    .margin({ bottom: 8 })
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column() {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E2924')
        Text(zone.temp)
          .fontSize(11)
          .fontColor('#D95F02')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 4 })

      Progress({ value: zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color('#1B9AAA')
        .backgroundColor('#FFFFFF')
        .width('100%')
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
    .margin({ bottom: 8 })
  }
}