// MARK: - AppTokens
const AppTokens = {
  Colors: {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#474747',
    background: '#F6F6F6',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D1D1D1',
    success: '#2E7D32',
    warning: '#B98900',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Semibold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  },
  Shadow: {
    level1: { radius: 4, dy: 2, color: '#1A000000' },
    level2: { radius: 8, dy: 4, color: '#24000000' }
  }
};

// 模拟 AppColorScheme 的全局颜色方案
const colorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  tertiary: AppTokens.Colors.tertiary,
  onTertiary: AppTokens.Colors.onTertiary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error
};

// MARK: - Data Models
class AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.x = x;
    this.y = y;
  }
}

// MARK: - MapMarker
@Component
struct MapMarker {
  @Prop type: string = '';
  @Prop selected: boolean = false;
  onClick: () => void = () => {};

  private markerColor(): string {
    if (this.type === 'Warehouse') return AppTokens.Colors.tertiary;
    if (this.type === 'Device') return AppTokens.Colors.secondary;
    return AppTokens.Colors.primary;
  }

  build() {
    Row({ space: 4 }) {
      Row()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface })

      Button() {
        Text(this.type)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(colorScheme.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(colorScheme.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: colorScheme.outline })
          .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
      }
      .onClick(() => {
        this.onClick();
      })
    }
    .margin({ top: -4 })
  }
}

// MARK: - MapGridOverlay
@Component
struct MapGridOverlay {
  private lines: number[] = [1, 2, 3, 4, 5, 6];

  build() {
    Stack() {
      Column() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office'];
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
  ];
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number | null = null;

  private filteredMarkers(): AssetMarker[] {
    return this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type));
  }

  private selectedName(): string {
    if (this.selectedId === null) return 'None';
    const found = this.markers.find((m: AssetMarker) => m.id === this.selectedId);
    return found === undefined ? 'None' : found.name;
  }

  build() {
    Column({ space: 0 }) {
      // 顶部栏
      Stack() {
        Text('Asset Inventory')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(colorScheme.onSurface)
      }
      .width('100%')
      .height(86)
      .backgroundColor(colorScheme.surface)

      // 主要内容区域
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // 筛选器
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (c: string) => {
                Button() {
                  Text(c)
                    .fontSize(this.enabledCats.includes(c) ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                    .fontWeight(this.enabledCats.includes(c) ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                    .fontColor(this.enabledCats.includes(c) ? colorScheme.onPrimary : colorScheme.onSurface)
                    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                    .backgroundColor(this.enabledCats.includes(c) ? colorScheme.primary : colorScheme.surface)
                    .borderRadius(AppTokens.Shapes.small)
                    .border({ width: 1, color: colorScheme.outline })
                }
                .onClick(() => {
                  if (this.enabledCats.includes(c)) {
                    this.enabledCats = this.enabledCats.filter((x: string) => x !== c);
                  } else {
                    this.enabledCats = this.enabledCats.concat([c]);
                  }
                })
              }, (c: string) => c)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // 资产详情和地图
          Row({ space: AppTokens.Spacing.lg }) {
            // 左侧资产输入和选中卡片
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((value: string) => {
                  this.assetName = value;
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: colorScheme.outline })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(colorScheme.onSurface)

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((value: string) => {
                  this.assetCode = value;
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: colorScheme.outline })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(colorScheme.onSurface)

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((value: string) => {
                  this.assetType = value;
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: colorScheme.outline })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(colorScheme.onSurface)

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(colorScheme.onSurface)
                Text(this.selectedName())
                  .fontSize(AppTokens.Typography.headline.size)
                  .fontWeight(AppTokens.Typography.headline.weight)
                  .fontColor(colorScheme.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(colorScheme.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: colorScheme.outline })
              .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
            }
            .layoutWeight(1)

            // 地图区域
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.filteredMarkers(), (m: AssetMarker) => {
                MapMarker({
                  type: m.type,
                  selected: this.selectedId === m.id,
                  onClick: () => {
                    this.selectedId = this.selectedId === m.id ? null : m.id;
                  }
                })
                .position({ x: (m.x * 100).toString() + '%', y: (m.y * 100).toString() + '%' })
              }, (m: AssetMarker) => m.id.toString())
            }
            .layoutWeight(1)
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
          .alignItems(VerticalAlign.Top)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor(colorScheme.background)
      .layoutWeight(1)

      // 底部栏
      Column({ space: 0 }) {
        Row({ space: AppTokens.Spacing.md }) {
          Button() {
            Text('Reset')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(colorScheme.onSurface)
              .width('100%')
              .height(48)
              .backgroundColor(colorScheme.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = '';
            this.assetCode = '';
            this.assetType = 'Device';
            this.selectedId = null;
          })

          Button() {
            Text('Save Asset')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(colorScheme.onPrimary)
              .width('100%')
              .height(48)
              .backgroundColor(colorScheme.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
          .layoutWeight(1)
          .onClick(() => {})
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(colorScheme.surface)
      }
      .shadow({ radius: AppTokens.Shadow.level2.radius, color: AppTokens.Shadow.level2.color, offsetX: 0, offsetY: -AppTokens.Shadow.level2.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorScheme.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - SingleFileUIApp
@Entry
@Component
struct SingleFileUIApp {
  build() {
    RootScreen()
  }
}
