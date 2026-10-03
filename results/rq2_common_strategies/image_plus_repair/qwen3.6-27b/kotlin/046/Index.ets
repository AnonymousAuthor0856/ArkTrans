import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// Define color constants matching AppTokens.Colors
interface Colors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const COLORS: Colors = {
  primary: '#7B61FF',
  secondary: '#26C6DA',
  tertiary: '#FF8A80',
  background: '#F5F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F2F8',
  outline: '#E0E3EB',
  onPrimary: '#FFFFFF',
  onSecondary: '#0B1220',
  onTertiary: '#0B1220',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
};

// Define data models
interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPin {
  x: number; // Percentage for responsiveness
  y: number; // Percentage for responsiveness
  label: string;
  tint: string;
}

@Entry
@Component
struct RootScreen {
  @State coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: COLORS.primary, colorB: COLORS.secondary },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: COLORS.secondary, colorB: COLORS.tertiary },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: COLORS.tertiary, colorB: COLORS.primary },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: COLORS.secondary, colorB: COLORS.primary }
  ];

  @State pins: MapPin[] = [
    { x: 25, y: 60, label: "A", tint: COLORS.primary },
    { x: 85, y: 85, label: "C", tint: COLORS.tertiary }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 20, height: 20 })
          .fill(COLORS.onSurface)
        
        Text("Coupon Pack")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Circle({ width: 20, height: 20 })
          .fill(COLORS.primary)
      }
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .backgroundColor(COLORS.surface)

      // Main Content Area with Gradient Background
      Column() {
        // Nearby Packs Section
        Text("Nearby Packs")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .margin({ top: 16, bottom: 12 })

        // Map Box
        Column() {
          // Simulated Map Canvas
          Stack() {
            Rect()
              .width('100%')
              .height('100%')
              .fill(COLORS.surfaceVariant)
            
            // Draw Pins
            ForEach(this.pins, (pin: MapPin) => {
              Circle({ width: 14, height: 14 })
                .fill(pin.tint)
                .position({ left: `${pin.x}%`, top: `${pin.y}%` })
            })
          }
          .width('100%')
          .aspectRatio(16 / 9)
          
          // Legend Overlay
          Row() {
            this.buildLegendItem(COLORS.primary, "A")
            this.buildLegendItem(COLORS.secondary, "B")
            this.buildLegendItem(COLORS.tertiary, "C")
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.End)
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .backgroundColor('#E6FFFFFF') // 90% opacity white
          .borderRadius(8)
          .position({ right: 0, top: 0 })
        }
        .width('100%')
        .backgroundColor(COLORS.surface)
        .borderRadius(20)
        .padding(12)
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: 6 })

        // Your Coupon Packs Section
        Text("Your Coupon Packs")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .margin({ top: 24, bottom: 12 })

        // Horizontal Scroll List
        Scroll() {
          Flex({ wrap: FlexWrap.NoWrap, direction: FlexDirection.Row }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.buildCouponCard(coupon)
            }, (item: Coupon) => item.id.toString())
          }
          .width('100%')
          .gap(16)
        }
        .width('100%')
        .height(160)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Column()
          .height(16)

        // Bottom Buttons
        Row() {
          Button("My Coupons")
            .type(ButtonType.Normal)
            .backgroundColor(COLORS.secondary)
            .fontColor(COLORS.onSecondary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .borderRadius(20)
            .layoutWeight(1)
            .margin({ right: 8 })
          
          Button("Explore More")
            .type(ButtonType.Normal)
            .backgroundColor(COLORS.primary)
            .fontColor(COLORS.onPrimary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .borderRadius(20)
            .layoutWeight(1)
            .margin({ left: 8 })
        }
        .width('100%')
        .margin({ bottom: 24 })

      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [COLORS.primary, 0.25],
          [COLORS.background, 0.5],
          [COLORS.secondary, 0.25]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  buildLegendItem(color: string, label: string) {
    Row() {
      Circle({ width: 10, height: 10 })
        .fill(color)
      
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
        .margin({ left: 4 })
    }
    .margin({ right: 8 })
  }

  @Builder
  buildCouponCard(coupon: Coupon) {
    Column() {
      Column() {
        Row() {
          Circle({ width: 14, height: 14 })
            .fill(COLORS.primary)
          
          Text(coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.onSurface)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .margin({ top: 8 })

        Button("Redeem")
          .type(ButtonType.Normal)
          .backgroundColor(COLORS.primary)
          .fontColor(COLORS.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(40)
          .borderRadius(14)
          .margin({ top: 12 })
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
    }
    .width(200)
    .height(140)
    .borderRadius(20)
    .backgroundColor(COLORS.surface)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetY: 6 })
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [
        [coupon.colorA, 0.18],
        [coupon.colorB, 0.18]
      ]
    })
    .margin({ right: 16 })
  }
}