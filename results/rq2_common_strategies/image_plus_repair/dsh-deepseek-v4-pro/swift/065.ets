// MARK: - AppTokens
// 翻译 Kotlin 的 AppTokens 对象到 ArkTS 类。
class Colors {
  static readonly primary: string = '#FF111111';
  static readonly secondary: string = '#FF2A2A2A';
  static readonly tertiary: string = '#FF474747';
  static readonly background: string = '#FFF6F6F6';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFEDEDED';
  static readonly outline: string = '#FFD1D1D1';
  static readonly success: string = '#FF2E7D32';
  static readonly warning: string = '#FFB98900';
  static readonly error: string = '#FFB3261E';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF0A0A0A';
  static readonly onSurface: string = '#FF0A0A0A';
}

class FontToken {
  size: number;
  weight: number;
  constructor(size: number, weight: number) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokens {
  // ArkUI 使用 fontSize 和 fontWeight 直接匹配系统字体，size 和 weight 即可。
  static readonly display: FontToken = new FontToken(28, 600);
  static readonly headline: FontToken = new FontToken(20, 500);
  static readonly title: FontToken = new FontToken(16, 500);
  static readonly body: FontToken = new FontToken(14, 400);
  static readonly label: FontToken = new FontToken(12, 500);
}

class Shapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 48;
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
  shadowColor(): string {
    const alpha = Math.round(this.opacity * 255);
    const hex = alpha.toString(16).toUpperCase();
    const padded = hex.length < 2 ? '0' + hex : hex;
    return '#' + padded + '000000';
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
  static readonly level4: ShadowSpec = new ShadowSpec(10, 16, 8, 0.18);
  static readonly level5: ShadowSpec = new ShadowSpec(14, 20, 10, 0.20);
}

// MARK: - AppTheme
// 使用 AppColorScheme 类来模拟颜色主题，以便在整个视图层级中访问。
class AppColorScheme {
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  outline: string;
  error: string;

  constructor(primary: string, onPrimary: string, secondary: string, onSecondary: string,
    tertiary: string, onTertiary: string, background: string, onBackground: string,
    surface: string, onSurface: string, surfaceVariant: string, outline: string, error: string) {
    this.primary = primary;
    this.onPrimary = onPrimary;
    this.secondary = secondary;
    this.onSecondary = onSecondary;
    this.tertiary = tertiary;
    this.onTertiary = onTertiary;
    this.background = background;
    this.onBackground = onBackground;
    this.surface = surface;
    this.onSurface = onSurface;
    this.surfaceVariant = surfaceVariant;
    this.outline = outline;
    this.error = error;
  }

  static readonly light: AppColorScheme = new AppColorScheme(
    Colors.primary, Colors.onPrimary, Colors.secondary, Colors.onSecondary,
    Colors.tertiary, Colors.onTertiary, Colors.background, Colors.onBackground,
    Colors.surface, Colors.onSurface, Colors.surfaceVariant, Colors.outline, Colors.error
  );
}

// MARK: - Data Models
// 翻译 Kotlin 的 AssetMarker 数据类
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
// 翻译 Kotlin 的 MapMarker Composable
@Component
struct MapMarker {
  @Prop type: string = '';
  @Prop selected: boolean = false;
  colorScheme: AppColorScheme = AppColorScheme.light;
  onTap: () => void = () => {};

  markerColor(): string {
    if (this.type === 'Warehouse') {
      return Colors.tertiary;
    }
    if (this.type === 'Device') {
      return Colors.secondary;
    }
    return Colors.primary;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.markerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .stroke(this.selected ? Colors.primary : Colors.surface)
        .strokeWidth(2)

      // 文本卡片
      Button() {
        Text(this.type)
          .fontSize(TypographyTokens.label.size)
          .fontWeight(TypographyTokens.label.weight)
          .fontColor(this.colorScheme.onSurface)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      }
      .type(ButtonType.Normal)
      .backgroundColor(this.colorScheme.surface)
      .borderRadius(Shapes.small)
      .border({ width: 1, color: this.colorScheme.outline })
      .shadow({
        radius: ElevationMapping.level1.radius,
        color: ElevationMapping.level1.shadowColor(),
        offsetX: 0,
        offsetY: ElevationMapping.level1.dy
      })
      .onClick(() => {
        this.onTap();
      })
      .offset({ x: 18, y: -4 })
    }
  }
}

// MARK: - MapGridOverlay
// 翻译 Kotlin 的 MapGridOverlay Composable
@Component
struct MapGridOverlay {
  gridLines: number[] = [0, 1, 2, 3, 4, 5];

