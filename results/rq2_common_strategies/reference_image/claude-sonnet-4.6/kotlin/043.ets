// EntryAbility.ets (fullscreen setup matching the Compose activity)
// onWindowStageCreate(windowStage: window.WindowStage): void {
//   windowStage.loadContent('pages/ShoppingCartPage', (err) => {
//     if (err.code) { return; }
//     const win = windowStage.getMainWindowSync();
//     win.setWindowLayoutFullScreen(true);
//     win.setWindowSystemBarEnable([]);            // hide status + nav bar
//     win.setWindowSystemBarProperties({
//       navigationBarColor: '#0A0A0A',
//       statusBarColor: '#0A0A0A'
//     });
//   });
// }

const NAME: string = '057*ShoppingCart*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00E5FF';
  static readonly secondary: string = '#00BFA5';
  static readonly tertiary: string = '#69F0AE';
  static readonly background: string = '#0A0A0A';
  static readonly surface: string = '#121212';
  static readonly surfaceVariant: string = '#1E1E1E';
  static readonly outline: string = '#2C2C2C';
  static readonly success: string = '#00C853';
  static readonly warning: string = '#FFD600';
  static readonly error: string = '#D50000';
  static readonly onPrimary: string = '#0A0A0A';
  static readonly onSecondary: string = '#0A0A0A';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.15);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.2);
}

class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

function money(value: number): string {
  return '$' + value.toFixed(2);
}

@Entry
@Component
struct ShoppingCartPage {
  @State items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];
  @State promo: string = '';

  private total(): number {
    let sum: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price;
    }
    return sum;
  }

  @Builder
  cartCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(money(item.price))
          .fontSize(AppTypography.body)
          .fontColor(AppColors.secondary)
          .margin({ top: AppSpacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .height(40)
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
        .onClick(() => {
          this.items = this.items.filter((it: CartItem) => it.id !== item.id);
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: '#40000000',
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')

      ForEach(this.items, (item: CartItem) => {
        this.cartCard(item)
      }, (item: CartItem) => item.id.toString())

      TextInput({ placeholder: 'Promo Code', text: this.promo })
        .type(InputType.Normal)
        .placeholderColor('#80FFFFFF')
        .placeholderFont({ size: AppTypography.body })
        .fontSize(AppTypography.body)
        .fontColor(AppColors.onSurface)
        .caretColor(AppColors.primary)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({ width: 1, color: AppColors.outline })
        .height(56)
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .onChange((value: string) => {
          this.promo = value;
        })

      Column() {
        Row() {
          Text('Items:')
            .fontSize(AppTypography.body)
            .fontColor(AppColors.onSurface)
          Blank()
          Text(this.items.length.toString())
            .fontSize(AppTypography.body)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Total:')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Blank()
          Text(money(this.total()))
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: AppSpacing.sm })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: ElevationMapping.level1.radius,
        color: '#40000000',
        offsetX: 0,
        offsetY: ElevationMapping.level1.dy
      })

      Button('Checkout')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
        .width('100%')
        .height(56)
        .onClick(() => {
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.background, 0.0], [AppColors.surfaceVariant, 1.0]]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}