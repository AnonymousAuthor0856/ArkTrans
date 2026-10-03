// CouponPacken.ets
import { display } from '@kit.ArkUI';

// AppTokens - Design tokens
class AppColors {
  static readonly primary: string = '#7B61FF';
  static readonly secondary: string = '#26C6DA';
  static readonly tertiary: string = '#FF8A80';
  static readonly background: string = '#F5F7FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0F2F8';
  static readonly outline: string = '#E0E3EB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0B1220';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

// Data models
class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.colorA = colorA;
    this.colorB = colorB;
  }
}

class MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}

@Entry
@Component
struct CouponPackenPage {
  @State coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppColors.primary, AppColors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppColors.secondary, AppColors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppColors.tertiary, AppColors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppColors.secondary, AppColors.primary)
  ];

  @State pins: MapPin[] = [
    new MapPin(140, 220, 'A', AppColors.primary),
    new MapPin(320, 400, 'B', AppColors.secondary),
    new MapPin(520, 300, 'C', AppColors.tertiary)
  ];

  @Builder
  TopBar() {
    Row() {
      // Navigation icon (left)
      Row() {
        Circle()
          .width(20)
          .height(20)
          .fill(AppColors.onSurface)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        // Navigation action
      })

      // Title
      Text('Coupon Pack')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // Action icon (right)
      Row() {
        Circle()
          .width(20)
          .height(20)
          .fill(AppColors.primary)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        // Action
      })
    }
    .width('100%')
    .height(56)
    .padding({ left: 8, right: 8 })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  MapLegend() {
    Row({ space: 8 }) {
      Circle()
        .width(10)
        .height(10)
        .fill(AppColors.primary)
      Text('A')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Circle()
        .width(10)
        .height(10)
        .fill(AppColors.secondary)
      Text('B')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Circle()
        .width(10)
        .height(10)
        .fill(AppColors.tertiary)
      Text('C')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    .backgroundColor('#E6FFFFFF')
    .borderRadius(8)
  }

  @Builder
  MapArea() {
    Stack() {
      // Map background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(20)

      // Map pins
      ForEach(this.pins, (pin: MapPin) => {
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(pin.tint)
            .opacity(0.8)
          Text(pin.label)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .position({ x: pin.x - 14, y: pin.y - 14 })
      })

      // Legend overlay
      Row() {
        this.MapLegend()
      }
      .position({ x: 'auto', y: 8 })
      .align(Alignment.TopEnd)
      .margin({ right: 8 })
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .padding(12)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Circle()
          .width(14)
          .height(14)
          .fill(AppColors.primary)
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Button('Redeem')
        .width('100%')
        .height(40)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(14)
        .onClick(() => {
          // Redeem action
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  CouponCardContainer(coupon: Coupon) {
    Stack() {
      // Gradient background
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [[coupon.colorA, 0.18], [coupon.colorB, 0.18]]
        })
        .borderRadius(20)

      this.CouponCard(coupon)
    }
    .width(200)
    .height(140)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({
      radius: 10,
      color: '#29000000',
      offsetX: 0,
      offsetY: 6
    })
  }

  build() {
    Column() {
      // Top bar
      this.TopBar()

      // Main content with gradient background
      Column({ space: 16 }) {
        // "Nearby Packs" section
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        // Map area
        this.MapArea()

        // "Your Coupon Packs" section
        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        // Horizontal scrollable coupon cards
        Scroll() {
          Row({ space: 16 }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCardContainer(coupon)
            })
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        // Spacer
        Row()
          .height(8)

        // Bottom action buttons
        Row({ space: 12 }) {
          Button('My Coupons')
            .layoutWeight(1)
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(20)
            .onClick(() => {
              // My Coupons action
            })

          Button('Explore More')
            .layoutWeight(1)
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(20)
            .onClick(() => {
              // Explore More action
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.secondary, 0.25], [AppColors.background, 1.0], [AppColors.primary, 0.25]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}