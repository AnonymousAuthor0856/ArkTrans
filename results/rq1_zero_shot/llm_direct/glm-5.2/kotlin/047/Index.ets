// 061*GroupBuy*en
// UI_TYPE: ECommerce
// STYLE_THEME: Retro Flat
// LANG: en
// BASELINE_SIZE: 720x1280

import { ArkTSUtils } from '@arkts/utils';

interface Pin {
  x: number;
  y: number;
  label: string;
}

class AppTokens {
  static readonly Colors = {
    primary: '#FF8C00',
    secondary: '#FFC107',
    tertiary: '#FFE082',
    background: '#FFF8E1',
    surface: '#FFFFFF',
    surfaceVariant: '#FFECB3',
    outline: '#D7CCC8',
    success: '#4CAF50',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#3E2723',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  };
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' },
  ];

  addPin() {
    const newPin: Pin = {
      x: ArkTSUtils.random(100, 550),
      y: ArkTSUtils.random(150, 450),
      label: 'New',
    };
    this.pins.push(newPin);
  }

  clearPins() {
    this.pins = [];
  }

  build() {
    Column() {
      // Title
      Text('Retro Group Buy')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg });

      // Live Deals Map Card
      Column() {
        Text('Live Deals Map')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.md });

        // Map Box
        Stack() {
          // Canvas equivalent
          Column() {
            ForEach(this.pins, (pin: Pin) => {
              // Simulating Canvas drawCircle with absolute positioned dots
              // Note: ArkUI doesn't have a direct Canvas Composable like Jetpack Compose.
              // Using Stack with absolute positioning for visualization.
              Circle({ width: 28, height: 28 })
                .fill(AppTokens.Colors.primary)
                .position({ x: pin.x, y: pin.y });
            })
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(220)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .padding(8);
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy,
      })
      .margin({ bottom: AppTokens.Spacing.sm });

      // Action Buttons Row
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Button('Add Group')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => this.addPin())
          .margin({ right: AppTokens.Spacing.md });

        Button('Clear')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => this.clearPins());
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.lg });

      // Active Groups Card
      Column() {
        Text('Active Groups')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.sm });

        ForEach(this.pins, (pin: Pin) => {
          Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
            Text(pin.label)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface);

            Circle({ width: 14, height: 14 })
              .fill(AppTokens.Colors.primary);
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.sm });
        });
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level1.dy,
      });
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background);
  }
}