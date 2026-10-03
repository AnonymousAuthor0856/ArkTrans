// Index.ets  —  ArkTS (HarmonyOS ArkUI) port of the SwiftUI "Smart Orbit Panel"
// Tokens keep the same semantics as the Swift/Kotlin version: colors, type scale,
// spacing, corner radii and elevation specs are all in one place.

/* ------------------------------- AppTokens ------------------------------- */

class AppTokens {
  // Colors (opaque ARGB hex, straight from the 0xFF… constants)
  static readonly primary: string = '#D95F02';
  static readonly secondary: string = '#1B9AAA';
  static readonly tertiary: string = '#FEC601';
  static readonly background: string = '#F9F4EB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0E3D1';
  static readonly surfaceVariant50: string = '#F7F1E6'; // variant @50% over surface
  static readonly outline: string = '#E1CDB2';
  static readonly success: string = '#56C271';
  static readonly warning: string = '#F4A259';
  static readonly error: string = '#D7263D';
  static readonly onPrimary: string = '#1B1B1B';
  static readonly onSurface: string = '#2E2924';
  static readonly onSurface70: string = 'rgba(46,41,36,0.7)';
  static readonly primary15: string = '#F4DEC8'; // primary @15% over background
  static readonly onBackground: string = '#2C2A29';

  // Typography
  static readonly displaySize: number = 28;
  static readonly displayWeight: number = 600;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: number = 600;
  static readonly titleSize: number = 16;
  static readonly titleWeight: number = 500;
  static readonly bodySize: number = 13;
  static readonly bodyWeight: number = 400;
  static readonly labelSize: number = 11;
  static readonly labelWeight: number = 500;

  // Shapes
  static readonly radiusSmall: number = 12;
  static readonly radiusMedium: number = 16;
  static readonly radiusLarge: number = 20;

  // Spacing
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;

  // Elevation
  static readonly level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.16 };
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

/* ------------------------------ Data Models ------------------------------ */

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

/* --------------------------- Reusable widgets ---------------------------- */

@Component
struct LinearBar {
  private value: number = 0;
  private barColor: string = AppTokens.primary;
  private trackColor: string = AppTokens.surface;
  private barHeight: number = 4;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {}
      .width('100%')
      .height(this.barHeight)
      .backgroundColor(this.trackColor)
      .borderRadius(this.barHeight / 2)

      Row() {}
      .width(`${Math.max(0, Math.min(1, this.value)) * 100}%`)
      .height(this.barHeight)
      .backgroundColor(this.barColor)
      .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

@Component
struct StatusRow {
  private label: string = '';
  private value: number = 0;
  private accent: string = AppTokens.secondary;
  private trackColor: string = AppTokens.surface;

  build() {
    Column({ space: AppTokens.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.bodySize)
          .fontWeight(AppTokens.bodyWeight)
          .fontColor(AppTokens.onSurface)

        Blank()

        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.labelSize)
          .fontWeight(AppTokens.labelWeight)
          .fontColor(this.accent)
      }
      .width('100%')

