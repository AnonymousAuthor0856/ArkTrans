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

class OrbitColors {
  static readonly primary: string = '#D95F02';
  static readonly secondary: string = '#1B9AAA';
  static readonly tertiary: string = '#FEC601';
  static readonly background: string = '#F9F4EB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0E3D1';
  static readonly onPrimary: string = '#1B1B1B';
  static readonly onSurface: string = '#2E2924';
}

@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 60;
  @State ambientGlow: number = 35;
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 45, '72F'),
    new Zone('Lab East', 62, '68F'),
    new Zone('Hab Deck', 30, '70F')
  ];

  @Builder
  TopBar() {
    Row() {
      Button('Dock')
        .fontSize(11)
        .fontColor(OrbitColors.onSurface)
        .backgroundColor(OrbitColors.surface)
      Text('Smart Orbit Panel')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(OrbitColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
      Button('Alerts')
        .fontSize(11)
        .fontColor(OrbitColors.secondary)
        .backgroundColor(OrbitColors.surface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(OrbitColors.surface)
  }

  @Builder
  ModeChips() {
    Row() {
      ForEach(this.modes, (mode: string) => {
        Button(mode)
          .height(34)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.onSurface)
          .backgroundColor(this.activeMode === mode ? '#26D95F02' : OrbitColors.surface)
          .borderRadius(12)
          .margin({ right: mode === 'Manual' ? 0 : 8 })
          .onClick(() => {
            this.activeMode = mode;
          })
      }, (mode: string) => mode)
    }
    .width('100%')
  }

  @Builder
  ControlCard() {
    Column() {
      Text('Solar wash')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(OrbitColors.onSurface)
        .width('100%')
      Text('Adjust orbital window glow')
        .fontSize(13)
        .fontColor('#B32E2924')
        .width('100%')
        .margin({ top: 8 })

      Slider({ value: this.solarLevel, min: 0, max: 100, step: 1 })
        .blockColor(OrbitColors.primary)
        .trackColor(OrbitColors.surfaceVariant)
        .selectedColor(OrbitColors.primary)
        .width('100%')
        .margin({ top: 8 })
        .onChange((value: number) => {
          this.solarLevel = value;
        })

      Row() {
        Text('0%')
          .fontSize(11)
          .fontColor(OrbitColors.onSurface)
          .layoutWeight(1)
        Text(Math.round(this.solarLevel).toString() + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.primary)
      }
      .width('100%')

      Text('Ambient glow')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(OrbitColors.onSurface)
        .width('100%')
        .margin({ top: 12 })

      Slider({ value: this.ambientGlow, min: 0, max: 100, step: 1 })
        .blockColor(OrbitColors.secondary)
        .trackColor(OrbitColors.surfaceVariant)
        .selectedColor(OrbitColors.secondary)
        .width('100%')
        .onChange((value: number) => {
          this.ambientGlow = value;
        })

      Progress({ value: this.ambientGlow, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(OrbitColors.secondary)
        .backgroundColor(OrbitColors.surfaceVariant)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(OrbitColors.surface)
    .borderRadius(20)
  }

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column() {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(OrbitColors.onSurface)
          .layoutWeight(1)
        Text(value.toString() + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      Progress({ value: value, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(accent)
        .backgroundColor(OrbitColors.surface)
        .margin({ top: 4 })
    }
    .width('100%')
  }

  @Builder
  HealthCard() {
    Column() {
      Text('Orbit health')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(OrbitColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })
      this.StatusRow('Atmos mix', 74, OrbitColors.secondary)
      Column() { this.StatusRow('Hull temp', 42, OrbitColors.primary) }.margin({ top: 8 })
      Column() { this.StatusRow('Shield sync', 88, OrbitColors.tertiary) }.margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(OrbitColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column() {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.onSurface)
          .layoutWeight(1)
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.primary)
      }
      .width('100%')
      Progress({ value: zone.humidity, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(OrbitColors.secondary)
        .backgroundColor(OrbitColors.surface)
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
  }

  @Builder
  ZonesCard() {
    Column() {
      Text('Deck zones')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(OrbitColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })
      ForEach(this.zones, (zone: Zone) => {
        Column() {
          this.ZoneRow(zone)
        }
        .margin({ bottom: 8 })
      }, (zone: Zone) => zone.name)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(OrbitColors.surface)
    .borderRadius(20)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Grid draw')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.onSurface)
        Text('18.4 kWh')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrbitColors.primary)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      Button('Engage eco hold')
        .fontSize(11)
        .fontColor(OrbitColors.onPrimary)
        .backgroundColor(OrbitColors.primary)
        .borderRadius(16)
    }
    .width('100%')
    .height(68)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(OrbitColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.ModeChips()
            Column() { this.ControlCard() }.margin({ top: 12 })
            Column() { this.HealthCard() }.margin({ top: 12 })
            Column() { this.ZonesCard() }.margin({ top: 12 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 84 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(OrbitColors.background)
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(OrbitColors.background)
  }
}
