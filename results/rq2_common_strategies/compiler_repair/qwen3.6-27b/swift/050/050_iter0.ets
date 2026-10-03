import { window } from '@kit.ArkUI';

// MARK: - 1. AppTokens Definition

const AppTokens = {
    Colors: {
        primary: '#1E3A8A',
        secondary: '#2563EB',
        tertiary: '#60A5FA',
        background: '#F5F8FF',
        surface: '#FFFFFF',
        surfaceVariant: '#E8EEFA',
        outline: '#CBD5E1',
        success: '#16A34A',
        warning: '#F59E0B',
        error: '#EF4444',
        onPrimary: '#FFFFFF',
        onSecondary: '#FFFFFF',
        onTertiary: '#0B1220',
        onBackground: '#0B1220',
        onSurface: '#0B1220'
    },
    TypographyTokens: {
        display: { size: 28, weight: FontWeight.Bold },
        headline: { size: 20, weight: FontWeight.SemiBold },
        title: { size: 16, weight: FontWeight.Medium },
        body: { size: 14, weight: FontWeight.Normal },
        label: { size: 12, weight: FontWeight.Medium }
    },
    Shapes: {
        smallCornerRadius: 8,
        mediumCornerRadius: 12,
        largeCornerRadius: 18
    },
    Spacing: {
        xs: 6,
        sm: 10,
        md: 14,
        lg: 18,
        xl: 26,
        xxl: 36
    },
    ElevationMapping: {
        level2: { opacity: 0.16, radius: 8, dy: 4 }
    }
};

// MARK: - 3. Custom Segmented Control with Checkmarks

@Component
struct SegmentedControl {
    @Link selectedIndex: number;
    labels: string[];

    build() {
        Row({ space: 0 }) {
            ForEach(this.labels.map((_, index) => index), (index: number) => {
                Button({ type: ButtonType.Normal }) {
                    Row({ space: AppTokens.Spacing.xs }) {
                        if (this.selectedIndex === index) {
                            Image($r('app.media.ic_check')) // Assuming a checkmark icon exists, or use text symbol
                                .width(14)
                                .height(14)
                                .fillColor(AppTokens.Colors.onPrimary)
                        }

                        Text(this.labels[index])
                            .font-size(AppTokens.TypographyTokens.label.size)
                            .fontWeight(AppTokens.TypographyTokens.label.weight)
                            .fontColor(this.selectedIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    }
                    .width('100%')
                    .height(40)
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor(this.selectedIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .borderRadius(this.getSegmentRadius(index))
                }
                .onClick(() => {
                    this.selectedIndex = index;
                })
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
            })
        }
        .width('100%')
        .clip(true)
        .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.mediumCornerRadius
        })
    }

    getSegmentRadius(index: number): number {
        const radius = AppTokens.Shapes.mediumCornerRadius;
        if (this.labels.length === 1) {
            return radius;
        } else if (index === 0) {
            return radius;
        } else if (index === this.labels.length - 1) {
            return radius;
        } else {
            return 0;
        }
    }
}

// MARK: - 4. RootScreen with Adjusted Passenger Card Size

@Entry
@Component
struct RootScreen {
    @State name: string = '';
    @State code: string = '';
    @State selectedSeat: number = 0;
    @State showDialog: boolean = false;

    seatTabs: string[] = ["Economy", "Premium", "Business"];

    aboutToAppear() {
        // Hide status bar
        let windowClass = window.getWindowSync(getContext(this));
        windowClass.setWindowLayoutFullScreen(true);
    }

