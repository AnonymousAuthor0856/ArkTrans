class ColorsClass {
  primary: string = '#D95F02';
  secondary: string = '#1B9AAA';
  tertiary: string = '#FEC601';
  background: string = '#F9F4EB';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F0E3D1';
  outline: string = '#E1CDB2';
  success: string = '#56C271';
  warning: string = '#F4A259';
  error: string = '#D7263D';
  onPrimary: string = '#1B1B1B';
  onSecondary: string = '#041012';
  onTertiary: string = '#1E1200';
  onBackground: string = '#2C2A29';
  onSurface: string = '#2E2924';
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 20;
  xxl: number = 28;
  xxxl: number = 40;
}

class ShapesClass {
  small: number = 12;
  medium: number = 16;
  large: number = 20;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

class ZoneData {
  id: number = 0;
  name: string = '';
  humidity: number = 0;
  temp: string = '';
}

@Component
struct StatusRow {
  label: string = '';
  value: number = 0;
  accent: string = Colors.secondary;

  build() {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor('#E0E0E0')
        .style({ strokeWidth: 4 })
        .width('100%')
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ZoneRow {
  zone: ZoneData = new ZoneData();

  build() {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(Colors.secondary)
        .backgroundColor('#E0E0E0')
        .style({ strokeWidth: 4 })
        .width('100%')
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(Shapes.small)
  }
}

@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  zones: ZoneData[] = (() => {
    let z1 = new ZoneData();
    z1.id = 1; z1.name = 'Atrium'; z1.humidity = 0.45; z1.temp = '72°F';
    let z2 = new ZoneData();
    z2.id = 2; z2.name = 'Lab East'; z2.humidity = 0.62; z2.temp = '68°F';
    let z3 = new ZoneData();
    z3.id = 3; z3.name = 'Hab Deck'; z3.humidity = 0.30; z3.temp = '70°F';
    return [z1, z2, z3];
  })();

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .padding(0)

        Blank()

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Blank()

        Button('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .backgroundColor(Color.Transparent)
          .padding(0)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.md }) {
          // Mode chips
          Row({ space: Spacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : Colors.surface)
                .borderRadius(Shapes.small)
                .border({ width: 1, color: Colors.outline })
                .onClick(() => {
                  this.activeMode = mode;
                })
            }, (mode: string) => mode)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // Solar Wash Card
          Column({ space: Spacing.sm }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
              .width('100%')

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B32E2924')
              .width('100%')

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet,
            })
              .selectedColor(Colors.primary)
              .trackColor('#E0E0E0')
              .blockColor(Colors.surface)
              .width('100%')
              .onChange((value: number) => {
                this.solarLevel = value / 100;
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Blank()
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
              .width('100%')

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet,
            })
              .selectedColor(Colors.secondary)
              .trackColor('#E0E0E0')
              .blockColor(Colors.surface)
              .width('100%')
              .onChange((value: number) => {
                this.ambientGlow = value / 100;
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color(Colors.secondary)
              .backgroundColor(Colors.surfaceVariant)
              .style({ strokeWidth: 4 })
              .width('100%')
              .borderRadius(2)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })

          // Orbit Health Card
          Column({ space: Spacing.sm }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
              .width('100%')

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: Colors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: Colors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: Colors.tertiary })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.large)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })

          // Deck Zones Card
          Column({ space: Spacing.sm }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
              .width('100%')

            ForEach(this.zones, (zone: ZoneData) => {
              ZoneRow({ zone: zone })
            }, (zone: ZoneData) => zone.id.toString())
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(Colors.background)

      // Bottom Bar
      Row() {
        Column({ space: Spacing.xs }) {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Engage eco hold')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.medium)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      .backgroundColor(Colors.surface)
      .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}