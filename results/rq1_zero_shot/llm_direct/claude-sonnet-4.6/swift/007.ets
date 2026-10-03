import { router } from '@kit.ArkUI';

// Design Tokens
const Colors = {
  primary: '#000000',
  secondary: '#FF6F00',
  tertiary: '#4CAF50',
  background: '#FFFFFF',
  surface: '#FFFFFF',
  surfaceVariant: '#F5F5F5',
  outline: '#E0E0E0',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onBackground: '#000000',
  onSurface: '#000000',
};

const Spacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24,
};

const Shapes = {
  small: 6,
  medium: 8,
  large: 12,
};

interface CartItemData {
  id: number;
  name: string;
  price: number;
  color: string;
}

const cartItemsData: CartItemData[] = [
  { id: 1, name: 'Wireless Headphones', price: 129.99, color: Colors.secondary },
  { id: 2, name: 'Smartphone Case', price: 24.99, color: Colors.primary },
  { id: 3, name: 'USB-C Cable', price: 19.99, color: Colors.tertiary },
  { id: 4, name: 'Portable Charger', price: 49.99, color: Colors.secondary },
];

@Component
struct FeatureBox {
  build() {
    Row()
      .width(28)
      .height(28)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.small)
  }
}

@Component
struct QuantityButton {
  symbol: string = '+';
  onAction: () => void = () => {};

  build() {
    Button(this.symbol)
      .width(28)
      .height(28)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(Colors.onSurface)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.small)
      .onClick(() => {
        this.onAction();
      })
  }
}

@Component
struct SummaryRow {
  title: string = '';
  value: number = 0;
  emphasize: boolean = false;

  build() {
    Row() {
      Text(this.title)
        .fontSize(this.emphasize ? 18 : 12)
        .fontWeight(this.emphasize ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(Colors.onSurface)
      Blank()
      Text(`$${this.value.toFixed(2)}`)
        .fontSize(this.emphasize ? 18 : 14)
        .fontWeight(this.emphasize ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
  }
}

@Component
struct CartItemCard {
  item: CartItemData = { id: 0, name: '', price: 0, color: '' };
  quantity: number = 1;
  onIncrease: () => void = () => {};
  onDecrease: () => void = () => {};

  build() {
    Row({ space: Spacing.lg }) {
      Row()
        .width(60)
        .height(60)
        .backgroundColor(this.item.color)
        .borderRadius(Shapes.medium)

      Column({ space: Spacing.xs }) {
        Text(this.item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)

        Text(`$${this.item.price.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)

        Row({ space: Spacing.sm }) {
          FeatureBox()
          FeatureBox()
          FeatureBox()
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: Spacing.sm }) {
        QuantityButton({
          symbol: '+',
          onAction: () => {
            this.onIncrease();
          }
        })
        Text(`${this.quantity}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        QuantityButton({
          symbol: '-',
          onAction: () => {
            this.onDecrease();
          }
        })
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .width(85)
        .height(36)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .backgroundColor(Colors.error)
        .borderRadius(Shapes.medium)
    }
    .padding(Spacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .border({ width: 1, color: Colors.outline, radius: Shapes.large })
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 })
  }
}

@Component
struct ChipsRow {
  private chips: string[] = ['Apply Coupon', 'Gift Wrap', 'Save for Later'];

  build() {
    Row({ space: Spacing.sm }) {
      ForEach(this.chips, (label: string) => {
        Button(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.small)
          .border({ width: 1, color: Colors.outline, radius: Shapes.small })
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.sm, bottom: Spacing.sm })
          .height('auto')
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct ShoppingCartAppView {
  @State quantities: number[] = [1, 1, 1, 1];
  private shipping: number = 5.99;
  private tax: number = 18.50;

  get subtotal(): number {
    return cartItemsData.reduce((sum, item, index) => {
      return sum + item.price * (this.quantities[index] ?? 1);
    }, 0);
  }

  get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        Row({ space: Spacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(Colors.primary)
            .borderRadius(Shapes.small)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          top: Spacing.xxl,
          bottom: Spacing.md,
          left: Spacing.lg,
          right: Spacing.lg
        })
        .margin({ top: 30, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: Spacing.lg }) {
            ForEach(cartItemsData, (item: CartItemData, index: number) => {
              CartItemCard({
                item: item,
                quantity: this.quantities[index],
                onIncrease: () => {
                  if (this.quantities[index] < 10) {
                    const newQuantities = [...this.quantities];
                    newQuantities[index] += 1;
                    this.quantities = newQuantities;
                  }
                },
                onDecrease: () => {
                  if (this.quantities[index] > 1) {
                    const newQuantities = [...this.quantities];
                    newQuantities[index] -= 1;
                    this.quantities = newQuantities;
                  }
                }
              })
            })
            ChipsRow()
          }
          .padding({
            left: Spacing.lg,
            right: Spacing.lg,
            top: Spacing.md,
            bottom: 240
          })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Bottom Summary
      Column({ space: Spacing.md }) {
        SummaryRow({ title: 'Subtotal', value: this.subtotal })
        SummaryRow({ title: 'Shipping', value: this.shipping })
        SummaryRow({ title: 'Tax', value: this.tax })
        SummaryRow({ title: 'Total', value: this.total, emphasize: true })
        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.large)
      }
      .padding(Spacing.lg)
      .width('100%')
      .backgroundColor(Colors.surface)
      .borderRadius(Shapes.large)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 2 })
      .margin({
        left: Spacing.lg,
        right: Spacing.lg,
        bottom: Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}