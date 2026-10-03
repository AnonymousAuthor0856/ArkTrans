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

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.SemiBold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
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

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
    level4: { radius: 16, dy: 8, opacity: 0.18 },
    level5: { radius: 20, dy: 10, opacity: 0.20 }
  };
}

// AssetMarker.ets
export interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

// MapMarker.ets
import { AppTokens } from './AppTokens';

@Component
export struct MapMarker {
  @Prop type: string;
  @Prop selected: boolean;
  @Prop colorScheme: Record<string, string>;
  onClick: () => void = () => {};

  private getMarkerColor(): string {
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
      // Circle marker
      Circle()
        .fill(this.getMarkerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .strokeWidth(2)

      // Text card
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text(this.type)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(this.colorScheme['onSurface'])
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(this.colorScheme['surface'])
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: this.colorScheme['outline'] })
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            offsetY: AppTokens.Elevation.level1.dy,
            color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`
          })
      }
      .onClick(() => {
        this.onClick();
      })
      .offset({ x: 18, y: -4 })
    }
  }
}

// MapGridOverlay.ets
import { AppTokens } from './AppTokens';

@Component
export struct MapGridOverlay {
  build() {
    Stack() {
      // Vertical lines
      Column({ space: 0 }) {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Row() {
            Divider()
              .strokeWidth(1)
              .color(AppTokens.Colors.surfaceVariant)
              .layoutWeight(1)
          }
          .width('100%')
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      // Horizontal lines
      Row({ space: 0 }) {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Column() {
            Divider()
              .vertical(true)
              .strokeWidth(1)
              .color(AppTokens.Colors.surfaceVariant)
              .layoutWeight(1)
          }
          .height('100%')
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { AssetMarker } from './AssetMarker';
import { MapMarker } from './MapMarker';
import { MapGridOverlay } from './MapGridOverlay';

@Entry
@Component
struct RootScreen {
  @State private categories: string[] = ['Warehouse', 'Device', 'Office'];
  @State private enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ];
  @State private assetName: string = '';
  @State private assetCode: string = '';
  @State private assetType: string = 'Device';
  @State private selectedId: number = -1;

  private colorScheme: Record<string, string> = {
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

  private toggleCategory(category: string): void {
    const index = this.enabledCats.indexOf(category);
    if (index > -1) {
      this.enabledCats.splice(index, 1);
    } else {
      this.enabledCats.push(category);
    }
  }

  private getSelectedMarkerName(): string {
    if (this.selectedId === -1) {
      return 'None';
    }
    const marker = this.markers.find((m: AssetMarker) => m.id === this.selectedId);
    return marker ? marker.name : 'None';
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = -1;
  }

  private saveAsset(): void {
    // Save asset logic
    console.log(`Saving asset: ${this.assetName}, ${this.assetCode}, ${this.assetType}`);
  }

  build() {
    Column({ space: 0 }) {
      // Top bar
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(this.colorScheme['onSurface'])
      }
      .width('100%')
      .height(86)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorScheme['surface'])

      // Main content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (category: string) => {
                Button({ type: ButtonType.Normal, stateEffect: true }) {
                  Text(category)
                    .fontSize(this.enabledCats.includes(category) ?
                      AppTokens.Typography.title.fontSize : AppTokens.Typography.body.fontSize)
                    .fontWeight(this.enabledCats.includes(category) ?
                      AppTokens.Typography.title.fontWeight : AppTokens.Typography.body.fontWeight)
                    .fontColor(this.enabledCats.includes(category) ?
                      this.colorScheme['onPrimary'] : this.colorScheme['onSurface'])
                    .padding({
                      left: AppTokens.Spacing.md,
                      right: AppTokens.Spacing.md,
                      top: AppTokens.Spacing.sm,
                      bottom: AppTokens.Spacing.sm
                    })
                    .backgroundColor(this.enabledCats.includes(category) ?
                      this.colorScheme['primary'] : this.colorScheme['surface'])
                    .borderRadius(AppTokens.Shapes.small)
                    .border({ width: 1, color: this.colorScheme['outline'] })
                }
                .onClick(() => {
                  this.toggleCategory(category);
                })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Asset details and map
          Row({ space: AppTokens.Spacing.lg }) {
            // Left column - asset inputs and selected card
            Column({ space: AppTokens.Spacing.md }) {
              // Asset Name input
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((value: string) => {
                  this.assetName = value;
                })
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontColor(this.colorScheme['onSurface'])
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .backgroundColor(this.colorScheme['surfaceVariant'])
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme['outline'] })

              // Asset Code input
              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((value: string) => {
                  this.assetCode = value;
                })
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontColor(this.colorScheme['onSurface'])
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .backgroundColor(this.colorScheme['surfaceVariant'])
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme['outline'] })

              // Asset Type input
              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((value: string) => {
                  this.assetType = value;
                })
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontColor(this.colorScheme['onSurface'])
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm,
                  bottom: AppTokens.Spacing.sm
                })
                .backgroundColor(this.colorScheme['surfaceVariant'])
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: this.colorScheme['outline'] })

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(this.colorScheme['onSurface'])

                Text(this.getSelectedMarkerName())
                  .fontSize(AppTokens.Typography.headline.fontSize)
                  .fontWeight(AppTokens.Typography.headline.fontWeight)
                  .fontColor(this.colorScheme['onSurface'])
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(this.colorScheme['surface'])
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: this.colorScheme['outline'] })
              .shadow({
                radius: AppTokens.Elevation.level1.radius,
                offsetY: AppTokens.Elevation.level1.dy,
                color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`
              })
            }
            .layoutWeight(1)

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)),
                (marker: AssetMarker) => {
                  MapMarker({
                    type: marker.type,
                    selected: this.selectedId === marker.id,
                    colorScheme: this.colorScheme,
                    onClick: () => {
                      this.selectedId = (this.selectedId === marker.id) ? -1 : marker.id;
                    }
                  })
                  .offset({
                    x: 300 * marker.x,
                    y: 333 * marker.y
                  })
                })
            }
            .width('100%')
            .height(360)
            .aspectRatio(0.9)
            .backgroundColor(this.colorScheme['surface'])
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: this.colorScheme['outline'] })
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .backgroundColor(this.colorScheme['background'])
      .scrollBar(BarState.Off)

      // Bottom bar
      Column({ space: 0 }) {
        Row({ space: AppTokens.Spacing.md }) {
          // Reset button
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Reset')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(this.colorScheme['onSurface'])
              .width('100%')
              .height(48)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.colorScheme['surfaceVariant'])
              .borderRadius(AppTokens.Shapes.medium)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.resetForm();
          })

          // Save Asset button
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Save Asset')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(this.colorScheme['onPrimary'])
              .width('100%')
              .height(48)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.colorScheme['primary'])
              .borderRadius(AppTokens.Shapes.medium)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.saveAsset();
          })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(this.colorScheme['surface'])
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          offsetY: -AppTokens.Elevation.level2.dy,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme['background'])
  }
}