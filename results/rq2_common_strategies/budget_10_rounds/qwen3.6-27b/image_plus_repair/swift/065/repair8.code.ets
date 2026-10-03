// src/main/ets/components/AppTokens.ets
/**
 * ArkTS equivalent of the Kotlin/Swift AppTokens object.
 * Defines colors, typography, shapes, and spacing constants used throughout the app.
 */

export interface ColorToken {
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

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

export interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

export interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

export interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
  level4: ElevationLevel;
  level5: ElevationLevel;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
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

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapeToken = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing: SpacingToken = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  };

  static readonly ElevationMapping: ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
    level4: { radius: 16, dy: 8, opacity: 0.18 },
    level5: { radius: 20, dy: 10, opacity: 0.20 }
  };
}

// src/main/ets/models/AssetMarker.ts
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
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant);
        });
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)

      // Horizontal lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant);
        });
      }
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
  private onClickCallback: () => void = () => {};

  aboutToAppear(): void {
    // Initialization if needed
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
      Circle()
        .fill(this.getMarkerColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface
        });

      Button({ type: ButtonType.Capsule, stateEffect: true })
        .onClick(() => {
          this.onClickCallback();
        })
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: Color.Black.withOpacity(AppTokens.ElevationMapping.level1.opacity),
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
        .border({
          width: 1,
          color: AppTokens.Colors.outline
        })
        .position({ x: 18, y: -4 });
        
      Text(this.type)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .position({ x: 18, y: -4 })
        .textAlign(TextAlign.Center)
    }
  }
}

// src/main/ets/pages/RootScreen.ets
import { AppTokens } from '../components/AppTokens';
import { AssetMarker } from '../models/AssetMarker';
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

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
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
                Button({ type: ButtonType.Capsule, stateEffect: true })
                  .onClick(() => {
                    if (isOn) {
                      this.enabledCats = this.enabledCats.filter(c => c !== category);
                    } else {
                      this.enabledCats.push(category);
                    }
                  })
                  .backgroundColor(isOn ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline
                  })
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });
                
                Text(category)
                  .fontSize(isOn ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                  .fontWeight(isOn ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                  .fontColor(isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }, (item: string) => item);
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .edgeEffect(EdgeEffect.Spring)
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Asset Details and Map
          Row({ space: AppTokens.Spacing.lg }) {
            // Left Column: Inputs and Selected Card
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name' })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => {
                  this.assetName = value;
                });

              TextInput({ placeholder: 'Asset Code' })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => {
                  this.assetCode = value;
                });

              TextInput({ text: this.assetType })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => {
                  this.assetType = value;
                });

              // Selected Asset Card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(AppTokens.Colors.onSurface);

                Text(this.selectedId !== null ? this.markers.find(m => m.id === this.selectedId)?.name ?? 'None' : 'None')
                  .fontSize(AppTokens.TypographyTokens.headline.size)
                  .fontWeight(AppTokens.TypographyTokens.headline.weight)
                  .fontColor(AppTokens.Colors.onSurface);
              }
              .alignItems(HorizontalAlign.Start)
              .padding(AppTokens.Spacing.lg)
              .width('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: Color.Black.withOpacity(AppTokens.ElevationMapping.level1.opacity),
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
              .border({
                width: 1,
                color: AppTokens.Colors.outline
              });
            }
            .layoutWeight(1)

            // Right Column: Map Area
            Stack() {
              MapGridOverlay();

              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: AssetMarker) => {
                MapMarker({
                  type: marker.type,
                  selected: this.selectedId === marker.id,
                  onClickCallback: () => {
                    this.selectedId = this.selectedId === marker.id ? null : marker.id;
                  }
                })
                .position({
                  x: `${marker.x * 100}%`,
                  y: `${marker.y * 100}%`
                });
              }, (item: AssetMarker) => item.id.toString());
            }
            .height(360)
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline
            })
            .layoutWeight(1);
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
          Button('Reset', { type: ButtonType.Capsule, stateEffect: true })
            .onClick(() => {
              this.assetName = '';
              this.assetCode = '';
              this.assetType = 'Device';
              this.selectedId = null;
            })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1);

          Button('Save Asset', { type: ButtonType.Capsule, stateEffect: true })
            .onClick(() => {
              // Save logic here
            })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1);
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: Color.Black.withOpacity(AppTokens.ElevationMapping.level2.opacity),
        offsetY: -AppTokens.ElevationMapping.level2.dy
      });
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%');
  }
}