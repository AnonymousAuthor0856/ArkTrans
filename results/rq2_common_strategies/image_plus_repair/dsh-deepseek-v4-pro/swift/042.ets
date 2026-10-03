// import SwiftUI  ->  ArkTS: ArkUI 组件与类型在 .ets 页面中默认可直接使用，无需显式 import

// MARK: - AppTokens
// 统一的UI设计系统，方便修改比例和控件大小
class AppTokens {
}

// 对应 Swift 的 AppTokens.Colors
class AppColors {
    // 将Compose的Color(0xFF...)转换为SwiftUI的Color(red:green:blue:)
    static readonly primary: string = '#0EA5E9'; // 0xFF0EA5E9
    static readonly secondary: string = '#38BDF8'; // 0xFF38BDF8
    static readonly tertiary: string = '#7DD3FC'; // 0xFF7DD3FC
    static readonly background: string = '#F0F9FF'; // 0xFFF0F9FF
    static readonly surface: string = '#FFFFFF'; // 0xFFFFFFFF
    static readonly surfaceVariant: string = '#E0F2FE'; // 0xFFE0F2FE
    static readonly outline: string = '#BAE6FD'; // 0xFFBAE6FD
    static readonly success: string = '#22C55E'; // 0xFF22C55E
    static readonly warning: string = '#FACC15'; // 0xFFFACC15
    static readonly error: string = '#EF4444'; // 0xFFEF4444
    static readonly onPrimary: string = '#FFFFFF'; // 0xFFFFFFFF
    static readonly onSecondary: string = '#1E1E1E'; // 0xFF1E1E1E
    static readonly onTertiary: string = '#0F172A'; // 0xFF0F172A
    static readonly onBackground: string = '#0F172A'; // 0xFF0F172A
    static readonly onSurface: string = '#0F172A'; // 0xFF0F172A
}

// 对应 Swift 的 AppTokens.TypographyTokens
class AppTypography {
    // 将Compose的TextStyle转换为SwiftUI的Font
    static readonly displaySize: number = 26;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly titleSize: number = 18;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Normal; // FontWeight.Normal 对应 .regular
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// 对应 Swift 的 AppTokens.Shapes
class AppShapes {
    // 将Compose的RoundedCornerShape的dp值转换为SwiftUI的CGFloat
    static readonly small: number = 6.0;
    static readonly medium: number = 10.0;
    static readonly large: number = 16.0;
}

// 对应 Swift 的 AppTokens.Spacing
class AppSpacing {
    // 将Compose的Dp值转换为SwiftUI的CGFloat
    static readonly sm: number = 6.0;
    static readonly md: number = 10.0;
    static readonly lg: number = 14.0;
    static readonly xl: number = 20.0;
    static readonly xxl: number = 28.0;
}

// 对应 Swift 的 AppTokens.ShadowSpec
class ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number; // Kotlin的Float对应Swift的Double
    constructor(elevation: number, radius: number, dy: number, opacity: number) {
        this.elevation = elevation;
        this.radius = radius;
        this.dy = dy;
        this.opacity = opacity;
    }
}

// 对应 Swift 的 AppTokens.ElevationMapping
class AppElevation {
    // 将Compose的ElevationMapping转换为SwiftUI的ShadowSpec
    static readonly level1: ShadowSpec = new ShadowSpec(2.0, 4.0, 2.0, 0.12);
    static readonly level2: ShadowSpec = new ShadowSpec(6.0, 8.0, 4.0, 0.18);
}

// MARK: - Data Model
// Product数据模型，遵循Identifiable协议以便在ForEach中使用
class Product {
    id: number;
    name: string;
    price: string;
    store: string;
    constructor(id: number, name: string, price: string, store: string) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.store = store;
    }
}

// MARK: - RootScreen
// 对应Compose的RootScreen Composable函数
@Component
struct RootScreen {
    // 模拟Compose的remember，数据源在View初始化时创建
    private products: Product[] = [
        new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
        new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
        new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
        new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
        new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
        new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
    ];

