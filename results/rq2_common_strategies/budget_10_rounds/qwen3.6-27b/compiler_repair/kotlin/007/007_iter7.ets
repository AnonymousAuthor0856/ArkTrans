import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface TypographyConfig {
  size: number;
  weight: FontWeight;
  lineH: number;
}

interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface TypographyType {
  display: TypographyConfig;
  headline: TypographyConfig;
  title: TypographyConfig;
  body: TypographyConfig;
  label: TypographyConfig;
}

interface AppTokensType {
  Colors: ColorsType;
  Spacing: SpacingType;
  Shapes: ShapesType;
  Typography: TypographyType;
}

const AppTokens: AppTokensType = {
  Colors: {
    primary: '#000000',
    secondary: '#FF6F00',
    tertiary: '#4CAF50',
    background: '#FFFFFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F5F5F5',
    outline: '#E0E0E0',
    success: '#4CAF50',
    warning: '#FF9800',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#000000',
    onSurface: '#000000'
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  },
  Typography: {
    display: { size: 22, weight: FontWeight.Bold, lineH: 28 },
    headline: { size: 18, weight: FontWeight.Bold, lineH: 24 },
    title: { size: 14, weight: FontWeight.Medium, lineH: 18 },
    body: { size: 12, weight: FontWeight.Normal, lineH: 16 },
    label: { size: 10, weight: FontWeight.Medium, lineH: 14 }
  }
}

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCart {
  @State cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: AppTokens.Colors.secondary },
    { id: 2, name: "Smartphone Case", price: 24.99, color: AppTokens.Colors.primary },
    { id: 3, name: "USB-C Cable", price: 19.99, color: AppTokens.Colors.tertiary },
    { id: 4, name: "Portable Charger", price: 49.99, color: AppTokens.Colors.secondary }
  ];
  
  // Map ID to quantity for easier access in list
  @State quantities: Record<number, number> = {
    1: 1, 2: 1, 3: 1, 4: 1
  };

  private shipping: number = 5.99;
  private tax: number = 18.50;

  aboutToAppear() {
    // Hide navigation bar for immersive experience similar to Android code
    try {
      const w: window.Window = window.getClass().getWindowSync(this.getUIContext().getHostContext());
      w.setWindowLayoutFullScreen(true);
    } catch (e) {
      console.error("Failed to set fullscreen");
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Row() {
          Text('')
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          
          Text('Shopping Cart')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .lineHeight(AppTokens.Typography.display.lineH)
            .margin({ left: AppTokens.Spacing.sm })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)
        
        Blank()
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      List({ space: AppTokens.Spacing.lg }) {
        ForEach(this.cartItems, (item: CartItem) => {
          ListItem() {
            this.CartItemCard(item)
          }
        })
        
        // Chips Section
        ListItem() {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            this.ChipComponent("Apply Coupon")
            this.ChipComponent("Gift Wrap")
            this.ChipComponent("Save for Later")
          }
          .width('100%')
          .columnGap(AppTokens.Spacing.sm)
          .rowGap(AppTokens.Spacing.sm)
        }
      }
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom Summary Bar
      this.SummaryBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  ChipComponent(label: string) {
    Text(label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .lineHeight(AppTokens.Typography.label.lineH)
      .fontColor(AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .backgroundColor(AppTokens.Colors.surface)
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      // Image Placeholder
      Row() {
        Text('')
      }
      .width(60)
      .height(60)
      .backgroundColor(item.color)
      .borderRadius(AppTokens.Shapes.medium)

      Column() {
        Text(item.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .lineHeight(AppTokens.Typography.title.lineH)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Text(`$${item.price.toFixed(2)}`)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .lineHeight(AppTokens.Typography.headline.lineH)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })

        // Decorative dots/row from original design
        Row() {
          Circle({ width: 4, height: 4 }).fill(AppTokens.Colors.outline).margin({ right: 2 })
          Circle({ width: 4, height: 4 }).fill(AppTokens.Colors.outline).margin({ right: 2 })
          Circle({ width: 4, height: 4 }).fill(AppTokens.Colors.outline)
        }
        .margin({ top: AppTokens.Spacing.xs })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Quantity Controls
      Column() {
        Button('+')
          .width(28)
          .height(28)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.small)
          .onClick(() => {
            if (this.quantities[item.id] < 10) {
              this.quantities[item.id]++;
            }
          })

        Text(`${this.quantities[item.id]}`)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })

        Button('-')
          .width(28)
          .height(28)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.small)
          .onClick(() => {
            if (this.quantities[item.id] > 1) {
              this.quantities[item.id]--;
            }
          })
      }
      .alignItems(HorizontalAlign.Center)

      // Remove Button
      Button('Remove')
        .height(36)
        .width(85)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .backgroundColor(AppTokens.Colors.error)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ left: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder
  SummaryBar() {
    Column() {
      this.SummaryRow("Subtotal", this.calculateSubtotal())
      this.SummaryRow("Shipping", this.shipping)
      this.SummaryRow("Tax", this.tax)
      
      Divider().color(AppTokens.Colors.outline).margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      
      this.SummaryRow("Total", this.calculateTotal(), true)
      
      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }

  @Builder
  SummaryRow(label: string, value: number, isBold: boolean = false) {
    Row() {
      Text(label)
        .fontSize(isBold ? AppTokens.Typography.headline.size : AppTokens.Typography.body.size)
        .fontWeight(isBold ? AppTokens.Typography.headline.weight : AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank()
      
      Text(`$${value.toFixed(2)}`)
        .fontSize(isBold ? AppTokens.Typography.headline.size : AppTokens.Typography.title.size)
        .fontWeight(isBold ? AppTokens.Typography.headline.weight : AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .margin({ bottom: AppTokens.Spacing.md })
  }

  calculateSubtotal(): number {
    return this.cartItems.reduce((sum, item) => sum + (item.price * this.quantities[item.id]), 0);
  }

  calculateTotal(): number {
    return this.calculateSubtotal() + this.shipping + this.tax;
  }
}