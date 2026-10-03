// Build configuration: ohpm install @ohos/arkui

import { Length, ResourceColor, FlexAlign, ItemAlign, BorderRadiuses } from '@ohos.arkui';

const NAME = "063*LiveShop*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Modern Blue";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#FF1E3A8A",
    secondary: "#FF3B82F6",
    tertiary: "#FF60A5FA",
    background: "#FFF5F8FF",
    surface: "#FFFFFFFF",
    surfaceVariant: "#FFE8EEFA",
    outline: "#FFCBD5E1",
    success: "#FF22C55E",
    warning: "#FFF59E0B",
    error: "#FFEF4444",
    onPrimary: "#FFFFFFFF",
    onSecondary: "#FFFFFFFF",
    onTertiary: "#FF0B1220",
    onBackground: "#FF0B1220",
    onSurface: "#FF0B1220",
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
  static ElevationMapping = {
    level1: 2,
    level2: 6,
    level3: 10,
  };
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" },
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main Content
      Column() {
        // Header
        Text("Live Shop Events")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })
          .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

        // List
        Scroll() {
          Column() {
            ForEach(this.liveList, (item: LiveItem) => {
              Column() {
                // Image Placeholder
                Column()
                  .width('100%')
                  .height(160)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(AppTokens.Shapes.medium)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Text(item.title)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Text(`${item.viewers} viewers`)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Row() {
                  Text(item.price)
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary);

                  Button("Join Live", { type: ButtonType.Normal })
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.medium)
                    .height(36)
                    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(ItemAlign.Center);
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.ElevationMapping.level1, color: '#33000000', offsetX: 0, offsetY: 2 })
              .margin({ bottom: AppTokens.Spacing.md });
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: 96 });
        }
        .layoutWeight(1)
        .align(Alignment.Top);
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      });

      // Floating Action Button
      Button("+", { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .position({ x: '85%', y: '85%' })
        .shadow({ radius: 8, color: '#66000000', offsetX: 0, offsetY: 4 });

      // Bottom App Bar
      Row() {
        Text("Home")
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.primary);
        Text("Live")
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
        Text("Cart")
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
        Text("Profile")
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(ItemAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline, side: BorderSide.Top })
      .position({ x: 0, y: '100%' })
      .markAnchor({ x: 0, y: '100%' });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}