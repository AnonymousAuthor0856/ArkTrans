import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 翻译 AppTokens 对象到 ArkTS 结构体，包含静态属性
class AppTokens {
    static Colors = {
        primary: '#111111',
        secondary: '#444444',
        background: '#F5F5F5',
        surface: '#FFFFFF',
        outline: '#CCCCCC',
        onPrimary: '#FFFFFF',
        onSurface: '#111111'
    };

    static TypographyTokens = {
        display: { size: 28, weight: FontWeight.Bold },
        headline: { size: 18, weight: FontWeight.SemiBold },
        body: { size: 14, weight: FontWeight.Normal }
    };

    static Shapes = {
        small: 6,
        medium: 10,
        large: 14
    };

    static Spacing = {
        sm: 8,
        md: 12,
        lg: 16
    };

    static ElevationMapping = {
        level1: {
            blurRadius: 4,
            yOffset: 2,
            opacity: 0.1
        }
    };
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
    @State selectedTabIndex: number = 0;
    private tabs: string[] = ["All", "Enrolled", "Completed"];

    build() {
        Stack({ alignContent: Alignment.Top }) {
            // Background
            Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppTokens.Colors.background)

            Column() {
                Text("Course Catalog")
                    .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
                    .foregroundColor(AppTokens.Colors.primary)
                    .textAlign(TextAlign.Start)
                    .width('100%')

                CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })
                    .backgroundColor(AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.small)
                    .margin({ top: AppTokens.Spacing.md })

                // HorizontalPager equivalent using Swiper in ArkUI
                Swiper() {
                    ForEach(this.tabs, (tab: string, index: number) => {
                        CourseList({ title: tab === "All" ? "All Courses" : tab, count: index === 0 ? 6 : (index === 1 ? 3 : 4) })
                    })
                }
                .indicator(false) // Hide default indicator
                .loop(false)
                .autoPlay(false)
                .displayCount(1)
                .index(this.selectedTabIndex)
                .onChange((index: number) => {
                    this.selectedTabIndex = index;
                })
                .margin({ top: AppTokens.Spacing.md })
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
    }
}

// MARK: - CustomTabRow
@Component
struct CustomTabRow {
    @Link selectedTabIndex: number;
    tabs: string[];

    build() {
        Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
                Button() {
                    Column() {
                        Text(tab)
                            .font({ 
                                size: this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.size : AppTokens.TypographyTokens.body.size, 
                                weight: this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline.weight : AppTokens.TypographyTokens.body.weight 
                            })
                            .foregroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
                            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                        
                        if (this.selectedTabIndex === index) {
                            Rectangle()
                                .fill(AppTokens.Colors.primary)
                                .height(2)
                                .width('100%')
                        } else {
                            Rectangle()
                                .fill(Color.Transparent)
                                .height(2)
                                .width('100%')
                        }
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.Center)
                }
                .type(ButtonType.Normal)
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                    this.selectedTabIndex = index;
                })
                .layoutWeight(1)
            })
        }
        .width('100%')
    }
}

// MARK: - CourseList
@Component
struct CourseList {
    title: string;
    count: number;

    build() {
        Scroll() {
            Column() {
                Text(this.title)
                    .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
                    .foregroundColor(AppTokens.Colors.secondary)
                    .margin({ bottom: AppTokens.Spacing.md })

                ForEach(Array.from({ length: this.count }, (_, i) => i + 1), (courseNumber: number) => {
                    CourseCard({ courseNumber: courseNumber })
                        .margin({ bottom: AppTokens.Spacing.md })
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
    }
}

// MARK: - CourseCard
@Component
struct CourseCard {
    courseNumber: number;

    build() {
        Column() {
            Row() {
                Column() {
                    Text(`Course ${this.courseNumber}`)
                        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
                        .foregroundColor(AppTokens.Colors.primary)
                    
                    Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
                        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
                        .foregroundColor(AppTokens.Colors.secondary)
                        .margin({ top: AppTokens.Spacing.sm })
                }
                .alignItems(HorizontalAlign.Start)

                Flex({ justifyContent: FlexAlign.End }) {
                    Text("View")
                        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .padding({ left: 12, right: 12 })
                        .height(24)
                        .backgroundColor(AppTokens.Colors.primary)
                        .borderRadius(12) // Capsule shape approximation
                }
                .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .shadow({
            radius: AppTokens.ElevationMapping.level1.blurRadius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.yOffset
        })
    }
}