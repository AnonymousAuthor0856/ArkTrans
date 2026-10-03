// AppTokens.ets
export class AppTokens {
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
    onSurface: '#FF2E2924',
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium, lineHeight: 34 },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 28 },
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    body: { fontSize: 13, fontWeight: FontWeight.Normal, lineHeight: 18 },
    label: { fontSize: 11, fontWeight: FontWeight.Medium, lineHeight: 16 },
  };

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40,
  };
}

interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;
  
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ];

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column() {
      Row() {
        Text(label)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(`${Math.round(value * 100)}%`)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: value * 100, total: 100, type: ProgressType.Linear })
        .style({ strokeWidth: 6 })
        .color(accent)
        .backgroundColor(AppTokens.Colors.surface)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column() {
      Row() {
        Text(zone.name)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(zone.temp)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .style({ strokeWidth: 6 })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .width('100%')
    .padding(AppTokens.Spacing.sm)
    .borderRadius(AppTokens.Shapes.small)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Dock')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Smart Orbit Panel')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Alerts')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(AppTokens.Colors.surface)

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.modes, (mode: string) => {
              Text(mode)
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
                .borderRadius(AppTokens.Shapes.small)
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : AppTokens.Colors.surface)
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: AppTokens.Spacing.md })

          // Solar Wash Card
          Column() {
            Text('Solar wash')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('Adjust orbital window glow')
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor('#B32E2924')
              .margin({ top: AppTokens.Spacing.xs })

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(AppTokens.Colors.primary)
              .selectedColor(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })
              .onChange((value: number) => {
                this.solarLevel = value;
              })

            Row() {
              Text('0%')
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(AppTokens.Typography.title.fontSize)
                .fontWeight(AppTokens.Typography.title.fontWeight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: AppTokens.Spacing.xs })

            Text('Ambient glow')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: AppTokens.Spacing.md })

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(AppTokens.Colors.secondary)
              .selectedColor(AppTokens.Colors.secondary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })
              .onChange((value: number) => {
                this.ambientGlow = value;
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .style({ strokeWidth: 6 })
              .color(AppTokens.Colors.secondary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .width('100%')
              .margin({ top: AppTokens.Spacing.xs })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface)
          .margin({ bottom: AppTokens.Spacing.md })

          // Orbit Health Card
          Column() {
            Text('Orbit health')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm })

            this.StatusRow('Atmos mix', 0.74, AppTokens.Colors.secondary)
            this.StatusRow('Hull temp', 0.42, AppTokens.Colors.primary)
            this.StatusRow('Shield sync', 0.88, AppTokens.Colors.tertiary)
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ bottom: AppTokens.Spacing.md })

          // Deck Zones Card
          Column() {
            Text('Deck zones')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm })

            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRow(zone)
            })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface)
        }
        .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text('18.4 kWh')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Engage eco hold')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.sm })
      }
      .width('100%')
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.sm })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}