import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、间距、形状和阴影。
// 这种结构使得修改 UI 比例和控件大小变得非常方便。

interface ColorToken {
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
    headline: TypographyToken;
    title: TypographyToken;
    body: TypographyToken;
    label: TypographyToken;
}

interface ShapeToken {
    small: number;
    medium: number;
    large: number;
}

interface SpacingToken {
    xs: number;
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
    xxxl: number;
}

interface ElevationToken {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
}

interface ElevationMapping {
    level1: ElevationToken;
    level2: ElevationToken;
    level3: ElevationToken;
    level4: ElevationToken;
    level5: ElevationToken;
}

export class AppTokens {

    static Colors: ColorToken = {
        primary: '#D95F02',
        secondary: '#1B9AAA',
        tertiary: '#FEC601',
        background: '#F9F4EB',
        surface: '#FFFFFF',
        surfaceVariant: '#F0E3D1',
        outline: '#E1CDB2',
        success: '#56C271',
        warning: '#F4A259',
        error: '#D7263D',
        onPrimary: '#1B1B1B',
        onSecondary: '#041012',
        onTertiary: '#1E1200',
        onBackground: '#2C2A29',
        onSurface: '#2E2924'
    };

    static TypographyTokens: TypographyTokens = {
        display: { size: 28, weight: FontWeight.Medium },
        headline: { size: 20, weight: FontWeight.Medium },
        title: { size: 16, weight: FontWeight.Medium },
        body: { size: 13, weight: FontWeight.Regular },
        label: { size: 11, weight: FontWeight.Medium }
    };

    static Shapes: ShapeToken = {
        small: 12,
        medium: 16,
        large: 20
    };

    static Spacing: SpacingToken = {
        xs: 4,
        sm: 8,
        md: 12,
        lg: 16,
        xl: 20,
        xxl: 28,
        xxxl: 40
    };

    // 阴影规格结构体
    static ElevationMapping: ElevationMapping = {
        level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
        level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
        level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.2 },
        level4: { elevation: 12, radius: 16, dy: 8, opacity: 0.24 },
        level5: { elevation: 16, radius: 20, dy: 10, opacity: 0.28 }
    };
}

// MARK: - Data Models
// 翻译自 Kotlin 的 Zone 数据类
interface Zone {
    id: number;
    name: string;
    humidity: number;
    temp: string;
}

// MARK: - Reusable Components
// 翻译自 Kotlin 的 StatusRow Composable
@Component
struct StatusRow {
    private label: string = '';
    private value: number = 0;
    private accent: ResourceColor = '#000000';

    build() {
        Column({ space: AppTokens.Spacing.xs }) {
            Row() {
                Text(this.label)
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(`${Math.round(this.value * 100)}%`)
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(this.accent)
            }
            // 线性进度条，近似 Compose 的 LinearProgressIndicator
            Progress({ value: this.value, total: 1, type: ProgressType.Linear })
                .color(this.accent) // 进度条颜色
                .backgroundColor(AppTokens.Colors.surface) // 轨道颜色
                .height(4) // 近似 Compose 进度条高度
                .borderRadius(2) // 进度条圆角
        }
    }
}

// 翻译自 Kotlin 的 ZoneRow Composable
@Component
struct ZoneRow {
    private zone: Zone = { id: 0, name: '', humidity: 0, temp: '' };

    build() {
        Column({ space: AppTokens.Spacing.xs }) {
            Row() {
                Text(this.zone.name)
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(this.zone.temp)
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.primary)
            }
            // 线性进度条，近似 Compose 的 LinearProgressIndicator
            Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surface) // 轨道颜色
                .height(4) // 近似 Compose 进度条高度
                .borderRadius(2) // 进度条圆角
        }
        .padding(AppTokens.Spacing.sm)
        .backgroundColor('#F0E3D180') // 背景色和透明度 (approx 0.5 opacity)
        .borderRadius(AppTokens.Shapes.small) // 圆角
    }
}