      LinearBar({ value: this.value, barColor: this.accent, trackColor: this.trackColor })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ZoneRow {
  private zone: Zone = new Zone('', 0, '');

  build() {
    Column({ space: AppTokens.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.titleSize)
          .fontWeight(AppTokens.titleWeight)
          .fontColor(AppTokens.onSurface)

        Blank()

        Text(this.zone.temp)
          .fontSize(AppTokens.labelSize)
          .fontWeight(AppTokens.labelWeight)
          .fontColor(AppTokens.primary)
      }
      .width('100%')

      LinearBar({ value: this.zone.humidity, barColor: AppTokens.secondary })
    }
    .width('100%')
    .padding(AppTokens.sm)
    .backgroundColor(AppTokens.surfaceVariant50)
    .borderRadius(AppTokens.radiusSmall)
  }
}

/* ------------------------------- Root screen ----------------------------- */

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ];

  @Builder
  chip(mode: string) {
    Button(mode, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(AppTokens.labelSize)
      .fontWeight(AppTokens.labelWeight)
      .fontColor(AppTokens.onSurface)
      .padding({ left: AppTokens.md, right: AppTokens.md, top: AppTokens.sm, bottom: AppTokens.sm })
      .backgroundColor(this.activeMode === mode ? AppTokens.primary15 : AppTokens.surface)
      .borderRadius(AppTokens.radiusSmall)
      .border({ width: 1, color: AppTokens.outline })
      .onClick(() => {
        this.activeMode = mode;
      })
  }

  build() {
    Column() {
      /* ------------------------- Top bar (CenterAlignedTopAppBar) -------- */
      Row() {
        Button('Dock', { type: ButtonType.Normal })
          .fontSize(AppTokens.labelSize)
          .fontWeight(AppTokens.labelWeight)
          .fontColor(AppTokens.onSurface)
          .backgroundColor(Color.Transparent)
          .padding(0)

        Blank()

        Text('Smart Orbit Panel')
          .fontSize(AppTokens.titleSize)
          .fontWeight(AppTokens.titleWeight)
          .fontColor(AppTokens.onSurface)

        Blank()

        Button('Alerts', { type: ButtonType.Normal })
          .fontSize(AppTokens.labelSize)
          .fontWeight(AppTokens.labelWeight)
          .fontColor(AppTokens.secondary)
          .backgroundColor(Color.Transparent)
          .padding(0)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.lg, right: AppTokens.lg })
      .backgroundColor(AppTokens.surface)

      /* --------------------------- Scrollable content ------------------- */
      Scroll() {
        Column({ space: AppTokens.md }) {

          // Mode filter chips
          Row({ space: AppTokens.sm }) {
            ForEach(this.modes, (mode: string) => {
              this.chip(mode)
            }, (mode: string) => mode)
          }
          .width('100%')

          // Card: Solar wash
          Column({ space: AppTokens.sm }) {
            Text('Solar wash')
              .fontSize(AppTokens.headlineSize)
              .fontWeight(AppTokens.headlineWeight)
              .fontColor(AppTokens.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(AppTokens.bodySize)
              .fontWeight(AppTokens.bodyWeight)
              .fontColor(AppTokens.onSurface70)

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .selectedColor(AppTokens.primary)
              .trackColor('#E8E8E8')
              .blockColor(Color.White)
              .onChange((value: number, mode: SliderChangeMode) => {
                this.solarLevel = value;
              })

            Row() {
              Text('0%')
                .fontSize(AppTokens.labelSize)
                .fontWeight(AppTokens.labelWeight)
                .fontColor(AppTokens.onSurface)

              Blank()

              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(AppTokens.titleSize)
                .fontWeight(AppTokens.titleWeight)
                .fontColor(AppTokens.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(AppTokens.headlineSize)
              .fontWeight(AppTokens.headlineWeight)
              .fontColor(AppTokens.onSurface)
              .margin({ top: AppTokens.sm })

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .selectedColor(AppTokens.secondary)
              .trackColor('#E8E8E8')
              .blockColor(Color.White)
              .onChange((value: number, mode: SliderChangeMode) => {
                this.ambientGlow = value;
              })

            LinearBar({
              value: this.ambientGlow,
              barColor: AppTokens.secondary,
              trackColor: AppTokens.surfaceVariant
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.lg)
          .backgroundColor(AppTokens.surface)
          .borderRadius(AppTokens.radiusLarge)
          .shadow({
            radius: AppTokens.level1.radius,
            color: `rgba(0,0,0,${AppTokens.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.level1.dy
          })

          // Card: Orbit health
          Column({ space: AppTokens.sm }) {
            Text('Orbit health')
              .fontSize(AppTokens.headlineSize)
              .fontWeight(AppTokens.headlineWeight)
              .fontColor(AppTokens.onSurface)

            StatusRow({
              label: 'Atmos mix',
              value: 0.74,
              accent: AppTokens.secondary,
              trackColor: AppTokens.surface
            })

            StatusRow({
              label: 'Hull temp',
              value: 0.42,
              accent: AppTokens.primary,
              trackColor: AppTokens.surface
            })

            StatusRow({
              label: 'Shield sync',
              value: 0.88,
              accent: AppTokens.tertiary,
              trackColor: AppTokens.surface
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.lg)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.radiusLarge)
          .shadow({
            radius: AppTokens.level1.radius,
            color: `rgba(0,0,0,${AppTokens.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.level1.dy
          })

          // Card: Deck zones
          Column({ space: AppTokens.sm }) {
            Text('Deck zones')
              .fontSize(AppTokens.headlineSize)
              .fontWeight(AppTokens.headlineWeight)
              .fontColor(AppTokens.onSurface)

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.lg)
          .backgroundColor(AppTokens.surface)
          .borderRadius(AppTokens.radiusLarge)
          .shadow({
            radius: AppTokens.level1.radius,
            color: `rgba(0,0,0,${AppTokens.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.level1.dy
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: AppTokens.lg, right: AppTokens.lg, top: AppTokens.sm, bottom: AppTokens.sm })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)

      /* ------------------------------ Bottom bar ------------------------ */
      Row() {
        Column({ space: AppTokens.xs }) {
          Text('Grid draw')
            .fontSize(AppTokens.labelSize)
            .fontWeight(AppTokens.labelWeight)
            .fontColor(AppTokens.onSurface)

          Text('18.4 kWh')
            .fontSize(AppTokens.titleSize)
            .fontWeight(AppTokens.titleWeight)
            .fontColor(AppTokens.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Engage eco hold', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(AppTokens.labelSize)
          .fontWeight(AppTokens.labelWeight)
          .fontColor(AppTokens.onPrimary)
          .backgroundColor(AppTokens.primary)
          .padding({
            left: AppTokens.md,
            right: AppTokens.md,
            top: AppTokens.sm,
            bottom: AppTokens.sm
          })
          .borderRadius(AppTokens.radiusMedium)
          .onClick(() => {
            // "Engage eco hold" action
          })
      }
      .width('100%')
      .padding({
        left: AppTokens.lg,
        right: AppTokens.lg,
        top: AppTokens.sm,
        bottom: AppTokens.sm
      })
      .backgroundColor(AppTokens.surface)
      .shadow({
        radius: AppTokens.level2.radius,
        color: `rgba(0,0,0,${AppTokens.level2.opacity})`,
        offsetX: 0,
        offsetY: -AppTokens.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}