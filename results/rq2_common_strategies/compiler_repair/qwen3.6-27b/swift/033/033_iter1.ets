import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to ArkTS structs/interfaces

interface ColorTokens {
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

interface TypographyToken {
    size: number;
    weight: FontWeight;
}

interface TypographyTokens {
    display: TypographyToken;
    title: TypographyToken;
    body: TypographyToken;
    label: TypographyToken;
}

interface ShapeTokens {
    small: number;
    medium: number;
    large: number;
}

interface SpacingTokens {
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
}

interface ElevationSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
}

interface ElevationMapping {
    level1: ElevationSpec;
    level2: ElevationSpec;
}

const AppTokens = {
    Colors: {
        primary: '#06B6D4',
        secondary: '#3B82F6',
        tertiary: '#8B5CF6',
        background: '#F0F9FF',
        surface: '#FFFFFF',
        surfaceVariant: '#E0F2FE',
        outline: '#BAE6FD',
        success: '#22C55E',
        warning: '#FACC15',
        error: '#EF4444',
        onPrimary: '#FFFFFF',
        onSecondary: '#FFFFFF',
        onTertiary: '#FFFFFF',
        onBackground: '#0F172A',
        onSurface: '#0F172A'
    } as ColorTokens,

    TypographyTokens: {
        // Kotlin's displayLarge = 28.sp, FontWeight.Bold
        display: { size: 28, weight: FontWeight.Bold },
        // Kotlin's titleMedium = 18.sp, FontWeight.Medium
        title: { size: 18, weight: FontWeight.Medium },
        // Kotlin's bodyMedium = 14.sp, FontWeight.Normal
        body: { size: 14, weight: FontWeight.Normal },
        // Kotlin's labelMedium = 12.sp, FontWeight.Medium
        label: { size: 12, weight: FontWeight.Medium }
    } as TypographyTokens,

    Shapes: {
        small: 6,
        medium: 12,
        large: 20
    } as ShapeTokens,

    Spacing: {
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
        xxl: 32
    } as SpacingTokens,

    // ShadowSpec mapping from Compose to ArkTS
    ElevationMapping: {
        level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
        level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
    } as ElevationMapping
};

@Entry
@Component
struct RootScreen {
    @State spending: number = 500;
    readonly goal: number = 1000;

    build() {
        Column() {
            // Top Bar equivalent (CenterAlignedTopAppBar)
            Row() {
                Text('Bill Calendar')
                    .fontSize(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.background)
            .justifyContent(FlexAlign.Center)

            // Main content area
            Scroll() {
                Column({ space: AppTokens.Spacing.lg }) {
                    // Surface Card
                    Column({ space: 0 }) {
                        Text('Current Spending')
                            .fontSize(AppTokens.TypographyTokens.title.size)
                            .fontWeight(AppTokens.TypographyTokens.title.weight)
                            .fontColor(AppTokens.Colors.primary)

                        Blank()

                        Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                            .fontSize(AppTokens.TypographyTokens.display.size)
                            .fontWeight(AppTokens.TypographyTokens.display.weight)
                            .fontColor(AppTokens.Colors.onSurface)

                        Blank()

                        // LinearProgressIndicator equivalent
                        Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
                            .width('100%')
                            .height(8)
                            .color(AppTokens.Colors.primary)
                            .trackColor(AppTokens.Colors.surfaceVariant)
                            .borderRadius(4)
                    }
                    .width('100%')
                    .height(160)
                    .padding(AppTokens.Spacing.lg)
                    .backgroundColor(Color.White)
                    .borderRadius(AppTokens.Shapes.large)
                    .shadow({
                        radius: AppTokens.ElevationMapping.level2.radius,
                        color: Color.Black,
                        offsetX: 0,
                        offsetY: AppTokens.ElevationMapping.level2.dy
                    })

                    Text('Adjust Spending')
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)

                    // Slider
                    Slider({ value: this.spending, min: 0, max: 2000 })
                        .width('100%')
                        .blockColor(AppTokens.Colors.primary)
                        .selectedColor(AppTokens.Colors.primary)
                        .trackColor(AppTokens.Colors.surfaceVariant)
                        .showTips(false)

                    // Button
                    Button('Reset')
                        .width('100%')
                        .height(48)
                        .backgroundColor(AppTokens.Colors.tertiary)
                        .borderRadius(AppTokens.Shapes.medium)
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onTertiary)
                        .onClick(() => {
                            this.spending = 0;
                        })
                }
                .padding(AppTokens.Spacing.lg)
            }
            .layoutWeight(1)
            .linearGradient({
                angle: 90,
                colors: [
                    [AppTokens.Colors.secondary, 0.0],
                    [AppTokens.Colors.background, 0.5],
                    [AppTokens.Colors.primary, 1.0]
                ]
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
    }
}