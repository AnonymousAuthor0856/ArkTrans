import { router } from '@kit.ArkUI';

// MARK: - AppTokens (Design System)

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF00E5FF';
    export const secondary: string = '#FF00BFA5';
    export const tertiary: string = '#FF69F0AE';
    export const background: string = '#FF0A0A0A';
    export const surface: string = '#FF121212';
    export const surfaceVariant: string = '#FF1E1E1E';
    export const outline: string = '#FF2C2C2C';
    export const success: string = '#FF00C853';
    export const warning: string = '#FFFFD600';
    export const error: string = '#FFD50000';
    export const onPrimary: string = '#FF0A0A0A';
    export const onSecondary: string = '#FF0A0A0A';
    export const onBackground: string = '#FFFFFFFF';
    export const onSurface: string = '#FFFFFFFF';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const titleSize: number = 18;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Normal;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 14;
    export const xl: number = 20;
    export const xxl: number = 28;
  }

  export namespace ElevationMapping {
    export const level1ShadowRadius: number = 4;
    export const level1ShadowOffsetX: number = 0;
    export const level1ShadowOffsetY: number = 2;
    export const level1ShadowOpacity: number = 0.15;
    export const level2ShadowRadius: number = 8;
    export const level2ShadowOffsetX: number = 0;
    export const level2ShadowOffsetY: number = 4;
    export const level2ShadowOpacity: number = 0.18;
    export const level3ShadowRadius: number = 12;
    export const level3ShadowOffsetX: number = 0;
    export const level3ShadowOffsetY: number = 6;
    export const level3ShadowOpacity: number = 0.2;
  }
}

// MARK: - CartItem Data Model

interface CartItem {
  id: number;
  name: string;
  price: number;
}

// MARK: - CartItemCard Component

@Component
struct CartItemCard {
  item: CartItem = { id: 0, name: '', price: 0 };

  build() {
    Row() {
      Column() {
        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)

        Text(`$${this.item.price.toFixed(2)}`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.Start)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .onClick(() => {})
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1ShadowRadius,
      color: `rgba(10,10,10,${AppTokens.ElevationMapping.level1ShadowOpacity})`,
      offsetX: AppTokens.ElevationMapping.level1ShadowOffsetX,
      offsetY: AppTokens.ElevationMapping.level1ShadowOffsetY
    })
  }
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ];

  @State private promo: string = '';

  private get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppTokens.Colors.background, 0.0],
            [AppTokens.Colors.surfaceVariant, 1.0]
          ]
        })

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {

          // Title
          Text('Your Cart')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Cart item list
          ForEach(this.items, (item: CartItem) => {
            CartItemCard({ item: item })
          }, (item: CartItem) => item.id.toString())

          // Spacer
          Column().height(AppTokens.Spacing.md)

          // Promo code input
          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(`rgba(255,255,255,0.5)`)
            .placeholderFont({
              size: AppTokens.TypographyTokens.bodySize,
              weight: AppTokens.TypographyTokens.bodyWeight
            })
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: AppTokens.Colors.outline,
              radius: AppTokens.Shapes.medium
            })
            .width('100%')
            .onChange((value: string) => {
              this.promo = value;
            })

          // Spacer
          Column().height(AppTokens.Spacing.md)

          // Summary card
          Column({ space: AppTokens.Spacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(`${this.items.length}`)
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text('Total:')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(`$${this.total.toFixed(2)}`)
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1ShadowRadius,
            color: `rgba(10,10,10,${AppTokens.ElevationMapping.level1ShadowOpacity})`,
            offsetX: AppTokens.ElevationMapping.level1ShadowOffsetX,
            offsetY: AppTokens.ElevationMapping.level1ShadowOffsetY
          })

          // Checkout button
          Button('Checkout')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .onClick(() => {})
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}