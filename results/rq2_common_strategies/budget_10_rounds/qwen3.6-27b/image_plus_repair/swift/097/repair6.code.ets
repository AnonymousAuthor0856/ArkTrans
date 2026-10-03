import { canvas2d } from '@kit.ArkGraphics'

// MARK: - 1. Constants and Colors for Atomic Correspondence

interface DimensionsInterface {
    screenPadding: number;
    headerTopPadding: number;
    headerSpacerHeight: number;
    dialSectionSpacerHeight: number;
    dialOuterBoxSize: number;
    dialCanvasSize: number;
    dialStrokeWidth: number;
    knobRadiusOuter: number;
    knobRadiusInner: number;
    tempControlsSpacerHeight: number;
    tempControlsHorizontalSpacing: number;
    roundControlButtonSize: number;
    roundControlButtonBorderWidth: number;
    roundControlButtonIconSize: number;
    quickActionsTitleBottomPadding: number;
    quickActionsRowSpacing: number;
    quickActionCardHeight: number;
    quickActionCardCornerRadius: number;
    quickActionCardPadding: number;
    quickActionCardIconSize: number;
    letterSpacingSmall: number;
    fontSizeLabelMedium: number;
    fontSizeBodySmall: number;
    fontSizeDisplayMedium: number;
    fontSizeLabelLarge: number;
    fontSizeLabelSmall: number;
}

const Dimensions: DimensionsInterface = {
    screenPadding: 24,
    headerTopPadding: 16,
    headerSpacerHeight: 40,
    dialSectionSpacerHeight: 40,
    dialOuterBoxSize: 280,
    dialCanvasSize: 240,
    dialStrokeWidth: 40,
    knobRadiusOuter: 16,
    knobRadiusInner: 10,
    tempControlsSpacerHeight: 32,
    tempControlsHorizontalSpacing: 32,
    roundControlButtonSize: 56,
    roundControlButtonBorderWidth: 1,
    roundControlButtonIconSize: 28,
    quickActionsTitleBottomPadding: 16,
    quickActionsRowSpacing: 16,
    quickActionCardHeight: 100,
    quickActionCardCornerRadius: 20,
    quickActionCardPadding: 16,
    quickActionCardIconSize: 24,
    letterSpacingSmall: 2,
    fontSizeLabelMedium: 13,
    fontSizeBodySmall: 11,
    fontSizeDisplayMedium: 45,
    fontSizeLabelLarge: 15,
    fontSizeLabelSmall: 11,
}

interface ColorsInterface {
    pureWhite: string;
    textBlack: string;
    textGray: string;
    accentBlue: string;
    softGrayBg: string;
    lightGrayBg: string;
    lightBorderGray: string;
    disabledIconGray: string;
}

const Colors: ColorsInterface = {
    pureWhite: '#FFFFFFFF',
    textBlack: '#FF1C1C1E',
    textGray: '#FF8E8E93',
    accentBlue: '#FF007AFF',
    softGrayBg: '#FFF2F2F7',
    lightGrayBg: '#FFF9F9F9',
    lightBorderGray: '#FFEEEEEE',
    disabledIconGray: '#FFD1D1D6',
}

// MARK: - Main View (ClimateControllerApp equivalent)

@Entry
@Component
struct ClimateControllerView {
    build() {
        Column() {
            HeaderSection()
                .padding({ top: Dimensions.headerTopPadding })

            Spacer()
                .height(Dimensions.headerSpacerHeight)

            TemperatureDialSection()

            Spacer()
                .height(Dimensions.dialSectionSpacerHeight)

            ControlGridSection()

            Spacer()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.pureWhite)
        .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
    }
}

// MARK: - Header Section

