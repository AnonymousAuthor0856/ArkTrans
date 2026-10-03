// CouponPack.ets
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

// --- Design Tokens ---
class AppTokens {
  static readonly Colors = {
    primary: '#7B61FF',
    secondary: '#26C6DA',
    tertiary: '#FF8A80',
    background: '#F5F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F2F8',
    outline: '#E0E3EB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0B1220',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };
  
  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };
  
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

// --- Models ---
interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: ResourceColor;
  colorB: ResourceColor;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: ResourceColor;
}

// --- State Management ---
@Entry
@Component
struct RootScreen {
  @State coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary }
  ];
  
  @State pins: MapPin[] = [
    { x: 140, y: 220, label: "A", tint: AppTokens.Colors.primary },
    { x: 320, y: 400, label: "B", tint: AppTokens.Colors.secondary },
    { x: 520, y: 300, label: "C", tint: AppTokens.Colors.tertiary }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Circle({ width: 20, height: 20 })
          .fill(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.lg });
          
        // Title
        Text("Coupon Pack")
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
          
        // Action Icon
        Circle({ width: 20, height: 20 })
          .fill(AppTokens.Colors.primary)
          .margin({ right: AppTokens.Spacing.lg });
      }
      .width('100%')
      .height(56)
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 4, color: '#12000000', offsetX: 0, offsetY: 2 });

      // Main Content
      Scroll() {
        Column() {
          // Background Gradient Layer
          Column()
            .linearGradient({
              angle: 180,
              colors: [
                [AppTokens.Colors.secondary, 0.25],
                [AppTokens.Colors.background, 0.5],
                [AppTokens.Colors.primary, 0.25]
              ]
            })
            .width('100%')
            .height('100%')
            .position({ x: 0, y: 0 });

          // Content Layer
          Column() {
            // Nearby Packs Section
            Text("Nearby Packs")
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.lg });

            // Map Box
            Stack() {
              // Map Canvas
              Column() {
                // Draw pins
                ForEach(this.pins, (pin: MapPin) => {
                  Circle({ width: 28, height: 28 })
                    .fill(pin.tint)
                    .position({ x: pin.x, y: pin.y });
                });
              }
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(20);

              // Legend
              Row() {
                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.primary);
                Text("A")
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.sm });
                  
                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.secondary);
                Text("B")
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.sm });
                  
                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.tertiary);
                Text("C")
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ left: AppTokens.Spacing.xs });
              }
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(8)
              .opacity(0.9)
              .position({ x: '100%', y: 0 })
              .markAnchor({ x: '100%', y: 0 })
              .margin({ top: AppTokens.Spacing.md, right: AppTokens.Spacing.md });
            }
            .width('100%')
            .aspectRatio(1.7)
            .clip(true)
            .borderRadius(20)
            .margin({ bottom: AppTokens.Spacing.xxl });

            // Your Coupon Packs Section
            Text("Your Coupon Packs")
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.lg });

            // Coupon List (Horizontal Scroll)
            Scroll() {
              Row() {
                ForEach(this.coupons, (coupon: Coupon) => {
                  Column() {
                    // Card Content
                    Column() {
                      Row() {
                        Circle({ width: 14, height: 14 }).fill(AppTokens.Colors.primary);
                        Text(coupon.title)
                          .fontSize(AppTokens.Typography.title.fontSize)
                          .fontWeight(AppTokens.Typography.title.fontWeight)
                          .fontColor(AppTokens.Colors.onSurface)
                          .margin({ left: AppTokens.Spacing.sm });
                      }
                      .margin({ bottom: AppTokens.Spacing.sm });

                      Text(coupon.value)
                        .fontSize(AppTokens.Typography.display.fontSize)
                        .fontWeight(AppTokens.Typography.display.fontWeight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .margin({ bottom: AppTokens.Spacing.md });

                      Button("Redeem")
                        .width('100%')
                        .height(40)
                        .backgroundColor(AppTokens.Colors.primary)
                        .fontColor(AppTokens.Colors.onPrimary)
                        .fontSize(AppTokens.Typography.label.fontSize)
                        .borderRadius(14);
                    }
                    .width(200)
                    .height(140)
                    .padding(AppTokens.Spacing.lg)
                    .linearGradient({
                      angle: 90,
                      colors: [
                        [coupon.colorA, 0.18],
                        [coupon.colorB, 0.18]
                      ]
                    })
                    .backgroundColor(AppTokens.Colors.surface)
                    .borderRadius(20)
                    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
                    .margin({ right: AppTokens.Spacing.lg });
                });
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.xxl });

            // Bottom Action Buttons
            Row() {
              Button("My Coupons")
                .layoutWeight(1)
                .height(52)
                .backgroundColor(AppTokens.Colors.secondary)
                .fontColor(AppTokens.Colors.onSecondary)
                .fontSize(AppTokens.Typography.title.fontSize)
                .borderRadius(20)
                .margin({ right: AppTokens.Spacing.md / 2 });

              Button("Explore More")
                .layoutWeight(1)
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.Typography.title.fontSize)
                .borderRadius(20)
                .margin({ left: AppTokens.Spacing.md / 2 });
            }
            .width('100%');
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg);
        }
        .width('100%')
        .height('100%');
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%');
  }
}