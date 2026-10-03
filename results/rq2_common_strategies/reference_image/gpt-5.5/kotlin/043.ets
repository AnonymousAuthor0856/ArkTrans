interface CartItem {
  id: number;
  name: string;
  price: number;
}

class AppTokens {
  static readonly NAME: string = '057*ShoppingCart*en';
  static readonly UI_TYPE: string = 'ECommerce';
  static readonly STYLE_THEME: string = 'Dark Neon';
  static readonly LANG: string = 'en';
  static readonly BASELINE_SIZE: string = '720x1280';
}

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
  static readonly placeholder: string = '#80FFFFFF';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
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

@Entry
@Component
struct ShoppingCartPage {
  @State private promo: string = '';

  private readonly items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ];

  private getTotal(): number {
    let total: number = 0;
    this.items.forEach((item: CartItem) => {
      total += item.price;
    });
    return total;
  }

  private formatPrice(value: number): string {
    return '$' + value.toFixed(2);
  }

  @Builder
  private CartItemCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.formatPrice(item.price))
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Remove')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width(92)
      .height(40)
      .borderRadius(AppShapes.medium)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private PromoInput() {
    Column() {
      TextInput({
        placeholder: 'Promo Code',
        text: this.promo
      })
        .width('100%')
        .height(56)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .fontSize(AppTypography.titleSize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.placeholder)
        .caretColor(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .onChange((value: string) => {
          this.promo = value;
        })

      Divider()
        .height(1)
        .color(AppColors.outline)
    }
    .width('100%')
  }

  @Builder
  private SummaryCard() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text('Items:')
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)

        Text(this.items.length.toString())
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Total:')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(this.formatPrice(this.getTotal()))
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Your Cart')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')

      ForEach(this.items, (item: CartItem) => {
        this.CartItemCard(item)
      }, (item: CartItem) => item.id.toString())

      Blank()
        .height(AppSpacing.md)

      this.PromoInput()

      Blank()
        .height(AppSpacing.md)

      this.SummaryCard()

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Checkout')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width('100%')
      .height(56)
      .borderRadius(AppShapes.large)
      .backgroundColor(AppColors.secondary)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.background, 0.0],
        [AppColors.surfaceVariant, 1.0]
      ]
    })
  }
}