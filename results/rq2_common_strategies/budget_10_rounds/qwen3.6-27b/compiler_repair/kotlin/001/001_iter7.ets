import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppColors {
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensInterface {
  Colors: AppColors;
  Spacing: AppSpacing;
  Shapes: AppShapes;
}

const AppTokens: AppTokensInterface = {
  Colors: {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CC24A',
    onSecondary: '#0A0F0A',
    tertiary: '#FFB300',
    onTertiary: '#1F1400',
    background: '#F6F7FB',
    onBackground: '#0F172A',
    surface: '#FCFCFF',
    onSurface: '#111827',
    surfaceVariant: '#EEF0F6',
    outline: '#D0D5DD',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#D92D20'
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
    small: 4,
    medium: 8,
    large: 12
  }
}

interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

// --- Helper Components ---

@Component
struct FilterChip {
  @Prop label: string;
  @Prop selected: boolean;
  onClick?: (event: ClickEvent) => void;

  build() {
    Row() {
      Text(this.label)
        .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .fontWeight(this.selected ? FontWeight.Medium : FontWeight.Normal)
        .fontSize(14)
    }
    .width('auto')
    .height(36)
    .padding({ left: 12, right: 12 })
    .backgroundColor(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
    .onClick((event: ClickEvent) => {
      if (this.onClick) this.onClick(event);
    })
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop active: boolean;
  onClick?: (event: ClickEvent) => void;

  build() {
    Row() {
      Text(this.label)
        .fontColor(this.active ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize(10)
    }
    .width('auto')
    .height(32)
    .padding({ left: 10, right: 10 })
    .backgroundColor(this.active ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
    .onClick((event: ClickEvent) => {
      if (this.onClick) this.onClick(event);
    })
  }
}

@Component
struct ProductCard {
  @ObjectLink product: ProductUi;

  build() {
    Column() {
      // Image Placeholder
      Row() {
        Text("Image")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(AppTokens.Shapes.medium)
      .justifyContent(FlexAlign.Center)

      Column() {
        .margin({ top: AppTokens.Spacing.md })
        
        // Title and Badge
        Row() {
          Text(this.product.title)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Blank()
          
          if (this.product.badge !== "") {
            Text(this.product.badge)
              .fontColor(AppTokens.Colors.onTertiary)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(AppTokens.Shapes.small)
          }
        }
        .width('100%')

        // Price
        Text(this.product.price)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: AppTokens.Spacing.md })

        // Rating
        Row() {
          .margin({ top: AppTokens.Spacing.sm })
          Circle({ width: 10, height: 10 })
            .fill(AppTokens.Colors.warning)
          Text(`${this.product.rating} rating`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(12)
            .margin({ left: AppTokens.Spacing.sm })
        }

        // Button
        Button("Add to Cart")
          .width('100%')
          .height(40)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct BottomActionBar {
  @Prop subtotal: string;
  @Prop actionLabel: string;
  onAction?: () => void;

  build() {
    Row() {
      Column() {
        Text("Subtotal")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
        Text(this.subtotal)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: AppTokens.Spacing.xs })
      }
      
      Button(this.actionLabel)
        .width(140)
        .height(44)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          if (this.onAction) this.onAction();
        })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }
}

// --- Main Entry Component ---

@Entry
@Component
struct RootScreen {
  @State categories: string[] = ["All", "Snacks", "Drinks", "Fruits", "Bakery", "Dairy"];
  @State selectedCategory: string = "All";
  
  @State filters: string[] = ["In Stock"];
  
  @State products: ProductUi[] = [];

  aboutToAppear() {
    // Initialize products
    const palette: string[] = [
      '#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A', 
      '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'
    ];
    
    for (let i = 0; i < 8; i++) {
      const price = Math.floor(Math.random() * (49 - 9 + 1)) + 9;
      const ratingInt = Math.floor(Math.random() * (5 - 4 + 1)) + 4;
      const ratingDec = Math.floor(Math.random() * 10);
      
      let badge = "";
      if (i % 3 === 0) badge = "NEW";
      else if (i % 4 === 0) badge = "SALE";

      this.products.push({
        id: i,
        title: `Product ${i + 1}`,
        price: `$${price}.99`,
        badge: badge,
        rating: `${ratingInt}.${ratingDec}`,
        color: palette[i % palette.length]
      });
    }

    // Hide navigation bar for full screen effect similar to Android code
    try {
      const ctx = this.getUIContext();
      const win = window.getWindowSync(ctx);
      win.setWindowLayoutFullScreen(true);
    } catch (e) {
      console.error("Failed to set fullscreen", e);
    }
  }

  toggleFilter(filterName: string): void {
    const index = this.filters.indexOf(filterName);
    if (index > -1) {
      this.filters.splice(index, 1);
    } else {
      this.filters.push(filterName);
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Shop")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column() {
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
          
          // Category Row
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            ForEach(this.categories, (category: string) => {
              FilterChip({
                label: category,
                selected: this.selectedCategory === category,
                onClick: () => {
                  this.selectedCategory = category;
                }
              })
              .margin({ right: AppTokens.Spacing.sm })
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md })

          // Filter Row
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            AssistChip({
              label: "In Stock",
              active: this.filters.includes("In Stock"),
              onClick: () => this.toggleFilter("In Stock")
            })
            .margin({ right: AppTokens.Spacing.sm })

            AssistChip({
              label: "Under $20",
              active: this.filters.includes("Under $20"),
              onClick: () => this.toggleFilter("Under $20")
            })
            .margin({ right: AppTokens.Spacing.sm })

            AssistChip({
              label: "Rating 4+",
              active: this.filters.includes("Rating 4+"),
              onClick: () => this.toggleFilter("Rating 4+")
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Product Grid
          ProductGrid({ products: this.products })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Action Bar
      BottomActionBar({
        subtotal: "$129.96",
        actionLabel: "Checkout",
        onAction: () => {}
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct ProductGrid {
  @Prop products: ProductUi[];

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.lg)
    .columnsGap(AppTokens.Spacing.lg)
    .width('100%')
  }
}