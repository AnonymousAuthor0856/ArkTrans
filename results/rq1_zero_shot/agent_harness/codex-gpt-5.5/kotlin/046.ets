const NAME: string = '060CouponPacken';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Gradient Flow';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

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
struct MainActivity {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppColors.primary, AppColors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppColors.secondary, AppColors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppColors.tertiary, AppColors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppColors.secondary, AppColors.primary)
  ];
  private pins: MapPin[] = [
    new MapPin(140, 220, 'A', AppColors.primary),
    new MapPin(320, 400, 'B', AppColors.secondary),
    new MapPin(520, 300, 'C', AppColors.tertiary)
  ];

  @Builder
  TopBar(): void {
    Row() {
      Circle().width(20).height(20).fill(AppColors.onSurface);
      Blank();
      Text('Coupon Pack')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
      Blank();
      Circle().width(20).height(20).fill(AppColors.primary);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background);
  }

  @Builder
  MapPanel(): void {
    Stack() {
      Rect().width('100%').height('100%').fill(AppColors.surfaceVariant).radius(20);
      ForEach(this.pins, (pin: MapPin) => {
        Circle()
          .width(28)
          .height(28)
          .fill(pin.tint)
          .position({ x: pin.x / 2, y: pin.y / 2 });
      }, (pin: MapPin) => pin.label)
      Row({ space: AppSpacing.sm }) {
        Circle().width(10).height(10).fill(AppColors.primary);
        Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor(AppColors.onSurface);
        Circle().width(10).height(10).fill(AppColors.secondary);
        Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor(AppColors.onSurface);
        Circle().width(10).height(10).fill(AppColors.tertiary);
        Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor(AppColors.onSurface);
      }
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(8)
      .position({ x: '58%', y: 8 });
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(20);
  }

  @Builder
  CouponCard(coupon: Coupon): void {
    Column({ space: AppSpacing.sm }) {
      Row({ space: AppSpacing.sm }) {
        Circle().width(14).height(14).fill(AppColors.primary);
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(VerticalAlign.Center);
      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
      Button('Redeem')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(14)
        .width('100%')
        .height(40);
    }
    .width(200)
    .height(140)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 10, color: '#29000000', offsetY: 6 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.TopBar();
      Column({ space: AppSpacing.lg }) {
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
        this.MapPanel();
        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
        Scroll() {
          Row({ space: AppSpacing.lg }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon);
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: AppSpacing.xs, right: AppSpacing.xs });
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .height(150);
        Blank().height(AppSpacing.sm);
        Row({ space: AppSpacing.md }) {
          Button('My Coupons')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(20)
            .layoutWeight(1)
            .height(52);
          Button('Explore More')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(20)
            .layoutWeight(1)
            .height(52);
        }
        .width('100%');
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