// MARK: - Main Screen
// 翻译自 Kotlin 的 RootScreen Composable
@Entry
@Component
struct RootScreen {
    // 使用 @State 存储可变状态，对应 Kotlin 的 remember { mutableStateOf(...) }
    @State activeMode: string = "Orbit";
    @State solarLevel: number = 0.6;
    @State ambientGlow: number = 0.35;

    private modes: string[] = ["Orbit", "Eclipse", "Manual"];
    private zones: Zone[] = [
        { id: 1, name: "Atrium", humidity: 0.45, temp: "72°F" },
        { id: 2, name: "Lab East", humidity: 0.62, temp: "68°F" },
        { id: 3, name: "Hab Deck", humidity: 0.30, temp: "70°F" }
    ];

    build() {
        Stack({ alignContent: Alignment.TopStart }) {
            // 设置整个屏幕的背景色
            Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppTokens.Colors.background)

            // 主 VStack 结构，对应 Kotlin 的 Scaffold，包含顶部栏、可滚动内容和底部栏
            Column() {
                // MARK: 顶部栏 (Top Bar)
                // 对应 Kotlin 的 CenterAlignedTopAppBar
                Row() {
                    Button({ type: ButtonType.Normal, stateEffect: true }) {
                        Text("Dock")
                            .fontSize(AppTokens.TypographyTokens.label.size)
                            .fontWeight(AppTokens.TypographyTokens.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                    }
                    .backgroundColor(Color.Transparent)
                    
                    Blank() // 居中标题
                    
                    Text("Smart Orbit Panel")
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                    
                    Blank() // 居中标题
                    
                    Button({ type: ButtonType.Normal, stateEffect: true }) {
                        Text("Alerts")
                            .fontSize(AppTokens.TypographyTokens.label.size)
                            .fontWeight(AppTokens.TypographyTokens.label.weight)
                            .fontColor(AppTokens.Colors.secondary)
                    }
                    .backgroundColor(Color.Transparent)
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg }) // 水平内边距
                .height(56) // 近似 Material3 TopAppBar 的标准高度
                .backgroundColor(AppTokens.Colors.surface) // 背景色
                // Kotlin 代码中 TopAppBar 没有明确的阴影，因此这里不添加

                // MARK: 可滚动内容区域 (Scrollable Content)
                // 对应 Kotlin 的 Column.verticalScroll
                Scroll() {
                    Column({ space: AppTokens.Spacing.md }) {
                        // 模式选择芯片 (Filter Chips)
                        Row({ space: AppTokens.Spacing.sm }) {
                            ForEach(this.modes, (mode: string) => {
                                Button({ type: ButtonType.Normal, stateEffect: true }) {
                                    Text(mode)
                                        .fontSize(AppTokens.TypographyTokens.label.size)
                                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                }
                                .onClick(() => {
                                    this.activeMode = mode;
                                })
                                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md }) // 芯片内部文本的水平内边距
                                .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })   // 芯片内部文本的垂直内边距
                                .backgroundColor(this.activeMode === mode ? '#D95F0226' : AppTokens.Colors.surface) // 选中/未选中背景色 (0.15 opacity approx #26)
                                .borderWidth(1)
                                .borderColor(AppTokens.Colors.outline)
                                .borderRadius(AppTokens.Shapes.small) // 芯片形状
                            })
                        }
                        .alignItems(VerticalAlign.Top) // 确保芯片靠左对齐

