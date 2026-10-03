import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { UIContext } from '@kit.ArkUI';

// MARK: - AppTokens (Design System)

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

interface ElevationConfig {
    radius: number;
    dy: number;
    opacity: number;
}

interface ElevationMapping {
    level1: ElevationConfig;
    level2: ElevationConfig;
    level3: ElevationConfig;
    level4: ElevationConfig;
    level5: ElevationConfig;
}

class AppTokens {
    static Colors: ColorToken = {
        primary: '#214E34',
        secondary: '#2D6A4F',
        tertiary: '#6C757D',
        background: '#F8F1E5',
        surface: '#FFFBF0',
        surfaceVariant: '#E9DFC7',
        outline: '#D2C6AA',
        success: '#2B9348',
        warning: '#F4A261',
        error: '#D62828',
        onPrimary: '#FFFFFF',
        onSecondary: '#FFFFFF',
        onTertiary: '#1B1F22',
        onBackground: '#1B1F22',
        onSurface: '#1B1F22'
    };

    static TypographyTokens: Record<string, TypographyToken> = {
        display: { size: 26, weight: FontWeight.Bold },
        headline: { size: 20, weight: FontWeight.Medium },
        title: { size: 16, weight: FontWeight.Medium },
        body: { size: 13, weight: FontWeight.Normal },
        label: { size: 11, weight: FontWeight.Medium }
    };

    static Shapes: ShapeToken = {
        small: 6,
        medium: 10,
        large: 14
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

    static ElevationMapping: ElevationMapping = {
        level1: { radius: 3, dy: 1, opacity: 0.10 },
        level2: { radius: 6, dy: 3, opacity: 0.14 },
        level3: { radius: 10, dy: 5, opacity: 0.16 },
        level4: { radius: 14, dy: 7, opacity: 0.18 },
        level5: { radius: 18, dy: 9, opacity: 0.20 }
    };
}

// MARK: - Data Models

interface DayTab {
    id: number;
    label: string;
}

interface StockRow {
    code: string;
    name: string;
    price: string;
    change: string;
    positive: boolean;
}

// MARK: - Custom Components

@Component
struct CustomCard {
    @Prop shapeRadius: number;
    @Prop containerColor: ResourceColor;
    @Prop elevation: ElevationConfig;
    @Prop borderColor: ResourceColor;
    @Prop borderWidth: number;
    
    build() {
        Column() {
            // Content placeholder handled by parent via slot or direct composition in ArkTS usually requires passing children differently
            // For this conversion, we will inline the card logic where used to maintain structure simplicity 
            // or use a generic builder pattern if supported. 
            // Here we define the style wrapper.
        }
        .backgroundColor(this.containerColor)
        .borderRadius(this.shapeRadius)
        .shadow({
            radius: this.elevation.radius,
            color: `rgba(0, 0, 0, ${this.elevation.opacity})`,
            offsetX: 0,
            offsetY: this.elevation.dy
        })
        .border({
            width: this.borderWidth,
            color: this.borderColor,
            style: BorderStyle.Solid
        })
    }
}

@Component
struct CustomFilterChip {
    @Prop selected: boolean;
    @Prop label: string;
    @Prop action: () => void;

    build() {
        Button(this.label)
            .type(ButtonType.Normal)
            .backgroundColor(this.selected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .border({
                width: 1,
                color: AppTokens.Colors.outline,
                style: BorderStyle.Solid
            })
            .onClick(() => {
                this.action();
            })
    }
}

// MARK: - RootScreen View (主 UI 界面)

@Entry
@Component
struct RootScreen {
    private context: UIContext = this.getUIContext();

    // 状态管理
    private days: DayTab[] = [
        { id: 1, label: "Mon" },
        { id: 2, label: "Tue" },
        { id: 3, label: "Wed" },
        { id: 4, label: "Thu" },
        { id: 5, label: "Fri" }
    ];
    @State selectedDayId: number = 1;

    private sectors: string[] = ["All", "Tech", "Energy", "Finance"];
    @State currentSector: string = "All";

    private items: StockRow[] = [
        { code: "600519", name: "Kweichow Moutai", price: "1687.3", change: "+1.24%", positive: true },
        { code: "000001", name: "Ping An Bank", price: "12.54", change: "-0.62%", positive: false },
        { code: "300750", name: "CATL", price: "192.8", change: "+0.87%", positive: true },
        { code: "601318", name: "Ping An Ins.", price: "44.2", change: "-1.12%", positive: false },
        { code: "600036", name: "CMBC", price: "36.9", change: "+0.15%", positive: true },
        { code: "688981", name: "SMIC", price: "56.4", change: "-0.48%", positive: false }
    ];

    aboutToAppear() {
        // Hide status bar using Window API
        let windowClass: window.Window | null = null;
        try {
            windowClass = window.getWindowSync(this.context);
            if (windowClass) {
                windowClass.setWindowSystemBarProperties({ statusBarContentColor: '#00000000', statusBarColor: '#00000000' });
            }
        } catch (e) {
            console.error(`Failed to set window properties: ${JSON.stringify(e)}`);
        }
    }

