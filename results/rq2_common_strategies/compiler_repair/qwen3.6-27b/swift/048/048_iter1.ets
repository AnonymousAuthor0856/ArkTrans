import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 包含应用的所有设计系统常量，便于统一管理和修改
class AppTokens {
    static Colors = {
        primary: '#1E3A8A',
        secondary: '#3B82F6',
        tertiary: '#60A5FA',
        background: '#F5F8FF',
        surface: '#FFFFFF',
        surfaceVariant: '#E8EEFA',
        outline: '#CBD5E1',
        success: '#22C55E',
        warning: '#F59E0B',
        error: '#EF4444',
        onPrimary: '#FFFFFF',
        onSecondary: '#FFFFFF',
        onTertiary: '#0B1220',
        onBackground: '#0B1220',
        onSurface: '#0B1220'
    };

    static TypographyTokens = {
        display: { size: 28, weight: FontWeight.Bold },
        title: { size: 18, weight: FontWeight.Medium },
        body: { size: 14, weight: FontWeight.Normal },
        label: { size: 12, weight: FontWeight.Medium }
    };

    static Shapes = {
        small: 6,
        medium: 10,
        large: 16
    };

    static Spacing = {
        sm: 6,
        md: 10,
        lg: 16,
        xl: 24,
        xxl: 36
    };

    static ShadowSpec = {
        level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
        level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
        level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
    };

    static MaterialDefaults = {
        bottomAppBarHeight: 80,
        fabSize: 56,
        buttonHorizontalPadding: 16,
        buttonVerticalPadding: 8,
        fabBottomMargin: 16,
        fabTrailingMargin: 16,
        lazyColumnContentBottomPadding: 96
    };
}

// MARK: - Data Model
// 列表数据模型
interface LiveItem {
    id: number;
    title: string;
    viewers: number;
    price: string;
}

@Entry
@Component
struct RootScreen {
    private liveList: LiveItem[] = [
        { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
        { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
        { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
        { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
    ];

    build() {
        Stack({ alignContent: Alignment.Bottom }) {
            // 主要内容区域
            Column() {
                Text("Live Shop Events")
                    .fontSize(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ bottom: AppTokens.Spacing.md })

                Scroll() {
                    Column({ space: AppTokens.Spacing.md }) {
                        ForEach(this.liveList, (item: LiveItem) => {
                            LiveItemCard({ item: item })
                        }, (item: LiveItem) => item.id.toString())
                    }
                    .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
                }
                .layoutWeight(1)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(Color.White) // Fallback for gradient if needed, but we use linearGradient below
            
            // Gradient Background Layer
            Column()
                .width('100%')
                .height('100%')
                .linearGradient({
                    angle: 180,
                    colors: [
                        [AppTokens.Colors.background, 0],
                        [AppTokens.Colors.surfaceVariant, 0.5],
                        [AppTokens.Colors.background, 1]
                    ]
                })
                .position({ x: 0, y: 0 })
                .zIndex(-1)

            // Floating Action Button (FAB)
            Row() {
                Blank()
                Button('+', { type: ButtonType.Circle })
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.onSecondary)
                    .width(AppTokens.MaterialDefaults.fabSize)
                    .height(AppTokens.MaterialDefaults.fabSize)
                    .backgroundColor(AppTokens.Colors.secondary)
                    .shadow({
                        radius: AppTokens.ShadowSpec.level2.radius,
                        color: `rgba(0, 0, 0, ${AppTokens.ShadowSpec.level2.opacity})`,
                        offsetX: 0,
                        offsetY: AppTokens.ShadowSpec.level2.dy
                    })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
            .padding({ right: AppTokens.MaterialDefaults.fabTrailingMargin })
            .margin({ bottom: AppTokens.MaterialDefaults.bottomAppBarHeight + AppTokens.MaterialDefaults.fabBottomMargin })

            // Bottom Navigation Bar
            BottomNavBar()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
    }
}

@Component
struct LiveItemCard {
    @Prop item: LiveItem;

    build() {
        Column({ space: AppTokens.Spacing.sm }) {
            // Placeholder Image Area
            Rect()
                .fill(AppTokens.Colors.secondary)
                .width('100%')
                .height(160)
                .borderRadius(AppTokens.Shapes.medium)

            Text(this.item.title)
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onSurface)

            Text(`${this.item.viewers} viewers`)
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.tertiary)

            Row() {
                Text(this.item.price)
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.primary)

                Blank()

                Button('Join Live')
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.medium)
                    .padding({ left: AppTokens.MaterialDefaults.buttonHorizontalPadding, right: AppTokens.MaterialDefaults.buttonHorizontalPadding })
                    .padding({ top: AppTokens.MaterialDefaults.buttonVerticalPadding, bottom: AppTokens.MaterialDefaults.buttonVerticalPadding })
            }
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
            radius: AppTokens.ShadowSpec.level1.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ShadowSpec.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ShadowSpec.level1.dy
        })
    }
}

@Component
struct BottomNavBar {
    build() {
        Row({ space: 0 }) {
            Flex({ justifyContent: FlexAlign.Center }) {
                Text("Home")
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.primary)
            }
            .layoutWeight(1)
            
            Flex({ justifyContent: FlexAlign.Center }) {
                Text("Live")
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
            }
            .layoutWeight(1)

            Flex({ justifyContent: FlexAlign.Center }) {
                Text("Cart")
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
            }
            .layoutWeight(1)

            Flex({ justifyContent: FlexAlign.Center }) {
                Text("Profile")
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
            }
            .layoutWeight(1)
        }
        .width('100%')
        .height(AppTokens.MaterialDefaults.bottomAppBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
            radius: 0.5,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: -1
        })
    }
}