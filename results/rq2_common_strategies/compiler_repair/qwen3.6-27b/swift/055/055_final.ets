import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Mapping Kotlin/Compose tokens to ArkTS constants.

interface ColorMap {
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

interface TypographyMap {
    display: TypographyToken;
    headline: TypographyToken;
    title: TypographyToken;
    body: TypographyToken;
    label: TypographyToken;
}

interface ShapeMap {
    small: number;
    medium: number;
    large: number;
}

interface SpacingMap {
    xs: number;
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
}

interface ShadowSpecItem {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
}

interface ShadowSpecMap {
    level1: ShadowSpecItem;
    level2: ShadowSpecItem;
    level3: ShadowSpecItem;
}

export class AppTokens {
    // MARK: Colors
    static readonly Colors: ColorMap = {
        primary: '#2563EB',
        secondary: '#38BDF8',
        tertiary: '#3B82F6',
        background: '#F8FAFC',
        surface: '#FFFFFF',
        surfaceVariant: '#E2E8F0',
        outline: '#CBD5E1',
        success: '#22C55E',
        warning: '#F59E0B',
        error: '#EF4444',
        onPrimary: '#FFFFFF',
        onSecondary: '#0F172A',
        onTertiary: '#FFFFFF',
        onBackground: '#0F172A',
        onSurface: '#1E293B'
    };

    // MARK: TypographyTokens
    // Mapping Font sizes and weights. Note: ArkTS uses FontSize (number) and FontWeight (enum).
    static readonly TypographyTokens: TypographyMap = {
        display: { size: 28, weight: FontWeight.Bold },
        headline: { size: 20, weight: FontWeight.Medium },
        title: { size: 16, weight: FontWeight.Medium },
        body: { size: 14, weight: FontWeight.Normal },
        label: { size: 12, weight: FontWeight.Medium }
    };

    // MARK: Shapes
    static readonly Shapes: ShapeMap = {
        small: 8,
        medium: 12,
        large: 16
    };

    // MARK: Spacing
    static readonly Spacing: SpacingMap = {
        xs: 4,
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
        xxl: 36
    };

    // MARK: ElevationMapping
    static readonly ShadowSpec: ShadowSpecMap = {
        level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
        level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
        level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 }
    };
}

@Entry
@Component
struct RootScreen {
    // Constants for layout dimensions matching Material Design defaults
    private topBarHeight: number = 64;
    private bottomBarHeight: number = 80;
    private fabSize: number = 56;

    build() {
        Stack({ alignContent: Alignment.BottomEnd }) {
            // 1. Main Content Layer
            Column() {
                // Top placeholder to avoid content being covered by custom top bar
                Divider().height(this.topBarHeight).width(0)

                Text('Sign In to Continue')
                    .fontSize(AppTokens.TypographyTokens.headline.size)
                    .fontWeight(AppTokens.TypographyTokens.headline.weight)
                    .fontColor(AppTokens.Colors.onSurface)

                // Workout Preview Box
                Stack() {
                    Text('Workout Preview')
                        .fontSize(AppTokens.TypographyTokens.body.size)
                        .fontWeight(AppTokens.TypographyTokens.body.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                }
                .width('100%')
                .height(200)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.large)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })

                // Authenticate Button
                Button({ type: ButtonType.Capsule, stateEffect: true }) {
                    Text('Authenticate')
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onPrimary)
                }
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(AppTokens.Shapes.large)
                .height(52)
                .width('80%') // fillMaxWidth(0.8f) equivalent

                Blank()
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .width('100%')
            .height('100%')
            .linearGradient({
                angle: 90,
                colors: [
                    ['rgba(56, 189, 248, 0.1)', 0], // secondary with alpha 0.1
                    ['rgba(37, 99, 235, 0.15)', 1]  // primary with alpha 0.15
                ]
            })
            .backgroundColor(AppTokens.Colors.background)
            .padding({ bottom: this.bottomBarHeight })

            // 2. Custom Top Bar Layer
            Column() {
                Text('Workout Plan')
                    .fontSize(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.onBackground)
            }
            .width('100%')
            .height(this.topBarHeight)
            .backgroundColor(AppTokens.Colors.surface)
            .position({ x: 0, y: 0 })

            // 3. Custom Bottom Bar Layer
            Column() {
                Row() {
                    Text('Home')
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.primary)
                        .layoutWeight(1)

                    Text('Plan')
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .layoutWeight(1)

                    Text('Profile')
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .layoutWeight(1)
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                .width('100%')
                .height(this.bottomBarHeight)
                .backgroundColor(AppTokens.Colors.surface)
                .shadow({
                    radius: AppTokens.ShadowSpec.level2.radius,
                    color: `rgba(${parseInt(AppTokens.Colors.onBackground.slice(1, 3), 16)}, ${parseInt(AppTokens.Colors.onBackground.slice(3, 5), 16)}, ${parseInt(AppTokens.Colors.onBackground.slice(5, 7), 16)}, ${AppTokens.ShadowSpec.level2.opacity})`,
                    offsetX: 0,
                    offsetY: AppTokens.ShadowSpec.level2.dy
                })
            }
            .width('100%')
            .position({ x: 0, y: '100%' })
            .translate({ y: -this.bottomBarHeight })

            // 4. Floating Action Button (FAB) Layer
            Button({ type: ButtonType.Circle, stateEffect: true }) {
                Text('+')
                    .fontSize(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.onPrimary)
            }
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(this.fabSize / 2)
            .width(this.fabSize)
            .height(this.fabSize)
            .position({
                x: '100%',
                y: '100%'
            })
            .translate({
                x: -(this.fabSize + AppTokens.Spacing.lg),
                y: -(this.bottomBarHeight + AppTokens.Spacing.lg + this.fabSize / 2)
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
    }
}