                        // Solar Wash 卡片
                        // 对应 Kotlin 的 Card
                        Column({ space: AppTokens.Spacing.sm }) {
                            Text("Solar wash")
                                .fontSize(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                            Text("Adjust orbital window glow")
                                .fontSize(AppTokens.TypographyTokens.body.size)
                                .fontWeight(AppTokens.TypographyTokens.body.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                                .opacity(0.7)
                            
                            // Slider (滑块)
                            Slider({ value: this.solarLevel, min: 0, max: 1 })
                                .selectedColor(AppTokens.Colors.primary) // 滑块拇指和激活轨道的颜色
                                .trackColor(AppTokens.Colors.surfaceVariant)
                                .blockColor(AppTokens.Colors.primary)
                            
                            // Slider 下方的 0% 和 X% 文本
                            Row() {
                                Text("0%")
                                    .fontSize(AppTokens.TypographyTokens.label.size)
                                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                                    .fontColor(AppTokens.Colors.onSurface)
                                Blank()
                                Text(`${Math.round(this.solarLevel * 100)}%`)
                                    .fontSize(AppTokens.TypographyTokens.title.size)
                                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                                    .fontColor(AppTokens.Colors.primary)
                            }
                            .width('100%') // 填充可用宽度

                            // Ambient Glow
                            Text("Ambient glow")
                                .fontSize(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                            
                            // Slider (滑块)
                            Slider({ value: this.ambientGlow, min: 0, max: 1 })
                                .selectedColor(AppTokens.Colors.secondary) // 滑块拇指和激活轨道的颜色
                                .trackColor(AppTokens.Colors.surfaceVariant)
                                .blockColor(AppTokens.Colors.secondary)
                            
                            // 线性进度条
                            Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                                .color(AppTokens.Colors.secondary)
                                .backgroundColor(AppTokens.Colors.surfaceVariant) // 轨道颜色
                                .height(4) // 近似 Compose 进度条高度
                                .borderRadius(2) // 进度条圆角
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .backgroundColor(AppTokens.Colors.surface) // 卡片背景色
                        .borderRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: Color.Black.withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })

                        // Orbit Health 卡片
                        // 对应 Kotlin 的 Card
                        Column({ space: AppTokens.Spacing.sm }) {
                            Text("Orbit health")
                                .fontSize(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                            StatusRow({ label: "Atmos mix", value: 0.74, accent: AppTokens.Colors.secondary })
                            StatusRow({ label: "Hull temp", value: 0.42, accent: AppTokens.Colors.primary })
                            StatusRow({ label: "Shield sync", value: 0.88, accent: AppTokens.Colors.tertiary })
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .backgroundColor(AppTokens.Colors.surfaceVariant) // 卡片背景色
                        .borderRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: Color.Black.withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })

                        // Deck Zones 卡片
                        // 对应 Kotlin 的 Card
                        Column({ space: AppTokens.Spacing.sm }) {
                            Text("Deck zones")
                                .fontSize(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                            ForEach(this.zones, (zone: Zone) => {
                                ZoneRow({ zone: zone })
                            })
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .backgroundColor(AppTokens.Colors.surface) // 卡片背景色
                        .borderRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: Color.Black.withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })
                    }
                    // 整个可滚动内容的水平和垂直内边距，对应 Scaffold 的 contentPadding
                    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                    .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                }
                .layoutWeight(1) // 占据剩余空间
                .scrollBar(BarState.Off)

                // MARK: 底部栏 (Bottom Bar)
                // 对应 Kotlin 的 Scaffold bottomBar
                Row() {
                    Column({ space: AppTokens.Spacing.xs }) {
                        Text("Grid draw")
                            .fontSize(AppTokens.TypographyTokens.label.size)
                            .fontWeight(AppTokens.TypographyTokens.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                        Text("18.4 kWh")
                            .fontSize(AppTokens.TypographyTokens.title.size)
                            .fontWeight(AppTokens.TypographyTokens.title.weight)
                            .fontColor(AppTokens.Colors.primary)
                    }
                    Blank()
                    Button({ type: ButtonType.Normal, stateEffect: true }) {
                        Text("Engage eco hold")
                            .fontSize(AppTokens.TypographyTokens.label.size)
                            .fontWeight(AppTokens.TypographyTokens.label.weight)
                            .fontColor(AppTokens.Colors.onPrimary)
                    }
                    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md }) // 按钮内部文本的水平内边距
                    .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })   // 按钮内部文本的垂直内边距
                    .backgroundColor(AppTokens.Colors.primary) // 按钮背景色
                    .borderRadius(AppTokens.Shapes.medium) // 按钮圆角
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg }) // 水平内边距
                .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })   // 垂直内边距
                .backgroundColor(AppTokens.Colors.surface) // 背景色
                // 底部栏阴影，对应 AppTokens.ElevationMapping.level2
                .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: Color.Black.withAlpha(AppTokens.ElevationMapping.level2.opacity), offsetY: AppTokens.ElevationMapping.level2.dy })
            }
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
    }
}