    build() {
        Stack() {
            // Background
            Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppTokens.Colors.background)

            Column() {
                // Top Bar
                Row() {
                    Text("Stock Calendar")
                        .fontSize(AppTokens.TypographyTokens.display.size)
                        .fontWeight(AppTokens.TypographyTokens.display.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .padding({ top: 40, bottom: 40 })
                .backgroundColor(AppTokens.Colors.background)

                // Main Content Scrollable Area
                Scroll() {
                    Column({ space: AppTokens.Spacing.md }) {
                        
                        // Date and Sector Selection Card
                        Column() {
                            // Date Tabs
                            Row({ space: AppTokens.Spacing.md }) {
                                ForEach(this.days, (day: DayTab) => {
                                    let isActive = day.id === this.selectedDayId;
                                    Button(day.label)
                                        .type(ButtonType.Normal)
                                        .backgroundColor(isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                                        .borderRadius(AppTokens.Shapes.small)
                                        .layoutWeight(1)
                                        .height(36)
                                        .onClick(() => {
                                            this.selectedDayId = day.id;
                                        })
                                })
                            }
                            
                            // Sector Chips
                            Row({ space: AppTokens.Spacing.sm }) {
                                ForEach(this.sectors, (sector: string) => {
                                    CustomFilterChip({
                                        selected: this.currentSector === sector,
                                        label: sector,
                                        action: () => {
                                            this.currentSector = sector;
                                        }
                                    })
                                })
                                Blank().layoutWeight(1)
                            }
                        }
                        .width('100%')
                        .padding(AppTokens.Spacing.md)
                        .backgroundColor(AppTokens.Colors.surface)
                        .borderRadius(AppTokens.Shapes.large)
                        .shadow({
                            radius: AppTokens.ElevationMapping.level2.radius,
                            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
                            offsetX: 0,
                            offsetY: AppTokens.ElevationMapping.level2.dy
                        })
                        .border({
                            width: 1,
                            color: AppTokens.Colors.outline,
                            style: BorderStyle.Solid
                        })

                        // Stock List
                        Column({ space: AppTokens.Spacing.sm }) {
                            ForEach(this.items, (item: StockRow) => {
                                Column() {
                                    Row() {
                                        // Left Side: Icon + Info
                                        Row({ space: AppTokens.Spacing.md }) {
                                            // Placeholder Icon
                                            Rect()
                                                .fill(AppTokens.Colors.surfaceVariant)
                                                .width(28)
                                                .height(28)
                                                .borderRadius(AppTokens.Shapes.small)
                                            
                                            Column({ space: AppTokens.Spacing.xs }) {
                                                Text(item.name)
                                                    .fontSize(AppTokens.TypographyTokens.title.size)
                                                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                                                    .fontColor(AppTokens.Colors.onSurface)
                                                
                                                Text(item.code)
                                                    .fontSize(AppTokens.TypographyTokens.label.size)
                                                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                                                    .fontColor(AppTokens.Colors.onSurface)
                                            }
                                        }

                                        Blank().layoutWeight(1)

                                        // Right Side: Price + Change + Button
                                        Row({ space: AppTokens.Spacing.lg }) {
                                            Column({ space: AppTokens.Spacing.xs }) {
                                                Text(item.price)
                                                    .fontSize(AppTokens.TypographyTokens.title.size)
                                                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                                                    .fontColor(AppTokens.Colors.onSurface)
                                                
                                                Row({ space: AppTokens.Spacing.xs }) {
                                                    Circle()
                                                        .fill(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                                                        .width(8)
                                                        .height(8)
                                                    
                                                    Text(item.change)
                                                        .fontSize(AppTokens.TypographyTokens.label.size)
                                                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                                                        .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                                                }
                                            }
                                            .alignItems(HorizontalAlign.End)

                                            Button("Detail")
                                                .type(ButtonType.Normal)
                                                .backgroundColor(AppTokens.Colors.primary)
                                                .borderRadius(AppTokens.Shapes.small)
                                                .width(76)
                                                .height(36)
                                        }
                                    }
                                    .width('100%')
                                    .padding(AppTokens.Spacing.md)
                                    .height(72)
                                }
                                .width('100%')
                                .backgroundColor(AppTokens.Colors.surface)
                                .borderRadius(AppTokens.Shapes.medium)
                                .shadow({
                                    radius: AppTokens.ElevationMapping.level1.radius,
                                    color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
                                    offsetX: 0,
                                    offsetY: AppTokens.ElevationMapping.level1.dy
                                })
                                .border({
                                    width: 1,
                                    color: AppTokens.Colors.outline,
                                    style: BorderStyle.Solid
                                })
                            })
                        }
                    }
                    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
                }
                .layoutWeight(1)
                .scrollBar(BarState.Off)
            }
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
    }
}