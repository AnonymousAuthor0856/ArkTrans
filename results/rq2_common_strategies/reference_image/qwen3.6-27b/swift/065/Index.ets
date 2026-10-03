// src/main/ets/components/AppTokens.ets
/**
 * ArkTS equivalent of the Kotlin/Swift AppTokens object.
 * Defines colors, typography, shapes, and spacing used throughout the application.
 */

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
  } as const;

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  } as const;

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.SemiBold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as const;

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  } as const;

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 }
  } as const;
}

// src/main/ets/model/AssetMarker.ts
/**
 * Data model for an asset marker on the map.
 */
export interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number; // Relative X position (0-1)
  y: number; // Relative Y position (0-1)
}

// src/main/ets/components/MapGridOverlay.ets
import { AppTokens } from './AppTokens';

@Component
export struct MapGridOverlay {
  build() {
    Stack() {
      // Vertical lines
      Column() {
        ForEach(7, () => {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)

      // Horizontal lines
      Row() {
        ForEach(7, () => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// src/main/ets/components/MapMarker.ets
import { AppTokens } from './AppTokens';

@Component
export struct MapMarker {
  @Prop type: string;
  @Prop selected: boolean;
  private onClick: () => void;

  constructor(type: string, selected: boolean, onClick: () => void) {
    this.type = type;
    this.selected = selected;
    this.onClick = onClick;
  }

  getMarkerColor(): string {
    switch (this.type) {
      case 'Warehouse': return AppTokens.Colors.tertiary;
      case 'Device': return AppTokens.Colors.secondary;
      default: return AppTokens.Colors.primary;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // The dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getMarkerColor())
        .border({ width: 2, color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface })

      // The label card
      Button(this.type)
        .type(ButtonType.Normal)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .shadow({ radius: AppTokens.Elevation.level1.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`, offsetY: AppTokens.Elevation.level1.dy })
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {
          this.onClick();
        })
        .offset({ x: 18, y: -4 })
    }
  }
}

// src/main/ets/pages/RootScreen.ets
import { AppTokens } from '../components/AppTokens';
import { AssetMarker } from '../model/AssetMarker';
import { MapGridOverlay } from '../components/MapGridOverlay';
import { MapMarker } from '../components/MapMarker';

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

  aboutToAppear() {
    // Initialization if needed
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(86)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (category: string) => {
                let isOn = this.enabledCats.includes(category);
                Button(category) {
                  Text(category)
                    .fontColor(isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .fontSize(isOn ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                    .fontWeight(isOn ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                }
                .type(ButtonType.Normal)
                .backgroundColor(isOn ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .onClick(() => {
                  if (isOn) {
                    this.enabledCats = this.enabledCats.filter(c => c !== category);
                  } else {
                    this.enabledCats.push(category);
                  }
                })
              }, (item: string) => item)
            }
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .barState(BarState.Off)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Content Row (Inputs + Map)
          Row({ space: AppTokens.Spacing.lg }) {
            // Left Column: Inputs & Selected Card
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name' })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => { this.assetName = value; })

              TextInput({ placeholder: 'Asset Code' })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => { this.assetCode = value; })

              TextInput({ text: this.assetType })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => { this.assetType = value; })

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                let selectedName = this.selectedId ? this.markers.find(m => m.id === this.selectedId)?.name : 'None';
                Text(selectedName ?? 'None')
                  .fontSize(AppTokens.Typography.headline.size)
                  .fontWeight(AppTokens.Typography.headline.weight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.Elevation.level1.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`, offsetY: AppTokens.Elevation.level1.dy })
              .border({ width: 1, color: AppTokens.Colors.outline })
            }
            .layoutWeight(1)

            // Right Column: Map Area
            Stack() {
              MapGridOverlay()

              // Markers
              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: AssetMarker) => {
                MapMarker(marker.type, this.selectedId === marker.id, () => {
                  this.selectedId = (this.selectedId === marker.id) ? null : marker.id;
                })
                .position({
                  x: `${marker.x * 100}%`,
                  y: `${marker.y * 100}%`
                })
              }, (item: AssetMarker) => item.id.toString())
            }
            .width('100%')
            .minHeight(360)
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .layoutWeight(1)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .padding({ bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        // Shadow effect row
        Row()
          .height(0)
          .shadow({ radius: AppTokens.Elevation.level2.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`, offsetY: -AppTokens.Elevation.level2.dy })

        Row({ space: AppTokens.Spacing.md }) {
          Button('Reset') {
            Text('Reset')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = '';
            this.assetCode = '';
            this.assetType = 'Device';
            this.selectedId = null;
          })

          Button('Save Asset') {
            Text('Save Asset')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}