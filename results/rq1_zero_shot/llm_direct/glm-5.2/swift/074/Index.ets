// AppTokens.ets
// 翻译自 SwiftUI 的 AppTokens 结构体，用于定义颜色、字体、间距、形状和阴影。

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

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Normal },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium },
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

  static readonly ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12, color: '#000000' },
    level2: { radius: 8, dy: 4, opacity: 0.16, color: '#000000' },
    level3: { radius: 12, dy: 6, opacity: 0.2, color: '#000000' },
    level4: { radius: 16, dy: 8, opacity: 0.24, color: '#000000' },
    level5: { radius: 20, dy: 10, opacity: 0.28, color: '#000000' },
  };
}

// Data Models
export class Zone {
  name: string;
  humidity: number;
  temp: string;

  constructor(name: string, humidity: number, temp: string) {
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

// Reusable Components
@Component
export struct StatusRow {
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

        Text(`${Math.floor(this.value * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      // 线性进度条
      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
export struct ZoneRow {
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

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// Main Screen
@Entry
@Component
struct RootScreen {
  @State private activeMode: string = 'Orbit';
  @State private solarLevel: number = 0.6;
  @State private ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ];

  build() {
    Column() {
      // MARK: 顶部栏
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
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)

      // MARK: 可滚动内容区域
      Scroll() {
        Column() {
          // 模式选择芯片
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Text(mode)
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(this.activeMode === mode ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')

          // Solar Wash 卡片
          Column() {
            Text('Solar wash')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('Adjust orbital window glow')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7)
              .margin({ top: AppTokens.Spacing.xs })

            // Slider
            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .selectedColor(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .blockColor(AppTokens.Colors.primary)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })

            Row() {
              Text('0%')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(`${Math.floor(this.solarLevel * 100)}%`)
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .margin({ top: AppTokens.Spacing.xs })

            Text('Ambient glow')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: AppTokens.Spacing.md })

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .selectedColor(AppTokens.Colors.secondary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .blockColor(AppTokens.Colors.secondary)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color(AppTokens.Colors.secondary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .height(4)
              .borderRadius(2)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })
          }
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.md })
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .alignItems(HorizontalAlign.Start)

          // Orbit Health 卡片
          Column() {
            Text('Orbit health')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
            
            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
          }
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.md })
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .alignItems(HorizontalAlign.Start)

          // Deck Zones 卡片
          Column() {
            Text('Deck zones')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
            
            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            })
          }
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.md })
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')

      // MARK: 底部栏
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
            .margin({ top: AppTokens.Spacing.xs })
        }
        .align(HorizontalAlign.Start)

        Blank()

        Text('Engage eco hold')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
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