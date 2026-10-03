import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Design System)

interface ColorHex {
    hex: string;
}

class AppColors {
    static readonly primary = '#00E5FF';
    static readonly secondary = '#00BFA5';
    static readonly tertiary = '#69F0AE';
    static readonly background = '#0A0A0A';
    static readonly surface = '#121212';
    static readonly surfaceVariant = '#1E1E1E';
    static readonly outline = '#2C2C2C';
    static readonly success = '#00C853';
    static readonly warning = '#FFD600';
    static readonly error = '#D50000';
    static readonly onPrimary = '#0A0A0A';
    static readonly onSecondary = '#0A0A0A';
    static readonly onBackground = '#FFFFFF';
    static readonly onSurface = '#FFFFFF';
}

class AppTypography {
    static readonly displaySize = 28;
    static readonly titleSize = 18;
    static readonly bodySize = 14;
    static readonly labelSize = 12;
}

class AppShapes {
    static readonly small = 6;
    static readonly medium = 10;
    static readonly large = 14;
}

class AppSpacing {
    static readonly sm = 6;
    static readonly md = 10;
    static readonly lg = 14;
    static readonly xl = 20;
    static readonly xxl = 28;
}

interface ShadowSpec {
    radius: number;
    x: number;
    y: number;
    opacity: number;
}

class ElevationMapping {
    static readonly level1: ShadowSpec = { radius: 4, x: 0, y: 2, opacity: 0.15 };
    static readonly level2: ShadowSpec = { radius: 8, x: 0, y: 4, opacity: 0.18 };
    static readonly level3: ShadowSpec = { radius: 12, x: 0, y: 6, opacity: 0.2 };
}

// MARK: - CartItem Data Model

interface CartItem {
    id: number;
    name: string;
    price: number;
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
    @State items: CartItem[] = [
        { id: 1, name: "Neon Keyboard", price: 89.99 },
        { id: 2, name: "Wireless Mouse", price: 49.99 },
        { id: 3, name: "Gaming Headset", price: 109.99 }
    ];
    @State promo: string = '';

    get total(): number {
        return this.items.reduce((sum, item) => sum + item.price, 0);
    }

    build() {
        Stack() {
            // Background Gradient
            Column()
                .width('100%')
                .height('100%')
                .linearGradient({
                    angle: 180,
                    colors: [
                        [AppColors.background, 0],
                        [AppColors.surfaceVariant, 1]
                    ]
                })
                .position({ x: 0, y: 0 })
                .zIndex(-1);

            Scroll() {
                Column() {
                    Text("Your Cart")
                        .fontSize(AppTypography.displaySize)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(AppColors.primary)
                        .alignSelf(ItemAlign.Start)
                        .margin({ bottom: AppSpacing.md });

                    // Cart Item List
                    ForEach(this.items, (item: CartItem) => {
                        this.CartItemCard(item)
                    })

                    Blank().height(AppSpacing.md);

                    // Promo Code Input
                    Row() {
                        TextInput({ placeholder: 'Promo Code' })
                            .type(InputType.Normal)
                            .text(this.promo)
                            .onChange((value: string) => {
                                this.promo = value;
                            })
                            .fontSize(AppTypography.bodySize)
                            .fontColor(AppColors.onSurface)
                            .placeholderColor(new Color(AppColors.onSurface).opacity(0.5))
                            .padding(AppSpacing.md)
                            .backgroundColor(AppColors.surfaceVariant)
                            .borderRadius(AppShapes.medium)
                            .border({ width: 1, color: AppColors.outline, radius: AppShapes.medium })
                            .layoutWeight(1);
                    }
                    .width('100%')
                    .margin({ top: AppSpacing.md, bottom: AppSpacing.md });

                    // Summary Card
                    Column() {
                        Row() {
                            Text("Items:")
                                .fontSize(AppTypography.bodySize)
                                .fontColor(AppColors.onSurface);
                            Blank();
                            Text(`${this.items.length}`)
                                .fontSize(AppTypography.bodySize)
                                .fontColor(AppColors.primary);
                        }
                        .width('100%')
                        .margin({ bottom: AppSpacing.sm });

                        Row() {
                            Text("Total:")
                                .fontSize(AppTypography.titleSize)
                                .fontColor(AppColors.onSurface);
                            Blank();
                            Text(`$${this.total.toFixed(2)}`)
                                .fontSize(AppTypography.titleSize)
                                .fontColor(AppColors.primary);
                        }
                        .width('100%');
                    }
                    .padding(AppSpacing.lg)
                    .width('100%')
                    .backgroundColor(AppColors.surfaceVariant)
                    .borderRadius(AppShapes.large)
                    .shadow({
                        radius: ElevationMapping.level1.radius,
                        color: new Color(AppColors.background).opacity(ElevationMapping.level1.opacity),
                        offsetX: ElevationMapping.level1.x,
                        offsetY: ElevationMapping.level1.y
                    });

                    // Checkout Button
                    Button("Checkout")
                        .fontSize(AppTypography.titleSize)
                        .fontColor(AppColors.onSecondary)
                        .backgroundColor(AppColors.secondary)
                        .borderRadius(AppShapes.large)
                        .height(56)
                        .width('100%')
                        .margin({ top: AppSpacing.md, bottom: AppSpacing.lg });

                }
                .padding(AppSpacing.lg)
                .width('100%');
            }
            .width('100%')
            .height('100%')
            .scrollBar(BarState.Off);
        }
        .width('100%')
        .height('100%')
        .systemBarProperties({ statusBarContentColor: ColorMode.DARK })
    }

    @Builder
    CartItemCard(item: CartItem) {
        Row() {
            Column() {
                Text(item.name)
                    .fontSize(AppTypography.titleSize)
                    .fontColor(AppColors.onSurface)
                    .textAlign(TextAlign.Start);
                Text(`$${item.price.toFixed(2)}`)
                    .fontSize(AppTypography.bodySize)
                    .fontColor(AppColors.secondary)
                    .margin({ top: 4 });
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1);

            Button("Remove")
                .fontSize(AppTypography.labelSize)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.medium)
                .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm });
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
            radius: ElevationMapping.level1.radius,
            color: new Color(AppColors.background).opacity(ElevationMapping.level1.opacity),
            offsetX: ElevationMapping.level1.x,
            offsetY: ElevationMapping.level1.y
        })
        .margin({ bottom: AppSpacing.md });
    }
}