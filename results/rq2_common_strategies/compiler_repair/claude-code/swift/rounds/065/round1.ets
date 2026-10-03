// MARK: - ShadowSpec
interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

// MARK: - AppTokens
class AppTokensColors {
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

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: number = FontWeight.Medium;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: number = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: number = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: number = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: number = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 48;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.10 };
  static readonly level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.14 };
  static readonly level3: ShadowSpec = { radius: 12, dy: 6, opacity: 0.16 };
  static readonly level4: ShadowSpec = { radius: 16, dy: 8, opacity: 0.18 };
  static readonly level5: ShadowSpec = { radius: 20, dy: 10, opacity: 0.20 };
}

// MARK: - AppColorScheme
class AppColorScheme {
  primary: string = AppTokensColors.primary;
  onPrimary: string = AppTokensColors.onPrimary;
  secondary: string = AppTokensColors.secondary;
  onSecondary: string = AppTokensColors.onSecondary;
  tertiary: string = AppTokensColors.tertiary;
  onTertiary: string = AppTokensColors.onTertiary;
  background: string = AppTokensColors.background;
  onBackground: string = AppTokensColors.onBackground;
  surface: string = AppTokensColors.surface;
  onSurface: string = AppTokensColors.onSurface;
  surfaceVariant: string = AppTokensColors.surfaceVariant;
  outline: string = AppTokensColors.outline;
  error: string = AppTokensColors.error;

  static readonly light: AppColorScheme = new AppColorScheme();
}

// MARK: - AssetMarker
interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

// MARK: - MapMarker Component
@Component
struct MapMarkerComponent {
  @Link selectedId: number;
  marker: AssetMarker = { id: 0, name: '', type: '', x: 0, y: 0 };
  colorScheme: AppColorScheme = AppColorScheme.light;

  private getMarkerColor(type: string): string {
    if (type === 'Warehouse') {
      return AppTokensColors.tertiary;
    } else if (type === 'Device') {
      return AppTokensColors.secondary;
    } else {
      return AppTokensColors.primary;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle({ width: this.selectedId === this.marker.id ? 28 : 22, height: this.selectedId === this.marker.id ? 28 : 22 })
        .fill(this.getMarkerColor(this.marker.type))
        .stroke(this.selectedId === this.marker.id ? AppTokensColors.primary : AppTokensColors.surface, 2)

      Text(this.marker.type)
        .fontSize(AppTokensTypography.labelSize)
        .fontWeight(AppTokensTypography.labelWeight)
        .fontColor(this.colorScheme.onSurface)
        .padding({ left: AppTokensSpacing.sm, right: AppTokensSpacing.sm, top: AppTokensSpacing.xs, bottom: AppTokensSpacing.xs })
        .backgroundColor(this.colorScheme.surface)
        .borderRadius(AppTokensShapes.small)
        .border({ width: 1, color: this.colorScheme.outline })
        .shadow({
          radius: AppTokensElevation.level1.radius,
          color: `rgba(0,0,0,${AppTokensElevation.level1.opacity})`,
          offsetY: AppTokensElevation.level1.dy
        })
        .translate({ x: 18, y: -4 })
        .onClick(() => {
          if (this.selectedId === this.marker.id) {
            this.selectedId = -1;
          } else {
            this.selectedId = this.marker.id;
          }
        })
    }
  }
}

