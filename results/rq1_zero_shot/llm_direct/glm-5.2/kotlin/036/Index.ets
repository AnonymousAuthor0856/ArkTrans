// Build configuration: ohpm
// dependencies:
//   @ohos/arkui: 1.0.0

import { 
  Length, 
  CommonAttribute, 
  Button, 
  Text, 
  TextInput, 
  Toggle, 
  Scroll, 
  Column, 
  Row, 
  Stack, 
  ForEach, 
  Divider, 
  Progress, 
  Blank, 
  Flex, 
  GridContainer, 
  GridItem, 
  GridCol, 
  Image, 
  Swiper, 
  List, 
  ListItem, 
  Tabs, 
  TabContent, 
  Navigation, 
  Router, 
  Ability, 
  UI, 
  Component, 
  CustomComponent, 
  CustomDialog, 
  @Component, 
  @Entry, 
  @State, 
  @Prop, 
  @Link, 
  @Provide, 
  @Consume, 
  @Watch, 
  @Builder, 
  @BuilderParam, 
  @Styles, 
  @Extend, 
  @StorageLink, 
  @StorageProp, 
  @LocalStorageLink, 
  @LocalStorageProp, 
  @Persistent, 
  @Observed, 
  @ObjectLink, 
  @Style, 
  @Require 
} from '@ohos/arkui';

interface AppColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface AppElevationMapping {
  level1: AppShadowSpec;
  level2: AppShadowSpec;
}

interface AppTypographyTokens {
  display: TextStyle;
  title: TextStyle;
  body: TextStyle;
  label: TextStyle;
}

interface AppTokens {
  Colors: AppColors;
  TypographyTokens: AppTypographyTokens;
  Shapes: AppShapes;
  Spacing: AppSpacing;
  ElevationMapping: AppElevationMapping;
}

interface TextStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

const AppTokens: AppTokens = {
  Colors: {
    primary: 0xFFFFA8A8,
    secondary: 0xFFFFE1A8,
    tertiary: 0xFFA8FFE1,
    background: 0xFFFFFCF5,
    surface: 0xFFFFFFFF,
    surfaceVariant: 0xFFF7F7F7,
    outline: 0xFFE2E2E2,
    success: 0xFF22C55E,
    warning: 0xFFF59E0B,
    error: 0xFFEF4444,
    onPrimary: 0xFF1E1E1E,
    onSecondary: 0xFF1E1E1E,
    onTertiary: 0xFF1E1E1E,
    onBackground: 0xFF1E1E1E,
    onSurface: 0xFF1E1E1E,
  },
  TypographyTokens: {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 20,
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
  ElevationMapping: {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  },
};

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = "BTC";
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ["BTC", "ETH", "SOL", "ADA"];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Crypto Market")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .padding({ top: 12, bottom: 12, left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.background);

      // Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.chips, (chip: string) => {
              Text(chip)
                .fontSize(14)
                .fontColor(AppTokens.Colors.onPrimary)
                .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                .backgroundColor(this.selectedChip === chip ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .onClick(() => {
                  this.selectedChip = chip;
                });
            }, (chip: string) => chip);
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg });

          // Chart Surface
          Column() {
            // Canvas equivalent using a custom drawing component or a simplified chart representation
            // For simplicity, we'll use a placeholder for the chart drawing
            Column() {
              Text("Chart Area")
                .fontSize(16)
                .fontColor(AppTokens.Colors.outline)
                .textAlign(TextAlign.Center)
                .layoutWeight(1)
                .width('100%')
                .height('100%')
                .justifyContent(FlexAlign.Center);
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .padding(AppTokens.Spacing.lg);
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy,
          })
          .margin({ bottom: AppTokens.Spacing.lg });

          // Price Variation Text
          Text("Price Variation")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.sm });

          // Linear Progress Indicator
          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .value(this.progress * 100)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(8)
            .borderRadius(4)
            .margin({ bottom: AppTokens.Spacing.lg });

          // Auto Update Row
          Row() {
            Text("Auto Update")
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .layoutWeight(1);

            Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
              .selectedColor(AppTokens.Colors.secondary)
              .onChange((isOn: boolean) => {
                this.isAutoUpdate = isOn;
              });
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center);
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary, 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.tertiary, 1.0],
          ],
        });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}