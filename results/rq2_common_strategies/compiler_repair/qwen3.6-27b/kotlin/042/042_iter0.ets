import { common, window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#0EA5E9',
    secondary: '#38BDF8',
    tertiary: '#7DD3FC',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16
  }
}

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

@Entry
@Component
struct RootScreen {
  @State products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ];

  build() {
    Column() {
      // Header Text
      Text("Cold Gradient Price Compare")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg })

      // Grid Section
      GridContainer({ products: this.products })
        .layoutWeight(1)
        .width('100%')

      // Log Section Header
      Text("Price Update Log")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

      // Log List
      ScrollableLogList({ products: this.products })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    // Simulating the vertical gradient background
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.25],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.25]
      ]
    })
  }
}

@Component
struct GridContainer {
  @ObjectLink products: Product[];

  build() {
    GridContainer() {
      ForEach(this.products, (product: Product) => {
        GridItem() {
          CardComponent({ product: product })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.md)
    .columnsGap(AppTokens.Spacing.md)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CardComponent {
  @Prop product: Product;

  build() {
    Column() {
      // Placeholder Image Box
      Row()
        .width(100)
        .height(100)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.product.price)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.primary)
        .textAlign(TextAlign.Center)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
        .margin({ bottom: AppTokens.Spacing.sm })

      Button("Compare")
        .width('100%')
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.medium)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          // Handle compare action
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct ScrollableLogList {
  @ObjectLink products: Product[];

  build() {
    List({ space: AppTokens.Spacing.sm }) {
      ForEach(this.products, (product: Product) => {
        ListItem() {
          Row() {
            Text(`${product.name} (${product.store})`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .layoutWeight(1)
              .textAlign(TextAlign.Start)

            Text(product.price)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.surface)
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding({ bottom: 48 })
  }
}

// --- Application Entry Point Logic ---

// Note: In ArkTS, we typically don't manually hide system bars in the component code 
// as strictly as Android Activity lifecycle methods, but we can set the window style 
// if needed via the UIAbility context. For this single-file conversion, we focus on the UI structure.

export default class MainAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Standard ability creation
  }

  onDestroy(): void {
    // Standard ability destruction
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
    
    // Optional: Set full screen / immersive mode similar to Kotlin code
    const windowClass = windowStage.getWindowSync();
    windowClass.setWindowLayoutFullScreen(true);
  }
}