    build() {
        // Scaffold的替代：使用Stack作为背景，ScrollView包裹内容
        Stack() {
            // 整体内容可滚动，对应Compose的LazyColumn/LazyVerticalGrid的混合滚动行为
            Scroll() {
                // 对应Compose的Column
                Column({ space: AppSpacing.lg }) {
                    Text('Cold Gradient Price Compare')
                        .fontSize(AppTypography.displaySize)
                        .fontWeight(AppTypography.displayWeight)
                        .fontColor(AppColors.onBackground)

                    // 对应Compose的LazyVerticalGrid
                    Grid() {
                        ForEach(this.products, (p: Product) => {
                            GridItem() {
                                ProductCard({ product: p })
                            }
                        }, (p: Product) => p.id.toString())
                    }
                    .columnsTemplate('1fr 1fr')
                    .columnsGap(AppSpacing.md)
                    .rowsGap(AppSpacing.md)
                    // 对应Compose的contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
                    .padding({ bottom: AppSpacing.xxl })

                    Text('Price Update Log')
                        .fontSize(AppTypography.titleSize)
                        .fontWeight(AppTypography.titleWeight)
                        .fontColor(AppColors.primary)

                    // 对应Compose的LazyColumn
                    List({ space: AppSpacing.sm }) {
                        ForEach(this.products, (p: Product) => {
                            ListItem() {
                                PriceUpdateLogItem({ product: p })
                            }
                        }, (p: Product) => p.id.toString())
                    }
                    // 对应Compose的contentPadding = PaddingValues(bottom = 48.dp)
                    .padding({ bottom: 48 })
                }
                // 对应Compose的Modifier.padding(AppTokens.Spacing.lg)应用于整个Column
                .padding(AppSpacing.lg)
            }
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
        // 背景渐变色，对应Compose的Brush.verticalGradient
        // 原 Swift 使用 secondary.opacity(0.25) / primary.opacity(0.25)，此处用带透明度的色值表示
        .linearGradient({
            angle: 180,
            colors: [['#4038BDF8', 0.0], [AppColors.background, 0.5], ['#400EA5E9', 1.0]]
        })
        // 确保内容延伸到屏幕边缘，隐藏状态栏，强制浅色模式由系统/页面默认处理
    }
}

// MARK: - ProductCard Component
// 对应Compose的Card组件
@Component
struct ProductCard {
    product: Product = new Product(0, '', '', '');

    build() {
        // 对应Compose的Column
        Column({ space: AppSpacing.sm }) {
            // 占位符Box，对应Compose的Box with size(100.dp)
            Rect()
                .fill(AppColors.surfaceVariant)
                .width(100)
                .height(100)
                .borderRadius(AppShapes.medium)

            Text(this.product.name)
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.onSurface)

            Text(this.product.price)
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.primary)

            Text(this.product.store)
                .fontSize(AppTypography.labelSize)
                .fontWeight(AppTypography.labelWeight)
                .fontColor(AppColors.tertiary)

            // 对应Compose的Button
            Button() {
                Text('Compare')
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(AppTypography.labelWeight)
                    .fontColor(AppColors.onPrimary)
                    .textAlign(TextAlign.Center)
                    // 对应Compose ButtonDefaults.ContentPadding.vertical = 8.dp
                    .padding({ top: 8.0, bottom: 8.0 })
            }
            .width('100%') // 对应Compose的Modifier.fillMaxWidth()
            .backgroundColor(AppColors.primary) // 对应Compose的containerColor
            .borderRadius(AppShapes.medium) // 对应Compose的shape
            .onClick(() => {})
        }
        // 对应Compose的Modifier.padding(AppTokens.Spacing.md)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface) // 对应Compose的containerColor
        .borderRadius(AppShapes.large) // 对应Compose的shape
        // 对应Compose的elevation
        .shadow({
            radius: AppElevation.level1.radius,
            color: '#1F000000', // 对应 Color.black.opacity(0.12)
            offsetX: 0, // Compose的elevation通常没有水平偏移，或默认0
            offsetY: AppElevation.level1.dy
        })
    }
}

// MARK: - PriceUpdateLogItem Component
// 对应Compose的Row组件
@Component
struct PriceUpdateLogItem {
    product: Product = new Product(0, '', '', '');

    build() {
        // 对应Compose的Row
        Row() {
            Text(`${this.product.name} (${this.product.store})`)
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
            Blank() // 对应Compose的Arrangement.SpaceBetween
            Text(this.product.price)
                .fontSize(AppTypography.labelSize)
                .fontWeight(AppTypography.labelWeight)
                .fontColor(AppColors.secondary)
        }
        .width('100%')
        // 对应Compose的Modifier.padding(AppTokens.Spacing.md)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface) // 对应Compose的background
        .borderRadius(AppShapes.small) // 对应Compose的shape
    }
}

// MARK: - App Entry Point
// 应用程序的入口点，对应MainActivity和setContent
@Entry
@Component
struct PriceCompareApp {
    build() {
        Stack() {
            RootScreen()
        }
    }
}
