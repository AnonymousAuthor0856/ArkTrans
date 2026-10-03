// MARK: - AppTokens Colors
class AppColors {
  static primary: string = '#FFD95F02';
  static secondary: string = '#FF1B9AAA';
  static tertiary: string = '#FFFEC601';
  static background: string = '#FFF9F4EB';
  static surface: string = '#FFFFFFFF';
  static surfaceVariant: string = '#FFF0E3D1';
  static outline: string = '#FFE1CDB2';
  static success: string = '#FF56C271';
  static warning: string = '#FFF4A259';
  static error: string = '#FFD7263D';
  static onPrimary: string = '#FF1B1B1B';
  static onSecondary: string = '#FF041012';
  static onTertiary: string = '#FF1E1200';
  static onBackground: string = '#FF2C2A29';
  static onSurface: string = '#FF2E2924';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 20;
  static xxl: number = 28;
  static xxxl: number = 40;
}

class AppShapes {
  static small: number = 12;
  static medium: number = 16;
  static large: number = 20;
}

class AppTypography {
  static displaySize: number = 28;
  static headlineSize: number = 20;
  static titleSize: number = 16;
  static bodySize: number = 13;
  static labelSize: number = 11;
}

class ElevationLevel {
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;
}

class AppElevation {
  static level1: ElevationLevel = { radius: 4, dy: 2, opacity: 0.12 };
  static level2: ElevationLevel = { radius: 8, dy: 4, opacity: 0.16 };
}

// MARK: - Data Models
interface Zone {
  id: number;
  name: string;
  humidity: number;
  temp: string;
}

// MARK: - StatusRow Component
@Component
struct StatusRow {
  label: string = '';
  value: number = 0;
  accent: string = '#FF000000';

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor('#20808080')
        .style({ strokeWidth: 4 })
        .width('100%')
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - ZoneRow Component
@Component
struct ZoneRow {
  zone: Zone = { id: 0, name: '', humidity: 0, temp: '' };

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppColors.secondary)
        .backgroundColor('#20808080')
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
    { id: 1, name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { id: 2, name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { id: 3, name: 'Hab Deck', humidity: 0.30, temp: '70°F' },
  ];

  build() {
    Column() {
      // MARK: Top Bar
      Row() {
        Button('Dock')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(Color.Transparent)
          .padding(0)

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
          .padding(0)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)

      // MARK: Scrollable Content
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
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            Text('Adjust orbital window glow')
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B32E2924')
              .width('100%')
              .textAlign(TextAlign.Start)

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .trackColor('#20D95F02')
              .selectedColor(AppColors.primary)
              .blockColor(AppColors.primary)
              .width('100%')
              .onChange((value: number) => {
                this.solarLevel = value / 100;
              })

            Row() {
              Text('0%')
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Blank()
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(AppTypography.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .trackColor('#201B9AAA')
              .selectedColor(AppColors.secondary)
              .blockColor(AppColors.secondary)
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
            color: '#1F000000',
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })

          // Orbit Health Card
          Column({ space: AppSpacing.sm }) {
            Text('Orbit health')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            StatusRow({
              label: 'Atmos mix',
              value: 0.74,
              accent: AppColors.secondary
            })

            StatusRow({
              label: 'Hull temp',
              value: 0.42,
              accent: AppColors.primary
            })

            StatusRow({
              label: 'Shield sync',
              value: 0.88,
              accent: AppColors.tertiary
            })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: '#1F000000',
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })

          // Deck Zones Card
          Column({ space: AppSpacing.sm }) {
            Text('Deck zones')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            }, (zone: Zone) => zone.id.toString())
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: '#1F000000',
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
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      // MARK: Bottom Bar
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

        Blank()

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
        color: '#29000000',
        offsetX: 0,
        offsetY: -AppElevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}