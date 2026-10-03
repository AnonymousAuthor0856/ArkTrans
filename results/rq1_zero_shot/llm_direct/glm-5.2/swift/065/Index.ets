// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.MEDIUM },
    headline: { size: 20, weight: FontWeight.MEDIUM },
    title: { size: 16, weight: FontWeight.MEDIUM },
    body: { size: 14, weight: FontWeight.NORMAL },
    label: { size: 12, weight: FontWeight.MEDIUM }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  };

  static readonly ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
    level4: { radius: 16, dy: 8, opacity: 0.18 },
    level5: { radius: 20, dy: 10, opacity: 0.20 }
  };
}

// AppColorScheme.ets
export class AppColorScheme {
  primary: string = AppTokens.Colors.primary;
  onPrimary: string = AppTokens.Colors.onPrimary;
  secondary: string = AppTokens.Colors.secondary;
  onSecondary: string = AppTokens.Colors.onSecondary;
  tertiary: string = AppTokens.Colors.tertiary;
  onTertiary: string = AppTokens.Colors.onTertiary;
  background: string = AppTokens.Colors.background;
  onBackground: string = AppTokens.Colors.onBackground;
  surface: string = AppTokens.Colors.surface;
  onSurface: string = AppTokens.Colors.onSurface;
  surfaceVariant: string = AppTokens.Colors.surfaceVariant;
  outline: string = AppTokens.Colors.outline;
  error: string = AppTokens.Colors.error;

  static light: AppColorScheme = new AppColorScheme();
}

// AssetMarker.ets
export class AssetMarker {
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

// MapMarker.ets
@Component
export struct MapMarker {
  @Prop type: string;
  @Prop selected: boolean;
  onClick: () => void = () => {};
  colorScheme: AppColorScheme = AppColorScheme.light;

  getMarkerColor(): string {
    switch (this.type) {
      case 'Warehouse':
        return AppTokens.Colors.tertiary;
      case 'Device':
        return AppTokens.Colors.secondary;
      default:
        return AppTokens.Colors.primary;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Circle Marker
      Circle({ width: this.selected ? 28 : 22, height: this.selected ? 28 : 22 })
        .fill(this.getMarkerColor())
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface, 2)

      // Text Card
      Button(this.type, { type: ButtonType.Normal })
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(this.colorScheme.onSurface)
        .padding({ horizontal: AppTokens.Spacing.sm, vertical: AppTokens.Spacing.xs })
        .backgroundColor(this.colorScheme.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: this.colorScheme.outline })
        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
        .margin({ left: 18, top: -4 })
        .onClick(() => this.onClick())
    }
  }
}

// MapGridOverlay.ets
@Component
export struct MapGridOverlay {
  colorScheme: AppColorScheme = AppColorScheme.light;

  build() {
    Stack() {
      // Vertical Lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider().color(AppTokens.Colors.surfaceVariant).strokeWidth(1).layoutWeight(1)
          Divider().color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')

      // Horizontal Lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider().vertical(true).color(AppTokens.Colors.surfaceVariant).strokeWidth(1).layoutWeight(1)
          Divider().vertical(true).color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
    }
  }
}

// RootScreen.ets
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
  @State selectedId: number | null = null;

  getSelectedName(): string {
    if (this.selectedId === null) return 'None';
    const marker = this.markers.find(m => m.id === this.selectedId);
    return marker ? marker.name : 'None';
  }

  build() {
    Column() {
      // Top App Bar
      Text('Asset Inventory')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(this.colorScheme.onSurface)
        .height(86)
        .width('100%')
        .backgroundColor(this.colorScheme.surface)
        .textAlign(TextAlign.Center)

      // Main Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (c: string) => {
                Button(c, { type: ButtonType.Normal })
                  .fontSize(this.enabledCats.includes(c) ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                  .fontWeight(this.enabledCats.includes(c) ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                  .fontColor(this.enabledCats.includes(c) ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
                  .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
                  .backgroundColor(this.enabledCats.includes(c) ? this.colorScheme.primary : this.colorScheme.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: this.colorScheme.outline })
                  .onClick(() => {
                    if (this.enabledCats.includes(c)) {
                      this.enabledCats = this.enabledCats.filter(cat => cat !== c);
                    } else {
                      this.enabledCats.push(c);
                    }
                  })
              })
            }
            .padding({ horizontal: AppTokens.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: AppTokens.Spacing.md })

          // Asset Details and Map
          Row({ space: AppTokens.Spacing.lg }) {
            // Left Column
            Column({ space: AppTokens.Spacing.md }) {
              // Text Fields
              TextInput({ text: this.assetName, placeholder: 'Asset Name' })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(this.colorScheme.onSurface)
                .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((val: string) => this.assetName = val)

              TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(this.colorScheme.onSurface)
                .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((val: string) => this.assetCode = val)

              TextInput({ text: this.assetType, placeholder: 'Asset Type' })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(this.colorScheme.onSurface)
                .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((val: string) => this.assetType = val)

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(this.colorScheme.onSurface)
                Text(this.getSelectedName())
                  .fontSize(AppTokens.TypographyTokens.headline.size)
                  .fontWeight(AppTokens.TypographyTokens.headline.weight)
                  .fontColor(this.colorScheme.onSurface)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(this.colorScheme.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: this.colorScheme.outline })
              .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
            }
            .layoutWeight(1)

            // Map Area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay({ colorScheme: this.colorScheme })
                .width('100%')
                .height('100%')

              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                MapMarker({
                  type: m.type,
                  selected: this.selectedId === m.id,
                  onClick: () => {
                    this.selectedId = this.selectedId === m.id ? null : m.id;
                  },
                  colorScheme: this.colorScheme
                })
                  .markAnchor({ x: 0, y: 0 })
                  .position({ x: `${m.x * 100}%`, y: `${m.y * 100}%` })
              })
            }
            .layoutWeight(1)
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
          .width('100%')
          .padding({ horizontal: AppTokens.Spacing.lg })
        }
        .padding({ bottom: AppTokens.Spacing.md })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(this.colorScheme.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}