@Component
struct HeaderSection {
    build() {
        Row() {
            Button() {
                Image($r('app.media.ic_menu')) // Placeholder for menu icon
                    .width(Dimensions.roundControlButtonIconSize)
                    .height(Dimensions.roundControlButtonIconSize)
                    .fillColor(Colors.textBlack)
            }
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)

            Spacer()

            Column() {
                Text("LIVING ROOM")
                    .fontSize(Dimensions.fontSizeLabelMedium)
                    .fontWeight(FontWeight.Bold)
                    .letterSpacing(Dimensions.letterSpacingSmall)
                    .fontColor(Colors.textGray)
                Text("Connected")
                    .fontSize(Dimensions.fontSizeBodySmall)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(Colors.accentBlue)
            }

            Spacer()

            Button() {
                Image($r('app.media.ic_settings')) // Placeholder for settings icon
                    .width(Dimensions.roundControlButtonIconSize)
                    .height(Dimensions.roundControlButtonIconSize)
                    .fillColor(Colors.textBlack)
            }
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)
        }
        .width('100%')
    }
}

// MARK: - Temperature Dial Section

@Component
struct TemperatureDialSection {
    @State targetTemp: number = 21.5
    @State isActive: boolean = true

    private adjustTemp(delta: number): void {
        let newTemp = this.targetTemp + delta;
        if (newTemp < 16.0) newTemp = 16.0;
        if (newTemp > 30.0) newTemp = 30.0;
        this.targetTemp = Math.round(newTemp * 10) / 10.0;
    }

    build() {
        Column() {
            Stack() {
                Circle()
                    .stroke(Colors.softGrayBg)
                    .strokeWidth(Dimensions.dialStrokeWidth)
                    .width(Dimensions.dialCanvasSize)
                    .height(Dimensions.dialCanvasSize)

                TemperatureDial({
                    progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
                    isActive: this.isActive
                })
                .width(Dimensions.dialCanvasSize)
                .height(Dimensions.dialCanvasSize)

                Column() {
                    Text(`${this.targetTemp.toFixed(1)}°`)
                        .fontSize(Dimensions.fontSizeDisplayMedium)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(this.isActive ? Colors.textBlack : Colors.textGray)
                    Text(this.isActive ? "COOLING" : "OFF")
                        .fontSize(Dimensions.fontSizeLabelLarge)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(Colors.textGray)
                }
            }
            .width(Dimensions.dialOuterBoxSize)
            .height(Dimensions.dialOuterBoxSize)

            Spacer()
                .height(Dimensions.tempControlsSpacerHeight)

            Row() {
                RoundControlButton({
                    iconName: $r('app.media.ic_arrow_down'), // Placeholder
                    action: () => this.adjustTemp(-0.5),
                    isEnabled: this.isActive
                })

                Toggle({ type: ToggleType.Switch, isOn: this.isActive })
                    .onChange((isOn: boolean) => {
                        this.isActive = isOn;
                    })
                    .selectedColor(this.isActive ? Color.Black : Color.Gray)
                    .width(50) // Approximate width to match visual balance

                RoundControlButton({
                    iconName: $r('app.media.ic_arrow_up'), // Placeholder
                    action: () => this.adjustTemp(0.5),
                    isEnabled: this.isActive
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
        }
        .alignItems(HorizontalAlign.Center)
    }
}

// MARK: - Custom Temperature Dial Drawing

@Component
struct TemperatureDial {
    progress: number = 0
    isActive: boolean = false
    @State animatedProgress: number = 0.0

    aboutToAppear(): void {
        setTimeout(() => {
            this.animatedProgress = this.progress;
        }, 100);
    }

    build() {
        CanvasRenderingContext2D()
            .onReady((context: canvas2d.CanvasRenderingContext2D) => {
                const size = Dimensions.dialCanvasSize;
                const strokeWidth = Dimensions.dialStrokeWidth;
                const startAngleDegrees = 135;
                const sweepAngleDegrees = 270 * this.animatedProgress;
                const endAngleDegrees = startAngleDegrees + sweepAngleDegrees;
                const radius = (size - strokeWidth) / 2;
                const centerX = size / 2;
                const centerY = size / 2;

                context.lineWidth = strokeWidth;
                context.lineCap = 'round';
                context.strokeStyle = this.isActive ? Colors.accentBlue : Colors.textGray;

                context.beginPath();
                context.arc(centerX, centerY, radius, 
                    startAngleDegrees * Math.PI / 180, 
                    endAngleDegrees * Math.PI / 180, 
                    false);
                context.stroke();

                // Knob Indicator
                const angleInRadians = endAngleDegrees * Math.PI / 180;
                const knobX = centerX + radius * Math.cos(angleInRadians);
                const knobY = centerY + radius * Math.sin(angleInRadians);

                // Outer white circle
                context.fillStyle = Colors.pureWhite;
                context.beginPath();
                context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI);
                context.fill();

                // Inner colored circle
                context.fillStyle = this.isActive ? Colors.accentBlue : Colors.textGray;
                context.beginPath();
                context.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, 2 * Math.PI);
                context.fill();
            })
            .width(Dimensions.dialCanvasSize)
            .height(Dimensions.dialCanvasSize)
    }
}

// MARK: - Round Control Button

@Component
struct RoundControlButton {
    iconName: Resource = $r('app.media.ic_placeholder')
    action: () => void = () => {}
    isEnabled: boolean = true