    build() {
        Stack({ alignContent: Alignment.TopStart }) {
            // Background Gradient
            Column() {
                Blank()
            }
            .linearGradient([
                { offset: 0, color: `${AppTokens.Colors.tertiary}40` }, // 0.25 opacity approx hex
                { offset: 0.5, color: AppTokens.Colors.background },
                { offset: 1, color: `${AppTokens.Colors.secondary}33` }  // 0.2 opacity approx hex
            ])
            .width('100%')
            .height('100%')

            Column() {
                // Header
                Row() {
                    Circle()
                        .fill(AppTokens.Colors.primary)
                        .width(22)
                        .height(22)
                    
                    Spacer()

                    Text("Flight Check-in")
                        .font-size(AppTokens.TypographyTokens.display.size)
                        .fontWeight(AppTokens.TypographyTokens.display.weight)
                        .fontColor(AppTokens.Colors.onSurface)

                    Spacer()

                    Circle()
                        .fill(AppTokens.Colors.secondary)
                        .width(22)
                        .height(22)
                }
                .width('100%')
                .height(56)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                .margin({ bottom: AppTokens.Spacing.md })

                Scroll() {
                    Column({ space: AppTokens.Spacing.lg }) {
                        // Passenger & Booking Card
                        Column({ space: AppTokens.Spacing.lg }) {
                            Text("Passenger")
                                .font-size(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                                .alignSelf(ItemAlign.Start)

                            TextInput({ placeholder: 'Full name' })
                                .type(InputType.Normal)
                                .text(this.name)
                                .onChange((value: string) => {
                                    this.name = value;
                                })
                                .font-size(AppTokens.TypographyTokens.body.size)
                                .fontWeight(AppTokens.TypographyTokens.body.weight)
                                .padding(AppTokens.Spacing.md)
                                .backgroundColor(AppTokens.Colors.surfaceVariant)
                                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                                .fontColor(AppTokens.Colors.onSurface)
                                .border({
                                    width: 1,
                                    color: AppTokens.Colors.outline,
                                    radius: AppTokens.Shapes.mediumCornerRadius
                                })

                            Text("Booking Code")
                                .font-size(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                                .alignSelf(ItemAlign.Start)

                            TextInput({ placeholder: 'e.g. XY7ZK2' })
                                .type(InputType.Normal)
                                .text(this.code)
                                .onChange((value: string) => {
                                    this.code = value;
                                })
                                .font-size(AppTokens.TypographyTokens.body.size)
                                .fontWeight(AppTokens.TypographyTokens.body.weight)
                                .padding(AppTokens.Spacing.md)
                                .backgroundColor(AppTokens.Colors.surfaceVariant)
                                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                                .fontColor(AppTokens.Colors.onSurface)
                                .border({
                                    width: 1,
                                    color: AppTokens.Colors.outline,
                                    radius: AppTokens.Shapes.mediumCornerRadius
                                })

                            Text("Seat Class")
                                .font-size(AppTokens.TypographyTokens.headline.size)
                                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                                .fontColor(AppTokens.Colors.onSurface)
                                .alignSelf(ItemAlign.Start)

                            SegmentedControl(selectedIndex: $selectedSeat, labels: this.seatTabs)
                        }
                        .padding(AppTokens.Spacing.xl)
                        .backgroundColor(AppTokens.Colors.surface)
                        .borderRadius(AppTokens.Shapes.largeCornerRadius)
                        .shadow({
                            radius: AppTokens.ElevationMapping.level2.radius,
                            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
                            offsetX: 0,
                            offsetY: AppTokens.ElevationMapping.level2.dy
                        })

                        // Flight Details Card
                        Column({ space: AppTokens.Spacing.md }) {
                            // Flight Info Row
                            Row() {
                                Column({ space: AppTokens.Spacing.xs }) {
                                    Text("Flight")
                                        .font-size(AppTokens.TypographyTokens.title.size)
                                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                    
                                    Text("BL 213 • HND → CTS")
                                        .font-size(AppTokens.TypographyTokens.body.size)
                                        .fontWeight(AppTokens.TypographyTokens.body.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                }
                                .alignItems(HorizontalAlign.Start)

                                Spacer()

                                Circle()
                                    .fill(AppTokens.Colors.secondary)
                                    .width(36)
                                    .height(36)
                            }
                            .padding(AppTokens.Spacing.md)
                            .backgroundColor(AppTokens.Colors.surface)
                            .borderRadius(AppTokens.Shapes.mediumCornerRadius)

                            // Boarding/Gate/Seat Row
                            Row() {
                                Column() {
                                    Text("Boarding")
                                        .font-size(AppTokens.TypographyTokens.label.size)
                                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                    Text("12:35")
                                        .font-size(AppTokens.TypographyTokens.title.size)
                                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                                        .fontColor(AppTokens.Colors.primary)
                                }
                                .alignItems(HorizontalAlign.Start)

                                Spacer()

                                Column() {
                                    Text("Gate")
                                        .font-size(AppTokens.TypographyTokens.label.size)
                                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                    Text("A12")
                                        .font-size(AppTokens.TypographyTokens.title.size)
                                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                                        .fontColor(AppTokens.Colors.primary)
                                }
                                .alignItems(HorizontalAlign.Start)

                                Spacer()

                                Column() {
                                    Text("Seat")
                                        .font-size(AppTokens.TypographyTokens.label.size)
                                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                                        .fontColor(AppTokens.Colors.onSurface)
                                    Text(this.getSeatNumber())
                                        .font-size(AppTokens.TypographyTokens.title.size)
                                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                                        .fontColor(AppTokens.Colors.primary)
                                }
                                .alignItems(HorizontalAlign.Start)
                            }
                            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

                            // Confirm Button
                            Button("Confirm Check-in") {
                                this.showDialog = true;
                            }
                            .font-size(AppTokens.TypographyTokens.title.size)
                            .fontWeight(AppTokens.TypographyTokens.title.weight)
                            .width('100%')
                            .height(52)
                            .backgroundColor(AppTokens.Colors.primary)
                            .fontColor(AppTokens.Colors.onPrimary)
                            .borderRadius(AppTokens.Shapes.largeCornerRadius)
                        }
                        .padding(AppTokens.Spacing.lg)
                        .backgroundColor(AppTokens.Colors.surface)
                        .borderRadius(AppTokens.Shapes.largeCornerRadius)
                        .shadow({
                            radius: AppTokens.ElevationMapping.level2.radius,
                            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
                            offsetX: 0,
                            offsetY: AppTokens.ElevationMapping.level2.dy
                        })
                    }
                    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                }
                .layoutWeight(1)
            }
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .onDisAppear(() => {
            // Optional: Restore status bar if needed when leaving screen
        })
    }

    getSeatNumber(): string {
        if (this.selectedSeat === 0) {
            return "23C";
        } else if (this.selectedSeat === 1) {
            return "11A";
        } else {
            return "2F";
        }
    }
}