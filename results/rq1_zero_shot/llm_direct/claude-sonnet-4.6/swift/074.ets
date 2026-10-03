import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FFD95F02';
  static readonly secondary: string = '#FF1B9AAA';
  static readonly tertiary: string = '#FFFEC601';
  static readonly background: string = '#FFF9F4EB';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFF0E3D1';
  static readonly outline: string = '#FFE1CDB2';
  static readonly success: string = '#FF56C271';
  static readonly warning: string = '#FFF4A259';
  static readonly error: string = '#FFD7263D';
  static readonly onPrimary: string = '#FF1B1B1B';
  static readonly onSecondary: string = '#FF041012';
  static readonly onTertiary: string = '#FF1E1200';
  static readonly onBackground: string = '#FF2C2A29';
  static readonly onSurface: string = '#FF2E2924';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.2);
  static readonly level4: ShadowSpec = new ShadowSpec(12, 16, 8, 0.24);
  static readonly level5: ShadowSpec = new ShadowSpec(16, 20, 10, 0.28);
}

// MARK: - Data Models
class Zone {
  id: string;
  name: string;
  humidity: number;
  temp: string;

  constructor(id: string, name: string, humidity: number, temp: string) {
    this.id = id;
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

// MARK: - Reusable Components
@Component
struct StatusRow {
  label: string = '';
  value: number = 0;
  accent: string = AppColors.secondary;

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
        Spacer()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppColors.surface)
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
  zone: Zone = new Zone('', '', 0, '');

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Spacer()
        Text(this.zone.temp)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
        .style({ strokeWidth: 4 })
        .width('100%')
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(AppShapes.small)
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
    new Zone('1', 'Atrium', 0.45, '72°F'),
    new Zone('2', 'Lab East', 0.62, '68°F'),
    new Zone('3', 'Hab Deck', 0.30, '70°F')
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('Dock')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(Color.Transparent)
          .onClick(() => {})

        Blank()

        Text('Smart Orbit Panel')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Button('Alerts')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .backgroundColor(Color.Transparent)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)

      // Scrollable Content
      Scroll() {
        Column({ space: AppSpacing.md }) {
          // Mode Filter Chips
          Row({ space: AppSpacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode)
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.sm,
                  bottom: AppSpacing.sm
                })
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : AppColors.surface)
                .borderRadius(AppShapes.small)
                .border({ width: 1, color: AppColors.outline })
                .onClick(() => {
                  this.activeMode = mode;
                })
            }, (mode: string) => mode)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          // Solar Wash Card
          Column({ space: AppSpacing.sm }) {
            Text('Solar wash')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')

            Text('Adjust orbital window glow')
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B32E2924')
              .width('100%')

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .selectedColor(AppColors.primary)
              .trackColor(AppColors.surfaceVariant)
              .width('100%')
              .onChange((value: number) => {
                this.solarLevel = value / 100;
              })

            Row() {
              Text('0%')
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Spacer()
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(AppTypography.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .selectedColor(AppColors.secondary)
              .trackColor(AppColors.surfaceVariant)
              .width('100%')
              .onChange((value: number) => {
                this.ambientGlow = value / 100;
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color(AppColors.secondary)
              .backgroundColor(AppColors.surfaceVariant)
              .style({ strokeWidth: 4 })
              .width('100%')
              .borderRadius(2)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })

          // Orbit Health Card
          Column({ space: AppSpacing.sm }) {
            Text('Orbit health')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppColors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppColors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppColors.tertiary })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })

          // Deck Zones Card
          Column({ space: AppSpacing.sm }) {
            Text('Deck zones')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            }, (zone: Zone) => zone.id)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      // Bottom Bar
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Grid draw')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('18.4 kWh')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Spacer()

        Button('Engage eco hold')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: AppSpacing.sm
          })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {})
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level2.radius,
        color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
        offsetX: 0,
        offsetY: AppElevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}