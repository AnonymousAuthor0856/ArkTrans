// AppTokens Translation
// Defines custom colors, typography styles, shapes, spacing, and elevation for consistent UI elements.

class AppTokens {
    static readonly Colors = {
        primary: '#FFA0C4FF',
        secondary: '#FFB7E4C7',
        tertiary: '#FFFFDDC1',
        background: '#FFF8F7FF',
        surface: '#FFFFFFFF',
        surfaceVariant: '#FFF0F0F5',
        outline: '#FFD9D9E3',
        success: '#FFB4E4C7',
        warning: '#FFFFDDC1',
        error: '#FFFFB4AB',
        onPrimary: '#FF001D3D',
        onSecondary: '#FF003720',
        onTertiary: '#FF3E2800',
        onBackground: '#FF1B1B1F',
        onSurface: '#FF1B1B1F',
    }

    static readonly Typography = {
        display: { size: 45, weight: FontWeight.Bold },
        headline: { size: 24, weight: FontWeight.Medium },
        title: { size: 18, weight: FontWeight.Medium },
        body: { size: 14, weight: FontWeight.Normal },
        label: { size: 12, weight: FontWeight.Medium },
    }

    static readonly Spacing = {
        xs: 4,
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
    }

    static readonly Elevation = {
        level1: { radius: 2, dy: 1, color: `rgba(0,0,0,0.08)` },
        level2: { radius: 4, dy: 2, color: `rgba(0,0,0,0.10)` },
        level3: { radius: 8, dy: 4, color: `rgba(0,0,0,0.12)` },
    }
}

// Reusable Components

// AnnotationToolButton Component
@Component
struct AnnotationToolButton {
    @Prop icon: string;
    @Prop toolName: string;
    @Prop selectedTool: string;
    onClick: () => void = () => {};

    get isSelected(): boolean {
        return this.toolName === this.selectedTool;
    }

    build() {
        Button(this.icon, { type: ButtonType.Circle })
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
            .width(40)
            .height(40)
            .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
            .onClick(() => this.onClick())
    }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
    @State selectedPage: number = 1;
    @State selectedTool: string = "pen";

    @Builder
    PageItem(page: number) {
        Button() {
            Text(page.toString())
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        }
        .type(ButtonType.Normal)
        .borderRadius(8)
        .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .border({
            width: this.selectedPage === page ? 2 : 0,
            color: AppTokens.Colors.primary
        })
        .aspectRatio(0.7)
        .onClick(() => this.selectedPage = page)
    }

    build() {
        Column() {
            // Top Bar
            Row() {
                Button() {
                    Circle()
                        .fill(AppTokens.Colors.surfaceVariant)
                        .width(24)
                        .height(24)
                }
                .backgroundColor(Color.Transparent)
                .width(24)
                .height(24)

                Blank() // Spacer equivalent

                Text("Document.pdf")
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.onBackground)

                Blank() // Spacer equivalent

                Text("Share")
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .padding({
                        top: AppTokens.Spacing.xs,
                        bottom: AppTokens.Spacing.xs,
                        left: AppTokens.Spacing.sm,
                        right: AppTokens.Spacing.sm
                    })
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(4)
            }
            .width('100%')
            .height(56)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .backgroundColor(AppTokens.Colors.surface)

            // Main Content Area
            Row() {
                // Left side: Grid for pages
                Grid() {
                    ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
                        GridItem() {
                            this.PageItem(page)
                        }
                    })
                }
                .columnsTemplate('1fr 1fr')
                .rowsGap(AppTokens.Spacing.sm)
                .columnsGap(AppTokens.Spacing.sm)
                .padding(AppTokens.Spacing.sm)
                .width(150)
                .height('100%')

                // Right side: Main document view
                Stack({ alignContent: Alignment.Center }) {
                    // Main document card
                    Column() {
                        Text(`Page ${this.selectedPage}`)
                            .fontSize(AppTokens.Typography.headline.size)
                            .fontWeight(AppTokens.Typography.headline.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                    }
                    .width('100%')
                    .height('100%')
                    .backgroundColor(AppTokens.Colors.surface)
                    .borderRadius(12)
                    .shadow({
                        radius: AppTokens.Elevation.level1.radius,
                        color: AppTokens.Elevation.level1.color,
                        offsetX: 0,
                        offsetY: AppTokens.Elevation.level1.dy
                    })
                    .justifyContent(FlexAlign.Center)

                    // Annotation tools column
                    Column({ space: AppTokens.Spacing.sm }) {
                        AnnotationToolButton({ icon: "P", toolName: "pen", selectedTool: this.selectedTool, onClick: () => this.selectedTool = "pen" })
                        AnnotationToolButton({ icon: "H", toolName: "highlighter", selectedTool: this.selectedTool, onClick: () => this.selectedTool = "highlighter" })
                        AnnotationToolButton({ icon: "T", toolName: "text", selectedTool: this.selectedTool, onClick: () => this.selectedTool = "text" })
                        AnnotationToolButton({ icon: "S", toolName: "shape", selectedTool: this.selectedTool, onClick: () => this.selectedTool = "shape" })
                    }
                    .padding(AppTokens.Spacing.sm)
                    .backgroundColor('#CCFFFFFF') // surface with 0.8 opacity
                    .borderRadius(12)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .align(Alignment.Start) // Corresponds to .align(Alignment.CenterStart)
                    .padding(AppTokens.Spacing.md)
                }
                .layoutWeight(1) // Corresponds to Modifier.weight(1f)
                .height('100%')
            }
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .layoutWeight(1)
            .width('100%')
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
    }
}