// AppTokens - Design System

class ColorTokens {
  primary: string = '#00E5FF';
  secondary: string = '#00BFA5';
  tertiary: string = '#69F0AE';
  background: string = '#0A0A0A';
  surface: string = '#121212';
  surfaceVariant: string = '#1E1E1E';
  outline: string = '#2C2C2C';
  success: string = '#00C853';
  warning: string = '#FFD600';
  error: string = '#D50000';
  onPrimary: string = '#0A0A0A';
  onSecondary: string = '#0A0A0A';
  onBackground: string = '#FFFFFF';
  onSurface: string = '#FFFFFF';
}

class SpacingTokens {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class ShapeTokens {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

namespace AppTokens {
  export const Colors: ColorTokens = new ColorTokens();
  export const Spacing: SpacingTokens = new SpacingTokens();
  export const Shapes: ShapeTokens = new ShapeTokens();
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
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0);
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
