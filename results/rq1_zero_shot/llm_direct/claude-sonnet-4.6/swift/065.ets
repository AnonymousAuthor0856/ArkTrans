import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
  static readonly tertiary: string = '#474747';
  static readonly background: string = '#F6F6F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D1D1D1';
  static readonly success: string = '#2E7D32';
  static readonly warning: string = '#B98900';
  static readonly error: string = '#B3261E';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0A0A0A';
  static readonly onSurface: string = '#0A0A0A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Medium;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 48;
}

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

// MARK: - MapMarker Component
@Component
struct MapMarkerView {
  @Prop markerType: string = '';
  @Prop selected: boolean = false;
  onClick: () => void = () => {};

  getMarkerColor(): string {
    switch (this.markerType) {
      case 'Warehouse':
        return AppColors.tertiary;
      case 'Device':
        return AppColors.secondary;
      default:
        return AppColors.primary;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.getMarkerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppColors.primary : AppColors.surface
        })

      Button(this.markerType)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onClick();
        })
        .buttonStyle(ButtonStyleMode.NORMAL)
    }
  }
}

// MARK: - MapGridOverlay Component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines (rows)
      Column() {
        ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
          Divider()
            .color(AppColors.surfaceVariant)
            .strokeWidth(1)
          if (index < 6) {
            Blank().layoutWeight(1)
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)

      // Vertical lines (columns)
      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
          Divider()
            .vertical(true)
            .color(AppColors.surfaceVariant)
            .strokeWidth(1)
          if (index < 6) {
            Blank().layoutWeight(1)
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Entry
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
  @State selectedId: number = -1;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  isCatEnabled(cat: string): boolean {
    return this.enabledCats.indexOf(cat) >= 0;
  }

  toggleCat(cat: string): void {
    const idx = this.enabledCats.indexOf(cat);
    if (idx >= 0) {
      const newCats = this.enabledCats.filter((c: string) => c !== cat);
      this.enabledCats = newCats;
    } else {
      this.enabledCats = [...this.enabledCats, cat];
    }
  }

  getSelectedName(): string {
    if (this.selectedId === -1) {
      return 'None';
    }
    const found = this.markers.find((m: AssetMarker) => m.id === this.selectedId);
    return found ? found.name : 'None';
  }

  getFilteredMarkers(): AssetMarker[] {
    return this.markers.filter((m: AssetMarker) => this.enabledCats.indexOf(m.type) >= 0);
  }

  build() {
    Column() {
      // Top App Bar
      Stack() {
        Text('Asset Inventory')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Filter Chips
          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.categories, (cat: string) => {
                Button(cat)
                  .fontSize(this.isCatEnabled(cat) ? AppTypography.titleSize : AppTypography.bodySize)
                  .fontWeight(this.isCatEnabled(cat) ? AppTypography.titleWeight : AppTypography.bodyWeight)
                  .fontColor(this.isCatEnabled(cat) ? AppColors.onPrimary : AppColors.onSurface)
                  .padding({
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    top: AppSpacing.sm,
                    bottom: AppSpacing.sm
                  })
                  .backgroundColor(this.isCatEnabled(cat) ? AppColors.primary : AppColors.surface)
                  .borderRadius(AppShapes.small)
                  .border({ width: 1, color: AppColors.outline })
                  .onClick(() => {
                    this.toggleCat(cat);
                  })
                  .buttonStyle(ButtonStyleMode.NORMAL)
              })
            }
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: AppSpacing.md })

          // Asset Details and Map Row
          Row({ space: AppSpacing.lg }) {
            // Left Column - Asset Input and Selected Card
            Column({ space: AppSpacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((value: string) => {
                  this.assetName = value;
                })
                .fontSize(AppTypography.bodySize)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.tertiary)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.small)
                .border({ width: 1, color: AppColors.outline })
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.sm,
                  bottom: AppSpacing.sm
                })
                .width('100%')

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((value: string) => {
                  this.assetCode = value;
                })
                .fontSize(AppTypography.bodySize)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.tertiary)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.small)
                .border({ width: 1, color: AppColors.outline })
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.sm,
                  bottom: AppSpacing.sm
                })
                .width('100%')

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((value: string) => {
                  this.assetType = value;
                })
                .fontSize(AppTypography.bodySize)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.tertiary)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.small)
                .border({ width: 1, color: AppColors.outline })
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.sm,
                  bottom: AppSpacing.sm
                })
                .width('100%')

              // Selected Asset Card
              Column({ space: AppSpacing.sm }) {
                Text('Selected')
                  .fontSize(AppTypography.labelSize)
                  .fontWeight(AppTypography.labelWeight)
                  .fontColor(AppColors.onSurface)

                Text(this.getSelectedName())
                  .fontSize(AppTypography.headlineSize)
                  .fontWeight(AppTypography.headlineWeight)
                  .fontColor(AppColors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(AppSpacing.lg)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .border({ width: 1, color: AppColors.outline })
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // Map Area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()
                .width('100%')
                .height('100%')

              ForEach(this.getFilteredMarkers(), (m: AssetMarker) => {
                MapMarkerView({
                  markerType: m.type,
                  selected: this.selectedId === m.id,
                  onClick: () => {
                    this.selectedId = (this.selectedId === m.id) ? -1 : m.id;
                  }
                })
                .position({
                  x: this.mapWidth * m.x,
                  y: this.mapHeight * m.y
                })
              })
            }
            .layoutWeight(1)
            .aspectRatio(0.9)
            .constraintSize({ minHeight: 360 })
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .border({ width: 1, color: AppColors.outline })
            .onAreaChange((_oldValue: Area, newValue: Area) => {
              this.mapWidth = newValue.width as number;
              this.mapHeight = newValue.height as number;
            })
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .alignItems(VerticalAlign.Top)
          .width('100%')
        }
        .width('100%')
        .padding({ bottom: AppSpacing.md })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)
      .width('100%')

      // Bottom Bar
      Column() {
        Row({ space: AppSpacing.md }) {
          // Reset Button
          Button('Reset')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.assetName = '';
              this.assetCode = '';
              this.assetType = 'Device';
              this.selectedId = -1;
            })
            .buttonStyle(ButtonStyleMode.NORMAL)

          // Save Asset Button
          Button('Save Asset')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onPrimary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              // Save asset logic
            })
            .buttonStyle(ButtonStyleMode.NORMAL)
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .width('100%')
      }
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}