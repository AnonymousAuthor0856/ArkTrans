import { drawing } from '@kit.ArkGraphics'

// MARK: - 1. Colors
// Define custom color constants for consistency and easy modification.
interface ColorConstants {
    pureWhite: string;
    offWhite: string;
    textPrimary: string;
    textSecondary: string;
    accentGreen: string;
    accentWarning: string;
    dividerColor: string;
}

const COLORS: ColorConstants = {
    pureWhite: '#FFFFFF',
    offWhite: '#FAFAFA',
    textPrimary: '#1A1A1A',
    textSecondary: '#757575',
    accentGreen: '#4CAF50',
    accentWarning: '#FF9800',
    dividerColor: '#EEEEEE'
}

// MARK: - 2. Main App Structure (@Entry)
@Entry
@Component
struct AeroSenseApp {
    build() {
        Column() {
            AeroSenseContentView()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(COLORS.pureWhite)
        // Requirement 2: App must be set to full screen display, ensuring the top status bar is hidden.
        .systemBarProperties({ statusBarColor: '#00000000' })
    }
}

// The main view of the entire app, simulating Android's Scaffold structure.
@Component
struct AeroSenseContentView {
    build() {
        Stack({ alignContent: Alignment.Bottom }) {
            Column() {
                TopHeader()
                    .padding({ left: 24, right: 24, top: 24, bottom: 24 })

                MainContent()
                    .padding({ left: 24, right: 24, bottom: 16 })
                    .layoutWeight(1)
            }
            .width('100%')
            .backgroundColor(COLORS.pureWhite)

            BottomControlBar()
                .width('100%')
        }
        .width('100%')
        .height('100%')
    }
}

// MARK: - 3. Top Header (Top Title Bar)
@Component
struct TopHeader {
    build() {
        Row() {
            Column() {
                Text("Living Room")
                    .font({ size: 16, weight: FontWeight.Normal })
                    .fontColor(COLORS.textSecondary)
                Text("AeroSense")
                    .font({ size: 34, weight: FontWeight.Bold })
                    .fontColor(COLORS.textPrimary)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
                Image($r('app.media.ic_settings')) // Placeholder for gear icon
                    .width(24)
                    .height(24)
                    .fillColor(COLORS.textPrimary)
            }
            .width(48)
            .height(48)
            .backgroundColor(COLORS.offWhite)
            .borderRadius(24)
            .onClick(() => { /* No op */ })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
    }
}

// MARK: - 4. Main Content (Main Content Area)
@Component
struct MainContent {
    build() {
        Scroll() {
            Column() {
                AirQualityCircle({ aqi: 42 })

                Column() {
                    Row() {
                        MetricCard({
                            label: "Temp",
                            value: "23°C",
                            iconName: $r('app.media.ic_info'), // Placeholder for info icon
                            statusColor: COLORS.textPrimary
                        })
                        MetricCard({
                            label: "Humidity",
                            value: "45%",
                            iconName: $r('app.media.ic_check'), // Placeholder for check icon
                            statusColor: COLORS.accentGreen
                        })
                    }
                    .width('100%')
                    .margin({ bottom: 16 })

                    Row() {
                        MetricCard({
                            label: "PM 2.5",
                            value: "12",
                            iconName: $r('app.media.ic_check_circle'), // Placeholder for check circle icon
                            statusColor: COLORS.accentGreen
                        })
                        MetricCard({
                            label: "CO2",
                            value: "850",
                            iconName: $r('app.media.ic_warning'), // Placeholder for warning icon
                            statusColor: COLORS.accentWarning
                        })
                    }
                    .width('100%')
                }
                .margin({ top: 32 })

                StatusBanner()
                    .margin({ top: 32 })
            }
            .padding({ top: 16, bottom: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
    }
}

// MARK: - 5. Air Quality Circle (Air Quality Indicator)
@Component
struct AirQualityCircle {
    @Prop aqi: number = 0;

    aboutToAppear() {
        // Initialize if needed, though passed via prop in ArkTS usually requires interface or direct assignment
    }

    build() {
        Column() {
            Stack() {
                // Custom drawing for the ring
                DrawingCanvas(this)
                    .width(220)
                    .height(220)
                    .onReady((context: drawing.DrawingContext) => {
                        this.drawRing(context);
                    })

                Column() {
                    Text("AQI")
                        .font({ size: 14, weight: FontWeight.Bold })
                        .fontColor(COLORS.textSecondary)
                        .letterSpacing(2)
                    
                    Text(`${this.aqi}`)
                        .font({ size: 80, weight: FontWeight.Medium })
                        .fontColor(COLORS.textPrimary)
                    
                    Text("Excellent")
                        .font({ size: 16, weight: FontWeight.Medium })
                        .fontColor(COLORS.accentGreen)
                        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                        .backgroundColor('#4CAF501A') // Hex with alpha for 0.1 opacity
                        .borderRadius(16)
                }
                .alignItems(HorizontalAlign.Center)
            }
            .width(220)
            .height(220)
        }
        .width('100%')
        .aspectRatio(1.2)
    }

    drawRing(context: drawing.DrawingContext) {
        const lineWidth: number = 40;
        const radius: number = (Math.min(220, 220) - lineWidth) / 2;
        const centerX: number = 220 / 2;
        const centerY: number = 220 / 2;

        // Background Track
        context.beginPath();
        context.arc(centerX, centerY, radius, 
            this.degToRad(135), 
            this.degToRad(135 + 270), 
            true // Counter-clockwise
        );
        context.lineWidth = lineWidth;
        context.lineCap = drawing.LineCap.Round;
        context.strokeStyle = COLORS.offWhite;
        context.stroke();

        // Progress Track (Approximate for AQI 42/100 -> ~110 degrees sweep)
        context.beginPath();
        context.arc(centerX, centerY, radius, 
            this.degToRad(135), 
            this.degToRad(135 + 110), 
            true // Counter-clockwise
        );
        context.lineWidth = lineWidth;
        context.lineCap = drawing.LineCap.Round;
        context.strokeStyle = COLORS.accentGreen;
        context.stroke();

        // Decorative Dot at the end of progress
        const dotRadius: number = 12;
        const angleForDot: number = this.degToRad(135 + 110);
        const xOffset: number = radius * Math.cos(angleForDot);
        const yOffset: number = radius * Math.sin(angleForDot);
        const dotCenterX: number = centerX + xOffset;
        const dotCenterY: number = centerY + yOffset;

        context.beginPath();
        context.arc(dotCenterX, dotCenterY, dotRadius, 0, 2 * Math.PI, false);
        context.fillStyle = COLORS.pureWhite;
        context.fill();
    }

    degToRad(degrees: number): number {
        return degrees * Math.PI / 180;
    }
}

// MARK: - 6. Metric Card (Metric Card)
@Component
struct MetricCard {
    @Prop label: string = "";
    @Prop value: string = "";
    @Prop iconName: Resource = $r('app.media.ic_default');
    @Prop statusColor: string = "#000000";

    build() {
        Column() {
            Row() {
                Image(this.iconName)
                    .width(20)
                    .height(20)
                    .fillColor(this.statusColor)
                
                Blank()
            }
            
            Blank()

            Column() {
                Text(this.value)
                    .font({ size: 24, weight: FontWeight.Medium })
                    .fontColor(COLORS.textPrimary)
                
                Text(this.label)
                    .font({ size: 12 })
                    .fontColor(COLORS.textSecondary)
            }
            .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(110)
        .padding(16)
        .backgroundColor(COLORS.offWhite)
        .borderRadius(24)
        .layoutWeight(1)
        .margin({ right: 8 }) // Spacing between cards in row handled by parent Row spacing usually, but here we use layoutWeight
    }
}

// MARK: - 7. Status Banner (Status Banner)
@Component
struct StatusBanner {
    build() {
        Column() {
            Row() {
                Image($r('app.media.ic_home')) // Placeholder for home icon
                    .width(24)
                    .height(24)
                    .fillColor(COLORS.textPrimary)
                
                Blank().width(12)
                
                Text("Room Analysis")
                    .font({ size: 16, weight: FontWeight.Bold })
                    .fontColor(COLORS.textPrimary)
            }
            .width('100%')

            Blank().height(12)

            Text("Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.")
                .font({ size: 14 })
                .fontColor(COLORS.textSecondary)
                .lineHeight(22)
                .maxLines(0)
        }
        .width('100%')
        .padding(20)
        .backgroundColor(COLORS.pureWhite)
        .border({ width: 1, color: COLORS.dividerColor, radius: 20 })
    }
}

// MARK: - 8. Bottom Control Bar (Bottom Control Bar)
@Component
struct BottomControlBar {
    build() {
        Column() {
            Divider()
                .color(COLORS.dividerColor)
                .margin({ left: 0, right: 0 })

            Row() {
                ControlIcon({ iconName: $r('app.media.ic_menu'), description: "Menu" })

                Button() {
                    Row() {
                        Image($r('app.media.ic_refresh')) // Placeholder for refresh icon
                            .width(18)
                            .height(18)
                            .fillColor(COLORS.pureWhite)
                        
                        Text("Refresh Data")
                            .font({ size: 16, weight: FontWeight.Medium })
                            .fontColor(COLORS.pureWhite)
                    }
                    .margin({ left: 8, right: 8 })
                }
                .backgroundColor(COLORS.textPrimary)
                .borderRadius(16)
                .padding({ left: 24, right: 24, top: 16, bottom: 16 })
                .onClick(() => { /* No op */ })

                ControlIcon({ iconName: $r('app.media.ic_add'), description: "Add Room" })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(24)
            .backgroundColor(COLORS.pureWhite)
        }
        .width('100%')
    }
}

// MARK: - 9. Control Icon (Bottom Control Icon)
@Component
struct ControlIcon {
    @Prop iconName: Resource = $r('app.media.ic_default');
    @Prop description: string = "";

    build() {
        Button() {
            Image(this.iconName)
                .width(24)
                .height(24)
                .fillColor(COLORS.textPrimary)
        }
        .width(48)
        .height(48)
        .backgroundColor(COLORS.pureWhite)
        .border({ width: 1, color: COLORS.dividerColor, radius: 24 })
        .onClick(() => { /* No op */ })
    }
}