  build() {
    Stack() {
      // 水平线（纵向排列）
      Column() {
        ForEach(this.gridLines, (item: number) => {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(Colors.surfaceVariant)
          Blank()
        }, (item: number) => item.toString())
        Row()
          .width('100%')
          .height(1)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg)

      // 垂直线（横向排列）
      Row() {
        ForEach(this.gridLines, (item: number) => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(Colors.surfaceVariant)
          Blank()
        }, (item: number) => item.toString())
        Column()
          .width(1)
          .height('100%')
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  colorScheme: AppColorScheme = AppColorScheme.light;

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
  @State selectedId: number = -1;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  selectedName(): string {
    if (this.selectedId < 0) {
      return 'None';
    }
    const found = this.markers.find((m: AssetMarker) => m.id === this.selectedId);
    return found === undefined ? 'None' : found.name;
  }

  build() {
    Column({ space: 0 }) {
      // 顶部栏 (CenterAlignedTopAppBar)
      Stack({ alignContent: Alignment.Center }) {
        Text('Asset Inventory')
          .fontSize(TypographyTokens.display.size)
          .fontWeight(TypographyTokens.display.weight)
          .fontColor(this.colorScheme.onSurface)
          .padding({ top: 200, bottom: 200 })
      }
      .width('100%')
      .height(86)
      .backgroundColor(this.colorScheme.surface)

      // 主要内容区域
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Filter Chips
          Scroll() {
            Row({ space: Spacing.sm }) {
              ForEach(this.categories, (c: string) => {
                Button() {
                  Text(c)
                    .fontSize(this.enabledCats.includes(c) ? TypographyTokens.title.size : TypographyTokens.body.size)
                    .fontWeight(this.enabledCats.includes(c) ? TypographyTokens.title.weight : TypographyTokens.body.weight)
                    .fontColor(this.enabledCats.includes(c) ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
                    .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.enabledCats.includes(c) ? this.colorScheme.primary : this.colorScheme.surface)
                .borderRadius(Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .onClick(() => {
                  if (this.enabledCats.includes(c)) {
                    this.enabledCats = this.enabledCats.filter((item: string) => item !== c);
                  } else {
                    this.enabledCats = this.enabledCats.concat([c]);
                  }
                })
              }, (c: string) => c)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md })

          // 资产详情和地图 (Row)
          Row({ space: Spacing.lg }) {
            // 左侧资产输入和选中卡片
            Column({ space: Spacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((value: string) => { this.assetName = value; })
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(this.colorScheme.onSurface)
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
                .width('100%')

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((value: string) => { this.assetCode = value; })
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(this.colorScheme.onSurface)
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
                .width('100%')

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((value: string) => { this.assetType = value; })
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(this.colorScheme.onSurface)
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
                .width('100%')

              // Selected Asset Card
              Column({ space: Spacing.sm }) {
                Text('Selected')
                  .fontSize(TypographyTokens.label.size)
                  .fontWeight(TypographyTokens.label.weight)
                  .fontColor(this.colorScheme.onSurface)
                Text(this.selectedName())
                  .fontSize(TypographyTokens.headline.size)
                  .fontWeight(TypographyTokens.headline.weight)
                  .fontColor(this.colorScheme.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(Spacing.lg)
              .backgroundColor(this.colorScheme.surface)
              .borderRadius(Shapes.large)
              .border({ width: 1, color: this.colorScheme.outline })
              .shadow({
                radius: ElevationMapping.level1.radius,
                color: ElevationMapping.level1.shadowColor(),
                offsetX: 0,
                offsetY: ElevationMapping.level1.dy
              })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // 地图区域
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()
              ForEach(this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                MapMarker({
                  type: m.type,
                  selected: this.selectedId === m.id,
                  onTap: () => {
                    this.selectedId = (this.selectedId === m.id) ? -1 : m.id;
                  },
                  colorScheme: this.colorScheme
                })
                  .offset({ x: this.mapWidth * m.x, y: this.mapHeight * m.y })
              }, (m: AssetMarker) => m.id.toString())
            }
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.mapWidth = newValue.width as number;
              this.mapHeight = newValue.height as number;
            })
            .layoutWeight(1)
            .constraintSize({ minHeight: 360 })
            .aspectRatio(0.9)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.large)
            .border({ width: 1, color: Colors.outline })
          }
          .alignItems(VerticalAlign.Top)
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg })
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ bottom: Spacing.md })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.colorScheme.background)

      // 底部栏 (BottomBar - Surface)
      Column({ space: 0 }) {
        Row()
          .width('100%')
          .height(0)
          .shadow({
            radius: ElevationMapping.level2.radius,
            color: ElevationMapping.level2.shadowColor(),
            offsetX: 0,
            offsetY: -ElevationMapping.level2.dy
          })

        Row({ space: Spacing.md }) {
          // Reset 按钮
          Button() {
            Text('Reset')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(this.colorScheme.onSurface)
          }
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.colorScheme.surfaceVariant)
          .borderRadius(Shapes.medium)
          .onClick(() => {
            this.assetName = '';
            this.assetCode = '';
            this.assetType = 'Device';
            this.selectedId = -1;
          })

          // Save Asset 按钮
          Button() {
            Text('Save Asset')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(this.colorScheme.onPrimary)
          }
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.colorScheme.primary)
          .borderRadius(Shapes.medium)
          .onClick(() => {
            // 保存资产逻辑
          })
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        .backgroundColor(this.colorScheme.surface)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}
