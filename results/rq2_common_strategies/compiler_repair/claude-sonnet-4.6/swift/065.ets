// MARK: - AppColors as class with static members
class AppColors {
  static primary: string = '#111111';
  static secondary: string = '#2A2A2A';
  static tertiary: string = '#474747';
  static background: string = '#F6F6F6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EDEDED';
  static outline: string = '#D1D1D1';
  static success: string = '#2E7D32';
  static warning: string = '#B98900';
  static error: string = '#B3261E';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#0A0A0A';
  static onSurface: string = '#0A0A0A';
}

class SpacingValues {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
  static xxxl: number = 48;
}

// MARK: - Data Models
class AssetMarker {
  id: number = 0;
  name: string = '';
  type: string = '';
  x: number = 0;
  y: number = 0;

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
  onMarkerClick: () => void = () => {};

  getMarkerColor(): string {
    if (this.markerType === 'Warehouse') {
      return AppColors.tertiary;
    } else if (this.markerType === 'Device') {
      return AppColors.secondary;
    } else {
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
          color: this.selected ? AppColors.primary : AppColors.surface,
          style: BorderStyle.Solid
        })

      Button({ type: ButtonType.Normal }) {
        Text(this.markerType)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({
            left: SpacingValues.sm,
            right: SpacingValues.sm,
            top: SpacingValues.xs,
            bottom: SpacingValues.xs
          })
      }
      .backgroundColor(AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
      .onClick(() => {
        this.onMarkerClick();
      })
      .offset({ x: 18, y: -4 })
      .padding(0)
    }
  }
}

// MARK: - MapGridOverlay Component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Vertical lines (rows)
      Column() {
        ForEach([0, 1, 2, 3, 4, 5, 6] as number[], (index: number) => {
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
      .padding(SpacingValues.lg)

      // Horizontal lines (columns)
      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6] as number[], (index: number) => {
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
      .padding(SpacingValues.lg)
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
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78),
  ];
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number = -1;
  @State mapWidth: number = 300;
  @State mapHeight: number = 360;

  getSelectedName(): string {
    if (this.selectedId === -1) {
      return 'None';
    }
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        return this.markers[i].name;
      }
    }
    return 'None';
  }

  isCatEnabled(cat: string): boolean {
    return this.enabledCats.indexOf(cat) >= 0;
  }

  toggleCat(cat: string): void {
    const idx = this.enabledCats.indexOf(cat);
    if (idx >= 0) {
      this.enabledCats = this.enabledCats.filter((c: string) => c !== cat);
    } else {
      const newArr = [...this.enabledCats, cat];
      this.enabledCats = newArr;
    }
  }

  filteredMarkers(): AssetMarker[] {
    return this.markers.filter((m: AssetMarker) => this.enabledCats.indexOf(m.type) >= 0);
  }

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.surface)
      .border({ width: { bottom: 1 }, color: AppColors.outline, style: BorderStyle.Solid })

      // Main Content
      Scroll() {
        Column({ space: SpacingValues.lg }) {
          // Filter Chips
          Scroll() {
            Row({ space: SpacingValues.sm }) {
              ForEach(this.categories, (cat: string) => {
                Button({ type: ButtonType.Normal }) {
                  Text(cat)
                    .fontSize(this.isCatEnabled(cat) ? 16 : 14)
                    .fontWeight(this.isCatEnabled(cat) ? FontWeight.Medium : FontWeight.Normal)
                    .fontColor(this.isCatEnabled(cat) ? AppColors.onPrimary : AppColors.onSurface)
                    .padding({
                      left: SpacingValues.md,
                      right: SpacingValues.md,
                      top: SpacingValues.sm,
                      bottom: SpacingValues.sm
                    })
                }
                .backgroundColor(this.isCatEnabled(cat) ? AppColors.primary : AppColors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
                .onClick(() => {
                  this.toggleCat(cat);
                })
                .padding(0)
              })
            }
            .padding({ left: SpacingValues.lg, right: SpacingValues.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: SpacingValues.md })

          // Asset Details + Map Row
          Row({ space: SpacingValues.lg }) {
            // Left Column - Asset Input + Selected Card
            Column({ space: SpacingValues.md }) {
              // Asset Name
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((val: string) => {
                  this.assetName = val;
                })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#888888')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(8)
                .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
                .padding({
                  left: SpacingValues.md,
                  right: SpacingValues.md,
                  top: SpacingValues.sm,
                  bottom: SpacingValues.sm
                })
                .width('100%')

              // Asset Code
              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((val: string) => {
                  this.assetCode = val;
                })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#888888')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(8)
                .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
                .padding({
                  left: SpacingValues.md,
                  right: SpacingValues.md,
                  top: SpacingValues.sm,
                  bottom: SpacingValues.sm
                })
                .width('100%')

              // Asset Type
              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((val: string) => {
                  this.assetType = val;
                })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#888888')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(8)
                .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
                .padding({
                  left: SpacingValues.md,
                  right: SpacingValues.md,
                  top: SpacingValues.sm,
                  bottom: SpacingValues.sm
                })
                .width('100%')

              // Selected Asset Card
              Column({ space: SpacingValues.sm }) {
                Text('Selected')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                Text(this.getSelectedName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(SpacingValues.lg)
              .backgroundColor(AppColors.surface)
              .borderRadius(16)
              .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // Map Area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()
                .width('100%')
                .height('100%')

              ForEach(this.filteredMarkers(), (m: AssetMarker) => {
                MapMarkerView({
                  markerType: m.type,
                  selected: this.selectedId === m.id,
                  onMarkerClick: () => {
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
            .height(360)
            .backgroundColor(AppColors.surface)
            .borderRadius(16)
            .border({ width: 1, color: AppColors.outline, style: BorderStyle.Solid })
            .clip(true)
            .onAreaChange((_oldVal: Area, newVal: Area) => {
              this.mapWidth = newVal.width as number;
              this.mapHeight = newVal.height as number;
            })
          }
          .padding({ left: SpacingValues.lg, right: SpacingValues.lg })
          .alignItems(VerticalAlign.Top)
          .width('100%')
        }
        .width('100%')
        .padding({ bottom: SpacingValues.md })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom Bar
      Column() {
        Row({ space: SpacingValues.md }) {
          // Reset Button
          Button({ type: ButtonType.Normal }) {
            Text('Reset')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {
            this.assetName = '';
            this.assetCode = '';
            this.assetType = 'Device';
            this.selectedId = -1;
          })

          // Save Asset Button
          Button({ type: ButtonType.Normal }) {
            Text('Save Asset')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppColors.primary)
          .borderRadius(12)
          .onClick(() => {
            // Save logic
          })
        }
        .padding({
          left: SpacingValues.lg,
          right: SpacingValues.lg,
          top: SpacingValues.md,
          bottom: SpacingValues.md
        })
        .width('100%')
      }
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}