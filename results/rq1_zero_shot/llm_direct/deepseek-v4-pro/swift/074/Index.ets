@Entry
@Component
struct SmartOrbitPanelApp {
  build() {
    RootScreen()
  }
}

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#FFD95F02',
    secondary: '#FF1B9AAA',
    tertiary: '#FFFEC601',
    background: '#FFF9F4EB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF0E3D1',
    outline: '#FFE1CDB2',
    success: '#FF56C271',
    warning: '#FFF4A259',
    error: '#FFD7263D',
    onPrimary: '#FF1B1B1B',
    onSecondary: '#FF041012',
    onTertiary: '#FF1E1200',
    onBackground: '#FF2C2A29',
    onSurface: '#FF2E2924'
  } as const;

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.SemiBold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  } as const;

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20
  } as const;

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  } as const;

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 },
    level3: { radius: 12, dy: 6, opacity: 0.2 },
    level4: { radius: 16, dy: 8, opacity: 0.24 },
    level5: { radius: 20, dy: 10, opacity: 0.28 }
  } as const;
}

// MARK: - Data Models
interface Zone {
  id: string;
  name: string;
  humidity: number;
  temp: string;
}

// MARK: - Reusable Components
@Component
struct StatusRow {
  @Prop label: string;
  @Prop value: number;
  @Prop accent: string;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value, total: 1, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ZoneRow {
  @Prop zone: Zone;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - Main Screen
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    { id: '1', name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { id: '2', name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { id: '3', name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ];

  @Builder
  ModeChip(mode: string) {
    Button() {
      this.activeMode = mode;
    }
    .backgroundColor(this.activeMode === mode ? '#26D95F02' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .stateEffect(false)

    Text(mode)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(AppTokens.Colors.onSurface)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top Bar
        Row() {
          Button() {
            // Dock button action
          }
          .stateEffect(false)

          Text('Dock')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text('Smart Orbit Panel')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button() {
            // Alerts button action
          }
          .stateEffect(false)

          Text('Alerts')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.secondary)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Mode Filter Chips
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.modes, (mode: string) => {
                this.ModeChip(mode)
              }, (mode: string) => mode)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            // Solar Wash Card
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Solar wash')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Adjust orbital window glow')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor('#B32E2924')

              Slider({ value: this.solarLevel, min: 0, max: 1, style: SliderStyle.OutSet })
                .blockColor(AppTokens.Colors.primary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.primary)
                .onChange((value: number) => {
                  this.solarLevel = value;
                })

              Row() {
                Text('0%')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(AppTokens.Typography.title.size)
                  .fontWeight(AppTokens.Typography.title.weight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .width('100%')

              Text('Ambient glow')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Slider({ value: this.ambientGlow, min: 0, max: 1, style: SliderStyle.OutSet })
                .blockColor(AppTokens.Colors.secondary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.secondary)
                .onChange((value: number) => {
                  this.ambientGlow = value;
                })

              Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .height(4)
                .borderRadius(2)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
              offsetY: AppTokens.Elevation.level1.dy
            })

            // Orbit Health Card
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Orbit health')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
              offsetY: AppTokens.Elevation.level1.dy
            })

            // Deck Zones Card
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Deck zones')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
              }, (zone: Zone) => zone.id)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
              offsetY: AppTokens.Elevation.level1.dy
            })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)

        // Bottom Bar
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Grid draw')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('18.4 kWh')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            // Engage eco hold button action
          }
          .stateEffect(false)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          Text('Engage eco hold')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
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
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetY: AppTokens.Elevation.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}