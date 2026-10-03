const Colors = {
  primary: '#D95F02',
  secondary: '#1B9AAA',
  tertiary: '#FEC601',
  background: '#F9F4EB',
  surface: '#FFFFFF',
  surfaceVariant: '#F0E3D1',
  outline: '#E1CDB2',
  success: '#56C271',
  warning: '#F4A259',
  error: '#D7263D',
  onPrimary: '#1B1B1B',
  onSecondary: '#041012',
  onTertiary: '#1E1200',
  onBackground: '#2C2A29',
  onSurface: '#2E2924'
};

const Spacing = { xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 28, xxxl: 40 };
const Shapes = { small: 12, medium: 16, large: 20 };

interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

const modes: string[] = ['Orbit', 'Eclipse', 'Manual'];

const zones: Zone[] = [
  { name: 'Atrium', humidity: 0.45, temp: '72°F' },
  { name: 'Lab East', humidity: 0.62, temp: '68°F' },
  { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
];

@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  @Builder
  statusRow(label: string, value: number, accent: string) {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(Colors.onSurface)
        Text(Math.round(value * 100) + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(value * 100), total: 100, type: ProgressType.Linear })
        .color(accent)
        .backgroundColor(Colors.surface)
        .width('100%')
    }
  }

  @Builder
  zoneRow(zone: Zone) {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(zone.humidity * 100), total: 100, type: ProgressType.Linear })
        .color(Colors.secondary)
        .backgroundColor(Colors.surface)
        .width('100%')
    }
    .padding(Spacing.sm)
    .borderRadius(Shapes.small)
    .backgroundColor('#80F0E3D1')
  }

  build() {
    Column() {
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Colors.surface)

      Scroll() {
        Column({ space: Spacing.md }) {
          Row({ space: Spacing.sm }) {
            ForEach(modes, (mode: string) => {
              Text(mode)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
                .borderRadius(Shapes.small)
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : Colors.surface)
                .onClick(() => {
                  this.activeMode = mode;
                })
            }, (mode: string) => mode)
          }

          Column({ space: Spacing.sm }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor('#B32E2924')
            Slider({ value: this.solarLevel, min: 0, max: 1, style: SliderStyle.OutSet })
              .blockColor(Colors.primary)
              .selectedColor(Colors.primary)
              .trackColor(Colors.surfaceVariant)
              .onChange((v: number) => {
                this.solarLevel = v;
              })
            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(Math.round(this.solarLevel * 100) + '%')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Slider({ value: this.ambientGlow, min: 0, max: 1, style: SliderStyle.OutSet })
              .blockColor(Colors.secondary)
              .selectedColor(Colors.secondary)
              .trackColor(Colors.surfaceVariant)
              .onChange((v: number) => {
                this.ambientGlow = v;
              })
            Progress({ value: Math.round(this.ambientGlow * 100), total: 100, type: ProgressType.Linear })
              .color(Colors.secondary)
              .backgroundColor(Colors.surfaceVariant)
              .width('100%')
          }
          .padding(Spacing.lg)
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)

          Column({ space: Spacing.sm }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            this.statusRow('Atmos mix', 0.74, Colors.secondary)
            this.statusRow('Hull temp', 0.42, Colors.primary)
            this.statusRow('Shield sync', 0.88, Colors.tertiary)
          }
          .padding(Spacing.lg)
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surfaceVariant)

          Column({ space: Spacing.sm }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            ForEach(zones, (zone: Zone) => {
              this.zoneRow(zone)
            }, (zone: Zone) => zone.name)
          }
          .padding(Spacing.lg)
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      }
      .layoutWeight(1)

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
        Button('Engage eco hold')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .borderRadius(Shapes.medium)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 8, color: '#16000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
