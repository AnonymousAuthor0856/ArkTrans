// Index.ets
// Converted from SwiftUI to ArkTS

// MARK: - AppTokens
class Colors {
  primary: string = '#FFD95F02';
  secondary: string = '#FF1B9AAA';
  tertiary: string = '#FFFEC601';
  background: string = '#FFF9F4EB';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFF0E3D1';
  outline: string = '#FFE1CDB2';
  success: string = '#FF56C271';
  warning: string = '#FFF4A259';
  error: string = '#FFD7263D';
  onPrimary: string = '#FF1B1B1B';
  onSecondary: string = '#FF041012';
  onTertiary: string = '#FF1E1200';
  onBackground: string = '#FF2C2A29';
  onSurface: string = '#FF2E2924';
}

class TypographyItem {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokens {
  display: TypographyItem = new TypographyItem(28, FontWeight.Medium);
  headline: TypographyItem = new TypographyItem(20, FontWeight.Medium);
  title: TypographyItem = new TypographyItem(16, FontWeight.Medium);
  body: TypographyItem = new TypographyItem(13, FontWeight.Normal);
  label: TypographyItem = new TypographyItem(11, FontWeight.Medium);
}

class Shapes {
  small: number = 12;
  medium: number = 16;
  large: number = 20;
}

class Spacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 20;
  xxl: number = 28;
  xxxl: number = 40;
}

class ShadowSpec {
  radius: number;
  dy: number;
  color: string;

  constructor(radius: number, dy: number, color: string) {
    this.radius = radius;
    this.dy = dy;
    this.color = color;
  }
}

class ElevationMapping {
  level1: ShadowSpec = new ShadowSpec(4, 2, '#1A000000');
  level2: ShadowSpec = new ShadowSpec(8, 4, '#29000000');
}

class AppTokens {
  static Colors: Colors = new Colors();
  static TypographyTokens: TypographyTokens = new TypographyTokens();
  static Shapes: Shapes = new Shapes();
  static Spacing: Spacing = new Spacing();
  static ElevationMapping: ElevationMapping = new ElevationMapping();
}

// MARK: - Data Models
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

// MARK: - Reusable Components
// StatusRow Component
@Component
struct StatusRow {
  @Prop label: string;
  @Prop value: number;
  @Prop accent: string;

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      // Custom Linear Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        // Track
        Column()
          .width('100%')
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppTokens.Colors.surface)

        // Fill
        Column()
          .width(`${this.value * 100}%`)
          .height(4)
          .borderRadius(2)
          .backgroundColor(this.accent)
      }
      .width('100%')
      .height(4)
      .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// ZoneRow Component
@Component
struct ZoneRow {
  @Prop zone: Zone;

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(this.zone.temp)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      // Custom Linear Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        Column()
          .width('100%')
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppTokens.Colors.surface)

        Column()
          .width(`${this.zone.humidity * 100}%`)
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .height(4)
      .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: AppTokens.Spacing.sm,
      bottom: AppTokens.Spacing.sm,
      left: AppTokens.Spacing.sm,
      right: AppTokens.Spacing.sm
    })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .opacity(0.5)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - Main Screen
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
      // MARK: Top Bar
      Row() {
        Text('Dock')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('Smart Orbit Panel')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('Alerts')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .height(56)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })
      .backgroundColor(AppTokens.Colors.surface)

      // MARK: Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Mode Selection Chips
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Text(mode)
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .backgroundColor(this.activeMode === mode ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .opacity(this.activeMode === mode ? 0.15 : 1.0)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')

          // Solar Wash Card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Solar wash')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7)

            // Slider
            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(AppTokens.Colors.primary)
              .selectedColor(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .onChange((value: number) => {
                this.solarLevel = value;
              })

            Row() {
              Text('0%')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(AppTokens.Colors.secondary)
              .selectedColor(AppTokens.Colors.secondary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .onChange((value: number) => {
                this.ambientGlow = value;
              })

            // Linear Progress Bar
            Stack({ alignContent: Alignment.Start }) {
              Column()
                .width('100%')
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.surfaceVariant)

              Column()
                .width(`${this.ambientGlow * 100}%`)
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.secondary)
            }
            .width('100%')
            .height(4)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg,
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })

          // Orbit Health Card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Orbit health')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg,
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })

          // Deck Zones Card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Deck zones')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg,
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
        }
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // MARK: Bottom Bar
      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('18.4 kWh')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('Engage eco hold')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: AppTokens.ElevationMapping.level2.color,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}