import promptAction from '@ohos.promptAction';

// MARK: - AppTokens

class Colors {
  primary: ResourceColor = '#FF7B61FF';
  secondary: ResourceColor = '#FF26C6DA';
  tertiary: ResourceColor = '#FFFF8A80';
  background: ResourceColor = '#FFF5F7FF';
  surface: ResourceColor = '#FFFFFFFF';
  surfaceVariant: ResourceColor = '#FFF0F2F8';
  outline: ResourceColor = '#FFE0E3EB';
  success: ResourceColor = '#FF22C55E';
  warning: ResourceColor = '#FFF59E0B';
  error: ResourceColor = '#FFEF4444';
  onPrimary: ResourceColor = '#FFFFFFFF';
  onSecondary: ResourceColor = '#FF0B1220';
  onTertiary: ResourceColor = '#FF0B1220';
  onBackground: ResourceColor = '#FF0B1220';
  onSurface: ResourceColor = '#FF0B1220';
}

class Shapes {
  smallCornerRadius: number = 8;
  mediumCornerRadius: number = 14;
  largeCornerRadius: number = 20;
}

class Spacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppTokens {
  static colors: Colors = new Colors();
  static shapes: Shapes = new Shapes();
  static spacing: Spacing = new Spacing();
}

// MARK: - Data Models

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: ResourceColor;
  colorB: ResourceColor;
}

interface MapPin {
  id: string;
  x: number;
  y: number;
  label: string;
  tint: ResourceColor;
}

// MARK: - Coupon Card Component

@Component
struct CouponCard {
  @Prop coupon: Coupon;

  build() {
    Stack() {
      Column() {
        Row() {
          Circle({ width: 14, height: 14 })
            .fill(AppTokens.colors.primary)
          Text(this.coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.colors.onSurface)
            .margin({ left: AppTokens.spacing.sm })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Text(this.coupon.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.colors.onSurface)
          .margin({ top: AppTokens.spacing.sm })

        Button('Redeem')
          .width('100%')
          .height(40)
          .backgroundColor(AppTokens.colors.primary)
          .fontColor(AppTokens.colors.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.shapes.mediumCornerRadius)
          .margin({ top: AppTokens.spacing.sm })
          .onClick(() => {
            promptAction.showToast({ message: 'Redeemed: ' + this.coupon.title });
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        colors: [[this.coupon.colorA, 0.18], [this.coupon.colorB, 0.18]],
        direction: GradientDirection.Right
      })
      .borderRadius(AppTokens.shapes.largeCornerRadius)
    }
    .width(200)
    .height(140)
    .backgroundColor(AppTokens.colors.surface)
    .borderRadius(AppTokens.shapes.largeCornerRadius)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetY: 6
    })
  }
}

// MARK: - Map Card Component

@Component
struct MapCard {
  @Prop pins: MapPin[];

  build() {
    Stack() {
      // Map background with surface variant
      Stack() {
        // Draw pins as circles positioned absolutely
        ForEach(this.pins, (pin: MapPin) => {
          Circle({ width: 28, height: 28 })
            .fill(pin.tint)
            .position({ x: pin.x, y: pin.y })
        }, (pin: MapPin) => pin.id)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.colors.surfaceVariant)
      .margin(AppTokens.spacing.md)

      // Legend at top right
      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.colors.primary)
        Text('A')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.colors.onSurface)
          .margin({ left: 4 })

        Circle({ width: 10, height: 10 })
          .fill(AppTokens.colors.secondary)
          .margin({ left: AppTokens.spacing.sm })
        Text('B')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.colors.onSurface)
          .margin({ left: 4 })

        Circle({ width: 10, height: 10 })
          .fill(AppTokens.colors.tertiary)
          .margin({ left: AppTokens.spacing.sm })
        Text('C')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.colors.onSurface)
          .margin({ left: 4 })
      }
      .padding({ left: AppTokens.spacing.md, right: AppTokens.spacing.md, top: AppTokens.spacing.xs, bottom: AppTokens.spacing.xs })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(AppTokens.shapes.smallCornerRadius)
      .margin(AppTokens.spacing.md)
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .backgroundColor(AppTokens.colors.surface)
    .borderRadius(AppTokens.shapes.largeCornerRadius)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetY: 6
    })
    .alignContent(Alignment.TopEnd)
  }
}

// MARK: - Root Screen

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: AppTokens.colors.primary, colorB: AppTokens.colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: AppTokens.colors.secondary, colorB: AppTokens.colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: AppTokens.colors.tertiary, colorB: AppTokens.colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: AppTokens.colors.secondary, colorB: AppTokens.colors.primary },
  ];

  @State pins: MapPin[] = [
    { id: 'A', x: 140, y: 220, label: 'A', tint: AppTokens.colors.primary },
    { id: 'B', x: 320, y: 400, label: 'B', tint: AppTokens.colors.secondary },
    { id: 'C', x: 520, y: 300, label: 'C', tint: AppTokens.colors.tertiary },
  ];

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [['#FF26C6DA', 0.25], AppTokens.colors.background, ['#FF7B61FF', 0.25]],
          direction: GradientDirection.Bottom
        })

      // Main content
      Column() {
        // Top navigation bar
        Row() {
          Button() {
            Circle({ width: 20, height: 20 })
              .fill(AppTokens.colors.onSurface)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .padding(AppTokens.spacing.lg)

          Text('Coupon Pack')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Button() {
            Circle({ width: 20, height: 20 })
              .fill(AppTokens.colors.primary)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .padding(AppTokens.spacing.lg)
        }
        .width('100%')
        .padding({ top: AppTokens.spacing.lg })

        // Content column
        Column() {
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.colors.onSurface)
            .margin({ bottom: AppTokens.spacing.lg })

          MapCard({ pins: this.pins })
            .margin({ bottom: AppTokens.spacing.lg })

          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.colors.onSurface)
            .margin({ bottom: AppTokens.spacing.lg })

          // Horizontal scrollable coupon list
          List() {
            ForEach(this.coupons, (coupon: Coupon) => {
              ListItem() {
                CouponCard({ coupon: coupon })
                  .margin({ right: AppTokens.spacing.lg })
              }
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .height(140)
          .padding({ left: AppTokens.spacing.xs })

          Blank()
            .height(AppTokens.spacing.sm)

          // Bottom buttons
          Row() {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.colors.secondary)
              .fontColor(AppTokens.colors.onSecondary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(AppTokens.shapes.largeCornerRadius)
              .margin({ right: AppTokens.spacing.md })
              .onClick(() => {
                promptAction.showToast({ message: 'My Coupons' });
              })

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.colors.primary)
              .fontColor(AppTokens.colors.onPrimary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(AppTokens.shapes.largeCornerRadius)
              .onClick(() => {
                promptAction.showToast({ message: 'Explore More' });
              })
          }
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: AppTokens.spacing.lg, right: AppTokens.spacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
