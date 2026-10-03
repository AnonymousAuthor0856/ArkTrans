import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to ArkTS structs/interfaces
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
    },

    TypographyTokens: {
        // Kotlin's displayLarge = 28.sp, FontWeight.Bold
        display: { size: 28, weight: FontWeight.Bold },
        // Kotlin's titleMedium = 18.sp, FontWeight.Medium
        title: { size: 18, weight: FontWeight.Medium },
        // Kotlin's bodyMedium = 14.sp, FontWeight.Normal
        body: { size: 14, weight: FontWeight.Normal },
        // Kotlin's labelMedium = 12.sp, FontWeight.Medium
        label: { size: 12, weight: FontWeight.Medium }
    },

    Shapes: {
        small: 6,
        medium: 12,
        large: 20
    },

    Spacing: {
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
        xxl: 32
    },

    // ShadowSpec mapping from Compose to ArkTS
    ElevationMapping: {
        level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
        level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
    }
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
                    .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
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
                            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
                            .fontColor(AppTokens.Colors.primary)

                        Blank()

                        Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
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
                    .backgroundColor(Color.White.withAlpha(0.9))
                    .borderRadius(AppTokens.Shapes.large)
                    .shadow({
                        radius: AppTokens.ElevationMapping.level2.radius,
                        color: Color.Black.withAlpha(AppTokens.ElevationMapping.level2.opacity),
                        offsetX: 0,
                        offsetY: AppTokens.ElevationMapping.level2.dy
                    })

                    Text('Adjust Spending')
                        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
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
                        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
                        .fontColor(AppTokens.Colors.onTertiary)
                        .onClick(() => {
                            this.spending = 0;
                        })
                }
                .padding(AppTokens.Spacing.lg)
            }
            .layoutWeight(1)
            .backgroundColor(
                new LinearGradient({
                    angle: 90,
                    colors: [
                        { color: AppTokens.Colors.secondary, position: 0.0 },
                        { color: AppTokens.Colors.background, position: 0.5 },
                        { color: AppTokens.Colors.primary, position: 1.0 }
                    ]
                })
            )
            // Note: ArkTS doesn't support direct opacity on gradient stops in the same way as SwiftUI easily without custom drawing.
            // We approximate the visual effect by using the base colors or relying on the container background if needed.
            // For a closer match to the SwiftUI code which uses alpha on specific stops:
            // The SwiftUI code does: secondary.copy(alpha=0.3), background, primary.copy(alpha=0.2)
            // ArkTS LinearGradient doesn't support alpha per stop directly in the simple API.
            // We will use the solid colors for simplicity as per "compilable ArkTS code only" constraint and standard APIs.
            // To strictly mimic, one might need Canvas, but that's complex. Let's stick to standard UI components.
            // Re-applying the gradient with standard colors is the safest compilable approach.
            .linearGradient({
                angle: 90,
                colors: [
                    { color: AppTokens.Colors.secondary, position: 0.0 },
                    { color: AppTokens.Colors.background, position: 0.5 },
                    { color: AppTokens.Colors.primary, position: 1.0 }
                ]
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
    }
}