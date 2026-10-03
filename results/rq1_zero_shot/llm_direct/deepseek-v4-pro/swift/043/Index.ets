// AppTokens.ets
export class AppColors {
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

export class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

export class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

export class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

export class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1OffsetY: number = 2;
  static readonly level1Opacity: number = 0.15;
}

// CartItem.ets
export class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

// Index.ets
import { AppColors, AppTypography, AppShapes, AppSpacing, AppElevation } from './AppTokens';
import { CartItem } from './CartItem';

@Entry
@Component
struct ShoppingCartPage {
  @State private promo: string = '';
  
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];

  private getTotal(): number {
    let total: number = 0;
    for (let item of this.items) {
      total += item.price;
    }
    return total;
  }

  private formatPrice(price: number): string {
    return '$' + price.toFixed(2);
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.formatPrice(item.price))
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('Remove')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      }
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1Radius,
      color: 'rgba(10, 10, 10, ' + AppElevation.level1Opacity + ')',
      offsetY: AppElevation.level1OffsetY
    })
  }

  @Builder
  SummaryCard() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text('Items:')
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(this.items.length.toString())
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Row() {
        Text('Total:')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(this.formatPrice(this.getTotal()))
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1Radius,
      color: 'rgba(10, 10, 10, ' + AppElevation.level1Opacity + ')',
      offsetY: AppElevation.level1OffsetY
    })
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[AppColors.background, 0], [AppColors.surfaceVariant, 1]]
        })

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Text('Your Cart')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.items, (item: CartItem) => {
            this.CartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank()
            .height(AppSpacing.md)

          // Promo code input
          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .fontSize(AppTypography.bodySize)
            .fontColor(AppColors.onSurface)
            .placeholderColor('rgba(255, 255, 255, 0.5)')
            .placeholderFont({ size: AppTypography.bodySize })
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: AppColors.outline,
              radius: AppShapes.medium
            })
            .width('100%')

          Blank()
            .height(AppSpacing.md)

          this.SummaryCard()

          // Checkout button
          Button() {
            Text('Checkout')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .width('100%')
              .height(56)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(56)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}