import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens Interfaces
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
  level4: ElevationLevel;
  level5: ElevationLevel;
}

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
  } as ColorTokens,
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  } as ShapeTokens,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  } as SpacingTokens,
  ElevationMapping: {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
    level4: { radius: 16, dy: 8, opacity: 0.18 },
    level5: { radius: 20, dy: 10, opacity: 0.20 }
  } as ElevationMapping
};

// MARK: - Data Models
interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

// MARK: - Components

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Vertical lines
      Column({ space: 0 }) {
        ForEach(Array.from({ length: 6 }), () => {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .padding(AppTokens.Spacing.lg)

      // Horizontal lines
      Row({ space: 0 }) {
        ForEach(Array.from({ length: 6 }), () => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarkerComponent {
  @Prop type: string;
  @Prop selected: boolean;
  @Prop colorScheme: Record<string, string>;
  private onClickHandler: () => void = () => {};

  aboutToAppear() {
    // Initialization if needed
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.getMarkerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface
        })

      Button({ type: ButtonType.Normal }) {
        Text(this.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .foregroundColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(AppTokens.Shapes.small)
          .shadow({ radius: AppTokens.ElevationMapping.level1.radius, offsetY: AppTokens.ElevationMapping.level1.dy, color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')' })
      }
      .type(ButtonType.Capsule)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.onClickHandler();
      })
      .position({ x: 18, y: -4 })
    }
  }

  getMarkerColor(): ResourceColor {
    switch (this.type) {
      case 'Warehouse': return AppTokens.Colors.tertiary;
      case 'Device': return AppTokens.Colors.secondary;
      default: return AppTokens.Colors.primary;
    }
  }
}

@Component
struct RootScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office'];
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ];
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number | null = null;
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .foregroundColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(86)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips
          Scroll({ scroller: this.scroller }) {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (category: string) => {
                Button(category)
                  .onClick(() => {
                    const isOn = this.enabledCats.includes(category);
                    if (isOn) {
                      this.enabledCats = this.enabledCats.filter(c => c !== category);
                    } else {
                      this.enabledCats.push(category);
                    }
                  })
                  .fontSize(this.enabledCats.includes(category) ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                  .fontWeight(this.enabledCats.includes(category) ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                  .foregroundColor(this.enabledCats.includes(category) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .backgroundColor(this.enabledCats.includes(category) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.small)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              })
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .indicator(Indicator.Auto)

          // Asset Details and Map
          Row({ space: AppTokens.Spacing.lg }) {
            // Left Side: Inputs and Selected Card
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name' })
                .text(this.assetName)
                .onChange((value: string) => {
                  this.assetName = value;
                })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .width('100%')

              TextInput({ placeholder: 'Asset Code' })
                .text(this.assetCode)
                .onChange((value: string) => {
                  this.assetCode = value;
                })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .width('100%')

              TextInput({ placeholder: 'Asset Type' })
                .text(this.assetType)
                .onChange((value: string) => {
                  this.assetType = value;
                })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .width('100%')

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .foregroundColor(AppTokens.Colors.onSurface)
                
                Text(this.getSelectedAssetName())
                  .fontSize(AppTokens.TypographyTokens.headline.size)
                  .fontWeight(AppTokens.TypographyTokens.headline.weight)
                  .foregroundColor(AppTokens.Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.ElevationMapping.level1.radius, offsetY: AppTokens.ElevationMapping.level1.dy, color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')' })
            }
            .layoutWeight(1)

            // Right Side: Map Area
            Stack() {
              MapGridOverlay()
              
              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: AssetMarker) => {
                MapMarkerComponent({
                  type: marker.type,
                  selected: this.selectedId === marker.id,
                  colorScheme: {},
                  onClickHandler: () => {
                    this.selectedId = this.selectedId === marker.id ? null : marker.id;
                  }
                })
                .position({
                  x: `${marker.x * 100}%`,
                  y: `${marker.y * 100}%`
                })
              })
            }
            .height(360)
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .borderRadius(AppTokens.Shapes.large)
            .layoutWeight(1)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .padding({ bottom: AppTokens.Spacing.md })
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      // Bottom Bar
      Column() {
        Row({ space: AppTokens.Spacing.md }) {
          Button('Reset')
            .onClick(() => {
              this.assetName = '';
              this.assetCode = '';
              this.assetType = 'Device';
              this.selectedId = null;
            })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)

          Button('Save Asset')
            .onClick(() => {
              // Save logic
            })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, offsetY: -AppTokens.ElevationMapping.level2.dy, color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level2.opacity + ')' })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  getSelectedAssetName(): string {
    if (this.selectedId === null) return 'None';
    const found = this.markers.find(m => m.id === this.selectedId);
    return found ? found.name : 'None';
  }
}

@Entry
@Component
struct SingleFileUIApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}