// entry/src/main/ets/pages/Index.ets
// 010_ShoppingCart_en — UI_TYPE: E-commerce Cart — STYLE_THEME: Minimal Monochrome — LANG: en — BASELINE: 1280x720

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

// AppTokens.Colors
const COLOR_PRIMARY: string = '#000000';
const COLOR_SECONDARY: string = '#FF6F00';
const COLOR_TERTIARY: string = '#4CAF50';
const COLOR_BACKGROUND: string = '#FFFFFF';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#F5F5F5';
const COLOR_OUTLINE: string = '#E0E0E0';
const COLOR_ERROR: string = '#F44336';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#000000';

// AppTokens.Shapes
const RADIUS_SMALL: number = 6;
const RADIUS_MEDIUM: number = 8;
const RADIUS_LARGE: number = 12;

// AppTokens.Spacing
const SP_XS: number = 2;
const SP_SM: number = 4;
const SP_MD: number = 6;
const SP_LG: number = 8;
const SP_XXL: number = 16;
const SP_XXXL: number = 24;

// AppTokens.ElevationMapping (level2 / level3)
const SHADOW_L2: ShadowOptions = { radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 };
const SHADOW_L3: ShadowOptions = { radius: 6, color: '#29000000', offsetX: 0, offsetY: 2 };

const SHIPPING: number = 5.99;
const TAX: number = 18.50;

@Entry
@Component
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1];

  private items: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: COLOR_SECONDARY },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: COLOR_PRIMARY },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: COLOR_TERTIARY },
    { id: 4, name: 'Portable Charger', price: 49.99, color: COLOR_SECONDARY }
  ];

  private money(value: number): string {
    return '$' + value.toFixed(2);
  }

  private subtotal(): number {
    let sum: number = 0;
    for (let i: number = 0; i < this.items.length; i++) {
      sum += this.items[i].price * this.quantities[i];
    }
    return sum;
  }

  private total(): number {
    return this.subtotal() + SHIPPING + TAX;
  }

  private increase(index: number): void {
    if (this.quantities[index] < 10) {
      this.quantities.splice(index, 1, this.quantities[index] + 1);
    }
  }

  private decrease(index: number): void {
    if (this.quantities[index] > 1) {
      this.quantities.splice(index, 1, this.quantities[index] - 1);
    }
  }

  @Builder
  Swatch(size: number, color: string, radius: number) {
    // stand-in for Compose Box(...).background(color, shape)
    Row()
      .width(size)
      .height(size)
      .backgroundColor(color)
      .borderRadius(radius)
  }

  @Builder
  QuantityButton(label: string, index: number, isPlus: boolean) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .width(28)
      .height(28)
      .padding(0)
      .borderRadius(RADIUS_SMALL)
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .fontColor(COLOR_ON_SURFACE)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
        if (isPlus) {
          this.increase(index);
        } else {
          this.decrease(index);
        }
      })
  }

  @Builder
  CartRow(item: CartItem, index: number) {
    Row({ space: SP_LG }) {
      this.Swatch(60, item.color, RADIUS_MEDIUM)

      Column({ space: SP_XS }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
        Row({ space: SP_SM }) {
          this.Swatch(28, COLOR_SURFACE_VARIANT, RADIUS_SMALL)
          this.Swatch(28, COLOR_SURFACE_VARIANT, RADIUS_SMALL)
          this.Swatch(28, COLOR_SURFACE_VARIANT, RADIUS_SMALL)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: SP_SM }) {
        this.QuantityButton('+', index, true)
        Text(this.quantities[index].toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        this.QuantityButton('-', index, false)
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove', { type: ButtonType.Normal, stateEffect: true })
        .width(85)
        .height(36)
        .padding(0)
        .borderRadius(RADIUS_MEDIUM)
        .backgroundColor(COLOR_ERROR)
        .fontColor(COLOR_ON_PRIMARY)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(SP_LG)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(RADIUS_LARGE)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow(SHADOW_L2)
    .constraintSize({ minHeight: 100 })
  }

  @Builder
  Chip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(COLOR_ON_SURFACE)
      .padding({ left: SP_LG, right: SP_LG, top: SP_SM, bottom: SP_SM })
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(RADIUS_SMALL)
      .border({ width: 1, color: COLOR_OUTLINE })
  }

  @Builder
  SummaryRow(label: string, value: string, emphasized: boolean) {
    Row() {
      Text(label)
        .fontSize(emphasized ? 18 : 12)
        .fontWeight(emphasized ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(COLOR_ON_SURFACE)
      Text(value)
        .fontSize(emphasized ? 18 : 14)
        .fontWeight(emphasized ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row({ space: SP_SM }) {
        this.Swatch(20, COLOR_PRIMARY, RADIUS_SMALL)
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .lineHeight(28)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      // LazyColumn -> List
      List({ space: SP_LG }) {
        ForEach(this.items, (item: CartItem, index: number) => {
          ListItem() {
            this.CartRow(item, index)
          }
        }, (item: CartItem, index: number) => item.id.toString() + '-' + this.quantities[index].toString())

        ListItem() {
          Row({ space: SP_SM }) {
            this.Chip('Apply Coupon')
            this.Chip('Gift Wrap')
            this.Chip('Save for Later')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ bottom: SP_XXXL })
        }
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .padding({ left: SP_LG, right: SP_LG, top: SP_MD, bottom: SP_LG })

      // bottomBar
      Column({ space: SP_MD }) {
        this.SummaryRow('Subtotal', this.money(this.subtotal()), false)
        this.SummaryRow('Shipping', this.money(SHIPPING), false)
        this.SummaryRow('Tax', this.money(TAX), false)
        this.SummaryRow('Total', this.money(this.total()), true)

        Button('Proceed to Checkout', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(44)
          .padding(0)
          .borderRadius(RADIUS_LARGE)
          .backgroundColor(COLOR_PRIMARY)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
          })
      }
      .width('100%')
      .padding(SP_LG)
      .backgroundColor(COLOR_SURFACE)
      .shadow(SHADOW_L3)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}