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

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class CartItem {
  id: number;
  name: string;
  price: number;
  constructor(id: number, name: string, price: number) { this.id = id; this.name = name; this.price = price; }
}

@Entry
@Component
struct MainActivity {
  @State promo: string = '';
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];

  total(): number {
    let sum = 0;
    this.items.forEach((item: CartItem) => sum += item.price);
    return sum;
  }

  money(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  @Builder
  CartRow(item: CartItem): void {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(this.money(item.price))
          .fontSize(14)
          .fontColor(AppColors.secondary);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#26000000', offsetY: 2 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SummaryCard(): void {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text('Items:')
          .fontSize(14)
          .fontColor(AppColors.onSurface);
        Blank();
        Text(this.items.length.toString())
          .fontSize(14)
          .fontColor(AppColors.primary);
      }
      .width('100%');
      Row() {
        Text('Total:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Blank();
        Text(this.money(this.total()))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
      }
      .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#26000000', offsetY: 2 });
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary);
      ForEach(this.items, (item: CartItem) => {
        this.CartRow(item);
      }, (item: CartItem) => item.id.toString())
      Blank().height(AppSpacing.md);
      TextInput({ text: this.promo, placeholder: 'Promo Code' })
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .placeholderColor('#80FFFFFF')
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline })
        .borderRadius(10)
        .width('100%')
        .height(48)
        .onChange((value: string) => {
          this.promo = value;
        });
      Blank().height(AppSpacing.md);
      this.SummaryCard();
      Button('Checkout')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(14)
        .width('100%')
        .height(56);
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
