// AppTokens - Design System

class AppTokens {
  static Colors = {
    primary: '#00E5FF',
    secondary: '#00BFA5',
    tertiary: '#69F0AE',
    background: '#0A0A0A',
    surface: '#121212',
    surfaceVariant: '#1E1E1E',
    outline: '#2C2C2C',
    success: '#00C853',
    warning: '#FFD600',
    error: '#D50000',
    onPrimary: '#0A0A0A',
    onSecondary: '#0A0A0A',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF',
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };
}

// CartItem data model

interface CartItem {
  id: number;
  name: string;
  price: number;
}

// RootScreen component

@Entry
@Component
struct RootScreen {
  @State promo: string = '';

  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 },
  ];

  private get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(`$${item.price.toFixed(2)}`)
          .fontSize(18)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4 })

      Blank()

      Button('Remove')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm,
        })
        .height(36)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .margin({ bottom: AppTokens.Spacing.md })
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]],
          direction: GradientDirection.Bottom,
        })

      Scroll() {
        Column() {
          Text('Your Cart')
            .fontSize(42)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md, top: AppTokens.Spacing.sm })

          // Cart items
          ForEach(this.items, (item: CartItem) => {
            this.CartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          // Promo code input
          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .width('100%')
            .height(56)
            .fontSize(18)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('#80FFFFFF')
            .placeholderFont({ size: 18 })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: AppTokens.Colors.outline,
            })
            .padding(AppTokens.Spacing.md)
            .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.promo = value;
            })

          // Summary card
          Column() {
            Row() {
              Text('Items:')
                .fontSize(18)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(`${this.items.length}`)
                .fontSize(18)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.sm })

            Row() {
              Text('Total:')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(`$${this.total.toFixed(2)}`)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

          // Checkout button
          Button('Checkout')
            .width('100%')
            .height(56)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ top: AppTokens.Spacing.md })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}