    build() {
        Button() {
            Image(this.iconName)
                .width(Dimensions.roundControlButtonIconSize)
                .height(Dimensions.roundControlButtonIconSize)
                .fillColor(this.isEnabled ? Colors.textBlack : Colors.disabledIconGray)
        }
        .type(ButtonType.Capsule)
        .width(Dimensions.roundControlButtonSize)
        .height(Dimensions.roundControlButtonSize)
        .backgroundColor(this.isEnabled ? Colors.softGrayBg : Colors.lightGrayBg)
        .borderRadius('50%')
        .onClick(() => {
            if (this.isEnabled) {
                this.action();
            }
        })
        .enabled(this.isEnabled)
    }
}

// MARK: - Control Grid Section

@Component
struct ControlGridSection {
    build() {
        Column() {
            Text("QUICK ACTIONS")
                .fontSize(Dimensions.fontSizeLabelSmall)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.textGray)
                .margin({ bottom: Dimensions.quickActionsTitleBottomPadding })
                .textAlign(TextAlign.Start)
                .width('100%')

            Row() {
                QuickActionCard({
                    iconName: $r('app.media.ic_refresh'), // Placeholder
                    label: "Fan Speed",
                    status: "Auto"
                })
                QuickActionCard({
                    iconName: $r('app.media.ic_heart'), // Placeholder
                    label: "Eco Mode",
                    status: "On",
                    isActive: true
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')

            Spacer()
                .height(Dimensions.quickActionsRowSpacing)

            Row() {
                QuickActionCard({
                    iconName: $r('app.media.ic_info'), // Placeholder
                    label: "Timer",
                    status: "Set 2h"
                })
                QuickActionCard({
                    iconName: $r('app.media.ic_home'), // Placeholder
                    label: "Away",
                    status: "Off"
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
        }
        .width('100%')
    }
}

// MARK: - Quick Action Card

@Component
struct QuickActionCard {
    iconName: Resource = $r('app.media.ic_placeholder')
    label: string = ""
    status: string = ""
    isActive: boolean = false

    build() {
        Column() {
            Image(this.iconName)
                .width(Dimensions.quickActionCardIconSize)
                .height(Dimensions.quickActionCardIconSize)
                .fillColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                .margin({ bottom: 8 })

            Spacer()

            Column() {
                Text(this.label)
                    .fontSize(Dimensions.fontSizeLabelMedium)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                Text(this.status)
                    .fontSize(Dimensions.fontSizeBodySmall)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(Colors.textGray)
            }
        }
        .padding(Dimensions.quickActionCardPadding)
        .height(Dimensions.quickActionCardHeight)
        .flexShrink(1)
        .backgroundColor(this.isActive ? Colors.textBlack : Colors.softGrayBg)
        .borderRadius(Dimensions.quickActionCardCornerRadius)
    }
}