// MARK: - MapGridOverlay Component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach([1, 2, 3, 4, 5, 6, 7], (_item: number, index: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppTokensColors.surfaceVariant)
            .width('100%')
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokensSpacing.lg)

      Row() {
        ForEach([1, 2, 3, 4, 5, 6, 7], (_item: number, index: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppTokensColors.surfaceVariant)
            .height('100%')
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokensSpacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - FilterChip Component
@Component
struct FilterChip {
  label: string = '';
  isOn: boolean = false;
  colorScheme: AppColorScheme = AppColorScheme.light;
  onToggle: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(this.isOn ? AppTokensTypography.titleSize : AppTokensTypography.bodySize)
      .fontWeight(this.isOn ? AppTokensTypography.titleWeight : AppTokensTypography.bodyWeight)
      .fontColor(this.isOn ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
      .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
      .backgroundColor(this.isOn ? this.colorScheme.primary : this.colorScheme.surface)
      .borderRadius(AppTokensShapes.small)
      .border({ width: 1, color: this.colorScheme.outline })
      .onClick(() => {
        this.onToggle();
      })
  }
}

// MARK: - SelectedAssetCard Component
@Component
struct SelectedAssetCard {
  @Link selectedId: number;
  markers: AssetMarker[] = [];
  colorScheme: AppColorScheme = AppColorScheme.light;

  private getSelectedName(): string {
    if (this.selectedId < 0) {
      return 'None';
    }
    let result: string = 'None';
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        result = this.markers[i].name;
        break;
      }
    }
    return result;
  }

  build() {
    Column({ space: AppTokensSpacing.sm }) {
      Text('Selected')
        .fontSize(AppTokensTypography.labelSize)
        .fontWeight(AppTokensTypography.labelWeight)
        .fontColor(this.colorScheme.onSurface)

      Text(this.getSelectedName())
        .fontSize(AppTokensTypography.headlineSize)
        .fontWeight(AppTokensTypography.headlineWeight)
        .fontColor(this.colorScheme.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokensSpacing.lg)
    .backgroundColor(this.colorScheme.surface)
    .borderRadius(AppTokensShapes.large)
    .border({ width: 1, color: this.colorScheme.outline })
    .shadow({
      radius: AppTokensElevation.level1.radius,
      color: `rgba(0,0,0,${AppTokensElevation.level1.opacity})`,
      offsetY: AppTokensElevation.level1.dy
    })
  }
}

// MARK: - RootScreen
@Entry
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
  @State selectedId: number = -1;

  private colorScheme: AppColorScheme = AppColorScheme.light;

  private toggleCategory(c: string): void {
    const idx: number = this.enabledCats.indexOf(c);
    if (idx >= 0) {
      this.enabledCats.splice(idx, 1);
    } else {
      this.enabledCats.push(c);
    }
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = -1;
  }

  private getFilteredMarkers(): AssetMarker[] {
    const result: AssetMarker[] = [];
    for (let i = 0; i < this.markers.length; i++) {
      if (this.enabledCats.indexOf(this.markers[i].type) >= 0) {
        result.push(this.markers[i]);
      }
    }
    return result;
  }

  build() {
    Column() {
      Stack() {
        Text('Asset Inventory')
          .fontSize(AppTokensTypography.displaySize)
          .fontWeight(AppTokensTypography.displayWeight)
          .fontColor(this.colorScheme.onSurface)
      }
      .width('100%')
      .height(86)
      .backgroundColor(this.colorScheme.surface)

      Scroll() {
        Column({ space: AppTokensSpacing.lg }) {
          Row({ space: AppTokensSpacing.sm }) {
            ForEach(this.categories, (c: string) => {
              FilterChip({
                label: c,
                isOn: this.enabledCats.indexOf(c) >= 0,
                colorScheme: this.colorScheme,
                onToggle: () => this.toggleCategory(c)
              })
            })
          }
          .width('100%')
          .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.md })

          Row({ space: AppTokensSpacing.lg }) {
            Column({ space: AppTokensSpacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((val: string) => { this.assetName = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokensTypography.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokensShapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((val: string) => { this.assetCode = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokensTypography.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokensShapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((val: string) => { this.assetType = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokensTypography.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokensShapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              SelectedAssetCard({
                selectedId: $selectedId,
                markers: this.markers,
                colorScheme: this.colorScheme
              })
            }
            .layoutWeight(1)

            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.getFilteredMarkers(), (m: AssetMarker) => {
                MapMarkerComponent({
                  selectedId: $selectedId,
                  marker: m,
                  colorScheme: this.colorScheme
                })
                  .position({
                    x: m.x * 100 + '%',
                    y: m.y * 100 + '%'
                  })
              })
            }
            .layoutWeight(1)
            .minHeight(360)
            .aspectRatio(0.9)
            .backgroundColor(AppTokensColors.surface)
            .borderRadius(AppTokensShapes.large)
            .border({ width: 1, color: AppTokensColors.outline })
          }
          .width('100%')
          .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })
        }
        .width('100%')
        .padding({ bottom: AppTokensSpacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.colorScheme.background)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)

      Column() {
        Row({ space: AppTokensSpacing.md }) {
          Button('Reset')
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(this.colorScheme.onSurface)
            .backgroundColor(this.colorScheme.surfaceVariant)
            .borderRadius(AppTokensShapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => this.resetForm())

          Button('Save Asset')
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(this.colorScheme.onPrimary)
            .backgroundColor(this.colorScheme.primary)
            .borderRadius(AppTokensShapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.md, bottom: AppTokensSpacing.md })
        .backgroundColor(this.colorScheme.surface)
      }
      .width('100%')
      .shadow({
        radius: AppTokensElevation.level2.radius,
        color: `rgba(0,0,0,${AppTokensElevation.level2.opacity})`,
        offsetY: 0 - AppTokensElevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}
