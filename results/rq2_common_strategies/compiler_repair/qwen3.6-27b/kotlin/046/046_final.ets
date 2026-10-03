import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppTokenColors {
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

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokenFontSizes {
  display: number;
  headline: number;
  title: number;
  body: number;
  label: number;
}

interface AppTokensConfig {
  Colors: AppTokenColors;
  Spacing: AppTokenSpacing;
  Shapes: AppTokenShapes;
  FontSizes: AppTokenFontSizes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
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
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Shapes: {
    small: 8,
    medium: 14,
    large: 20
  },
  FontSizes: {
    display: 28,
    headline: 20,
    title: 16,
    body: 14,
    label: 12
  }
}

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;
}

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

  private ctx: CanvasRenderingContext2D | null = null;

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Hamburger)
        Row() {
          Circle({ width: 20, height: 20 })
            .fill(AppTokens.Colors.onSurface)
        }
        .onClick(() => {})

        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Text("")
        }.layoutWeight(1)

        Text("Coupon Pack")
          .fontSize(AppTokens.FontSizes.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Text("")
        }.layoutWeight(1)

        // Action Icon
        Row() {
          Circle({ width: 20, height: 20 })
            .fill(AppTokens.Colors.primary)
        }
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })

      // Main Content Area
      Scroll() {
        Column() {
          // Section: Nearby Packs
          Text("Nearby Packs")
            .fontSize(AppTokens.FontSizes.headline)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          // Map Container
          Row() {
            // Canvas for Map Pins
            Canvas(this.ctx)
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .onReady(() => {
                this.drawMapPins();
              })
            
            // Legend Overlay
            Row() {
              this.MapLegendItem(AppTokens.Colors.primary, "A")
              this.MapLegendItem(AppTokens.Colors.secondary, "B")
              this.MapLegendItem(AppTokens.Colors.tertiary, "C")
            }
            .position({ x: 'auto', y: AppTokens.Spacing.md })
            .align(Alignment.TopEnd)
            .backgroundColor(Color.White)
            .opacity(0.9)
            .borderRadius(AppTokens.Shapes.small)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .margin({ right: AppTokens.Spacing.md })
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .padding(AppTokens.Spacing.md)
          .shadow({ radius: 10, color: '#0000001A', offsetY: 6 })

          // Section: Your Coupon Packs
          Text("Your Coupon Packs")
            .fontSize(AppTokens.FontSizes.headline)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          // Horizontal List of Coupons
          List({ space: AppTokens.Spacing.lg }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              ListItem() {
                this.CouponCard(coupon)
              }
            })
          }
          .width('100%')
          .layoutWeight(0) // Allow it to take natural height within scroll
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)

          // Bottom Actions
          Row() {
            Button("My Coupons")
              .width('45%')
              .height(52)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .borderRadius(AppTokens.Shapes.large)
              .fontSize(AppTokens.FontSizes.title)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})

            Button("Explore More")
              .width('45%')
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .borderRadius(AppTokens.Shapes.large)
              .fontSize(AppTokens.FontSizes.title)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.25],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.25]
      ]
    })
  }

  drawMapPins() {
    if (!this.ctx) {
      return;
    }
    
    const canvasWidth = 375; // Approximate width for calculation context if needed
    
    this.pins.forEach(pin => {
      this.ctx!.beginPath();
      this.ctx!.arc(pin.x, pin.y, 14, 0, 2 * Math.PI);
      this.ctx!.fillStyle = pin.tint;
      this.ctx!.fill();
    });
  }

  @Builder
  MapLegendItem(color: string, label: string) {
    Row() {
      Circle({ width: 10, height: 10 })
        .fill(color)
      
      Text(label)
        .fontSize(AppTokens.FontSizes.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ left: AppTokens.Spacing.xs })
    }
    .margin({ right: AppTokens.Spacing.sm })
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Column() {
        Row() {
          Circle({ width: 14, height: 14 })
            .fill(AppTokens.Colors.primary)
          
          Text(coupon.title)
            .fontSize(AppTokens.FontSizes.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .margin({ bottom: AppTokens.Spacing.sm })

        Text(coupon.value)
          .fontSize(AppTokens.FontSizes.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.sm })

        Button("Redeem")
          .width('100%')
          .height(40)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .fontSize(AppTokens.FontSizes.label)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width(200)
    .height(140)
    .linearGradient({
      angle: 0,
      colors: [
        [coupon.colorA, 0.18],
        [coupon.colorB, 0.18]
      ]
    })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 10, color: '#00000029', offsetY: 6 })
  }
}