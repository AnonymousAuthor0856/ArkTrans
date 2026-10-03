// AppTokens - Design tokens for the application
class AppColors {
  primary: string = '#111111';
  secondary: string = '#2A2A2A';
  tertiary: string = '#474747';
  background: string = '#F6F6F6';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#EDEDED';
  outline: string = '#D1D1D1';
  success: string = '#2E7D32';
  warning: string = '#B98900';
  error: string = '#B3261E';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#0A0A0A';
  onSurface: string = '#0A0A0A';
}

interface FontInfo {
  size: number;
  weight: FontWeight;
}

class AppTypography {
  display: FontInfo = { size: 28, weight: FontWeight.Medium };
  headline: FontInfo = { size: 20, weight: FontWeight.Medium };
  title: FontInfo = { size: 16, weight: FontWeight.Medium };
  body: FontInfo = { size: 14, weight: FontWeight.Regular };
  label: FontInfo = { size: 12, weight: FontWeight.Medium };
}

class AppShapes {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
  xxxl: number = 48;
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppElevation {
  level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.10 };
  level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.14 };
  level3: ShadowSpec = { radius: 12, dy: 6, opacity: 0.16 };
  level4: ShadowSpec = { radius: 16, dy: 8, opacity: 0.18 };
  level5: ShadowSpec = { radius: 20, dy: 10, opacity: 0.20 };
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors();
  static readonly Typography: AppTypography = new AppTypography();
  static readonly Shapes: AppShapes = new AppShapes();
  static readonly Spacing: AppSpacing = new AppSpacing();
  static readonly Elevation: AppElevation = new AppElevation();
}

// Data Model
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

// Root Screen Component
@Entry
@Component
struct RootScreen {
  @State categories: string[] = ["Warehouse", "Device", "Office"];
  @State enabledCats: string[] = ["Warehouse", "Device", "Office"];
  @State markers: AssetMarker[] = [
    new AssetMarker(1, "Main Warehouse", "Warehouse", 0.18, 0.34),
    new AssetMarker(2, "CNC-07", "Device", 0.52, 0.46),
    new AssetMarker(3, "HQ Office", "Office", 0.75, 0.62),
    new AssetMarker(4, "Spare Parts", "Warehouse", 0.33, 0.78)
  ];
  @State assetName: string = "";
  @State assetCode: string = "";
  @State assetType: string = "Device";
  @State selectedId: number | null = null;

  private getSelectedName(): string {
    if (this.selectedId === null) return "None";
    const marker = this.markers.find(m => m.id === this.selectedId);
    return marker ? marker.name : "None";
  }

  private toggleCategory(cat: string) {
    if (this.enabledCats.includes(cat)) {
      this.enabledCats = this.enabledCats.filter(c => c !== cat);
    } else {
      this.enabledCats.push(cat);
    }
  }

  private resetForm() {
    this.assetName = "";
    this.assetCode = "";
    this.assetType = "Device";
    this.selectedId = null;
  }

  private getMarkerColor(type: string): string {
    switch (type) {
      case "Warehouse": return AppTokens.Colors.tertiary;
      case "Device": return AppTokens.Colors.secondary;
      default: return AppTokens.Colors.primary;
    }
  }

  @Builder
  MapMarker(type: string, id: number) {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker Circle
      Circle({ width: this.selectedId === id ? 28 : 22, height: this.selectedId === id ? 28 : 22 })
        .fill(this.getMarkerColor(type))
        .border({
          width: 2,
          color: this.selectedId === id ? AppTokens.Colors.primary : AppTokens.Colors.surface
        })

      // Text Card
      Text(type)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
          offsetY: AppTokens.Elevation.level1.dy
        })
        .margin({ left: 18, top: -4 })
        .onClick(() => {
          this.selectedId = this.selectedId === id ? null : id;
        })
    }
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      // Vertical Lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Line()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .layoutWeight(1)
          Line().width('100%').height(1).backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      // Horizontal Lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Line()
            .height('100%')
            .width(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .layoutWeight(1)
          Line().height('100%').width(1).backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
  }

  build() {
    Column() {
      // Top App Bar
      Text("Asset Inventory")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(86)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (c: string) => {
                Text(c)
                  .fontSize(this.enabledCats.includes(c) ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                  .fontWeight(this.enabledCats.includes(c) ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                  .fontColor(this.enabledCats.includes(c) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .backgroundColor(this.enabledCats.includes(c) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.small)
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md,
                    top: AppTokens.Spacing.sm,
                    bottom: AppTokens.Spacing.sm
                  })
                  .onClick(() => this.toggleCategory(c))
              })
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          // Assets and Map Row
          Row({ space: AppTokens.Spacing.lg }) {
            // Left Column: Inputs and Selected Card
            Column({ space: AppTokens.Spacing.md }) {
              // TextFields
              TextInput({ placeholder: "Asset Name", text: this.assetName })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .onChange((value: string) => this.assetName = value)

              TextInput({ placeholder: "Asset Code", text: this.assetCode })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .onChange((value: string) => this.assetCode = value)

              TextInput({ placeholder: "Asset Type", text: this.assetType })
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .onChange((value: string) => this.assetType = value)

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text("Selected")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                Text(this.getSelectedName())
                  .fontSize(AppTokens.Typography.headline.size)
                  .fontWeight(AppTokens.Typography.headline.weight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .shadow({
                radius: AppTokens.Elevation.level1.radius,
                color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
                offsetY: AppTokens.Elevation.level1.dy
              })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // Right Column: Map Area
            Stack({ alignContent: Alignment.TopStart }) {
              this.MapGridOverlay()
              
              ForEach(this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                this.MapMarker(m.type, m.id)
                // markAnchor and position are not directly available on @Builder return in this context, 
                // so we wrap it or apply directly if supported. 
                // In ArkTS, @Builder methods return void, so we cannot chain attributes directly on them.
                // To fix this, we can use a component or wrap it in a container.
              })
            }
            .layoutWeight(1)
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .clip(true)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.md
          })
          .alignItems(VerticalAlign.Top)
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Row({ space: AppTokens.Spacing.md }) {
        Button("Reset")
          .onClick(() => {
            this.resetForm();
          })
          .layoutWeight(1)
          .height(48)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)

        Button("Save Asset")
          .onClick(() => {
            // Save logic
          })
          .layoutWeight(1)
          .height(48)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.Elevation.level2.radius,
        color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
        offsetY: -AppTokens.Elevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}