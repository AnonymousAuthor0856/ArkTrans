// MARK: - AppTokens
class AppTokens {
  static class Colors {
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

  static class TypographyTokens {
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

  static class Shapes {
    static readonly small: number = 8;
    static readonly medium: number = 12;
    static readonly large: number = 16;
  }

  static class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 32;
    static readonly xxxl: number = 48;
  }

  static class ElevationMapping {
    static readonly level1: { radius: number, dy: number, opacity: number } = { radius: 4, dy: 2, opacity: 0.10 };
    static readonly level2: { radius: number, dy: number, opacity: number } = { radius: 8, dy: 4, opacity: 0.14 };
    static readonly level3: { radius: number, dy: number, opacity: number } = { radius: 12, dy: 6, opacity: 0.16 };
    static readonly level4: { radius: number, dy: number, opacity: number } = { radius: 16, dy: 8, opacity: 0.18 };
    static readonly level5: { radius: number, dy: number, opacity: number } = { radius: 20, dy: 10, opacity: 0.20 };
  }
}

// MARK: - AppColorScheme
class AppColorScheme {
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
  @Link selectedId: number | null;
  marker: AssetMarker;
  colorScheme: AppColorScheme = AppColorScheme.light;

  private getMarkerColor(type: string): string {
    switch (type) {
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
      Circle({ width: this.selectedId === this.marker.id ? 28 : 22, height: this.selectedId === this.marker.id ? 28 : 22 })
        .fill(this.getMarkerColor(this.marker.type))
        .stroke(this.selectedId === this.marker.id ? AppTokens.Colors.primary : AppTokens.Colors.surface, 2)

      Text(this.marker.type)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(this.colorScheme.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(this.colorScheme.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: this.colorScheme.outline })
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
        .translate({ x: 18, y: -4 })
        .onClick(() => {
          this.selectedId = (this.selectedId === this.marker.id) ? null : this.marker.id;
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
        ForEach([1, 2, 3, 4, 5, 6, 7], (_: number, index: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
            .width('100%')
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach([1, 2, 3, 4, 5, 6, 7], (_: number, index: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
            .height('100%')
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
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
      .fontSize(this.isOn ? AppTokens.TypographyTokens.titleSize : AppTokens.TypographyTokens.bodySize)
      .fontWeight(this.isOn ? AppTokens.TypographyTokens.titleWeight : AppTokens.TypographyTokens.bodyWeight)
      .fontColor(this.isOn ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.isOn ? this.colorScheme.primary : this.colorScheme.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: this.colorScheme.outline })
      .onClick(() => {
        this.onToggle();
      })
  }
}

// MARK: - SelectedAssetCard Component
@Component
struct SelectedAssetCard {
  @Link selectedId: number | null;
  markers: AssetMarker[] = [];
  colorScheme: AppColorScheme = AppColorScheme.light;

  private getSelectedName(): string {
    if (this.selectedId === null) return 'None';
    const found = this.markers.find(m => m.id === this.selectedId);
    return found ? found.name : 'None';
  }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Selected')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(this.colorScheme.onSurface)

      Text(this.getSelectedName())
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(this.colorScheme.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(this.colorScheme.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: this.colorScheme.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetY: AppTokens.ElevationMapping.level1.dy
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
  @State selectedId: number | null = null;

  private colorScheme: AppColorScheme = AppColorScheme.light;

  private toggleCategory(c: string): void {
    const idx = this.enabledCats.indexOf(c);
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
    this.selectedId = null;
  }

  build() {
    Column() {
      // Top bar
      Stack() {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(this.colorScheme.onSurface)
      }
      .width('100%')
      .height(86)
      .backgroundColor(this.colorScheme.surface)

      // Main content - Scroll
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter chips row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.categories, (c: string) => {
              FilterChip({
                label: c,
                isOn: this.enabledCats.includes(c),
                colorScheme: this.colorScheme,
                onToggle: () => this.toggleCategory(c)
              })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Asset details and map row
          Row({ space: AppTokens.Spacing.lg }) {
            // Left side - input and selected card
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((val: string) => { this.assetName = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((val: string) => { this.assetCode = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((val: string) => { this.assetType = val; })
                .placeholderColor('#999999')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontColor(this.colorScheme.onSurface)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(this.colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme.outline })

              SelectedAssetCard({
                selectedId: $selectedId,
                markers: this.markers,
                colorScheme: this.colorScheme
              })
            }
            .layoutWeight(1)

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
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
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.colorScheme.background)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)

      // Bottom bar
      Column() {
        Row({ space: AppTokens.Spacing.md }) {
          Button('Reset')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.colorScheme.onSurface)
            .backgroundColor(this.colorScheme.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => this.resetForm())

          Button('Save Asset')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.colorScheme.onPrimary)
            .backgroundColor(this.colorScheme.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(this.colorScheme.surface)
      }
      .width('100%')
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
        offsetY: -AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}
