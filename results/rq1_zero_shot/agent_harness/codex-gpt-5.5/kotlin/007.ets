const NAME: string = '010_ShoppingCart_en';
const UI_TYPE: string = 'E-commerce Cart';
const STYLE_THEME: string = 'Minimal Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#000000';
  static readonly secondary: string = '#FF6F00';
  static readonly tertiary: string = '#4CAF50';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F5F5F5';
  static readonly outline: string = '#E0E0E0';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FF9800';
  static readonly error: string = '#F44336';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#000000';
  static readonly onSurface: string = '#000000';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class CartItem {
  id: number;
  name: string;
  price: number;
  color: string;

  constructor(id: number, name: string, price: number, color: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.color = color;
  }
}

@Entry
@Component
struct MainActivity {
  @State quantities: number[] = [1, 1, 1, 1];
  private shipping: number = 5.99;
  private tax: number = 18.50;
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, AppColors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, AppColors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, AppColors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, AppColors.secondary)
  ];

  subtotal(): number {
    let total = 0;
    this.cartItems.forEach((item: CartItem, index: number) => {
      total += item.price * this.quantities[index];
    });
    return total;
  }

  money(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  changeQuantity(index: number, delta: number): void {
    const next = [...this.quantities];
    next[index] = Math.max(1, Math.min(10, next[index] + delta));
    this.quantities = next;
  }

  @Builder
  Header(): void {
    Row({ space: AppSpacing.sm }) {
      Rect().width(20).height(20).fill(AppColors.primary).radius(6);
      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  QuantityButton(label: string, onTap: () => void): void {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(6)
      .width(28)
      .height(28)
      .onClick(onTap);
  }

  @Builder
  CartItemCard(item: CartItem, index: number): void {
    Row({ space: AppSpacing.lg }) {
      Rect().width(60).height(60).fill(item.color).radius(8);
      Column({ space: AppSpacing.xs }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
        Row({ space: AppSpacing.sm }) {
          Rect().width(28).height(28).fill(AppColors.surfaceVariant).radius(6);
          Rect().width(28).height(28).fill(AppColors.surfaceVariant).radius(6);
          Rect().width(28).height(28).fill(AppColors.surfaceVariant).radius(6);
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);

      Column({ space: AppSpacing.sm }) {
        this.QuantityButton('+', () => {
          this.changeQuantity(index, 1);
        });
        Text(this.quantities[index].toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        this.QuantityButton('-', () => {
          this.changeQuantity(index, -1);
        });
      }
      .alignItems(HorizontalAlign.Center);

      Button('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.error)
        .borderRadius(8)
        .width(85)
        .height(36);
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ActionChip(label: string): void {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(6)
      .height(32)
      .padding({ left: 10, right: 10 });
  }

  @Builder
  SummaryRow(label: string, value: string, headline: boolean): void {
    Row() {
      Text(label)
        .fontSize(headline ? 18 : 12)
        .fontWeight(headline ? FontWeight.SemiBold : FontWeight.Normal)
        .fontColor(AppColors.onSurface);
      Blank();
      Text(value)
        .fontSize(headline ? 18 : 14)
        .fontWeight(headline ? FontWeight.SemiBold : FontWeight.Medium)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomBar(): void {
    Column({ space: AppSpacing.md }) {
      this.SummaryRow('Subtotal', this.money(this.subtotal()), false);
      this.SummaryRow('Shipping', this.money(this.shipping), false);
      this.SummaryRow('Tax', this.money(this.tax), false);
      this.SummaryRow('Total', this.money(this.subtotal() + this.shipping + this.tax), true);
      Button('Proceed to Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .width('100%')
        .height(44);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 });
  }

  build() {
    Column() {
      this.Header();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            this.CartItemCard(item, index);
          }, (item: CartItem) => item.id.toString())
          Row({ space: AppSpacing.sm }) {
            this.ActionChip('Apply Coupon');
            this.ActionChip('Gift Wrap');
            this.ActionChip('Save for Later');
          }
          .width('100%')
          .alignItems(VerticalAlign.Center);
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl });
      }
      .layoutWeight(1);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
