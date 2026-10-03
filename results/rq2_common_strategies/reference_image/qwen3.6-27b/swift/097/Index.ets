import { Image, PixelMap } from '@kit.ArkGraphics'

// MARK: - 1. Constants and Colors for Atomic Correspondence

const Dimensions = {
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

const Colors = {
    pureWhite: '#FFFFFFFF',
    textBlack: '#FF1C1C1E',
    textGray: '#FF8E8E93',
    accentBlue: '#FF007AFF',
    softGrayBg: '#FFF2F2F7',
    lightGrayBg: '#FFF9F9F9',
    lightBorderGray: '#FFEEEEEE',
    disabledIconGray: '#FFD1D1D6',
}

@Entry
@Component
struct ClimateControllerApp {
    @State targetTemp: number = 21.5
    @State isActive: boolean = true

    build() {
        Column() {
            HeaderSection()
                .padding({ top: Dimensions.headerTopPadding })

            Spacer().height(Dimensions.headerSpacerHeight)

            TemperatureDialSection({
                targetTemp: $targetTemp,
                isActive: $isActive,
                adjustTemp: (delta: number) => this.adjustTemp(delta)
            })

            Spacer().height(Dimensions.dialSectionSpacerHeight)

            ControlGridSection()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.pureWhite)
        .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
    }

    private adjustTemp(delta: number): void {
        let newTemp = this.targetTemp + delta;
        if (newTemp < 16.0) newTemp = 16.0;
        if (newTemp > 30.0) newTemp = 30.0;
        this.targetTemp = Math.round(newTemp * 10) / 10.0;
    }
}

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
            .type(ButtonType.Normal)
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
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
        }
        .width('100%')
    }
}

@Component
struct TemperatureDialSection {
    @Link targetTemp: number
    @Link isActive: boolean
    private adjustTemp: (delta: number) => void

    build() {
        Column() {
            Stack({ alignContent: Alignment.Center }) {
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

            Spacer().height(Dimensions.tempControlsSpacerHeight)

            Row() {
                RoundControlButton({
                    iconName: 'ic_arrow_down', // Placeholder
                    action: () => this.adjustTemp(-0.5),
                    enabled: this.isActive
                })

                Toggle({ type: ToggleType.Switch, isOn: this.isActive })
                    .onChange((isOn: boolean) => {
                        this.isActive = isOn;
                    })
                    .color(this.isActive ? Colors.textBlack : Colors.lightGrayBg)

                RoundControlButton({
                    iconName: 'ic_arrow_up', // Placeholder
                    action: () => this.adjustTemp(0.5),
                    enabled: this.isActive
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
        }
        .alignItems(HorizontalAlign.Center)
    }
}

@Component
struct TemperatureDial {
    progress: number
    isActive: boolean

    build() {
        CanvasRenderingContext2D()
            .onReady((context: CanvasRenderingContext2D) => {
                const size = Dimensions.dialCanvasSize;
                const strokeWidth = Dimensions.dialStrokeWidth;
                const radius = (size - strokeWidth) / 2;
                const center = size / 2;
                
                context.lineWidth = strokeWidth;
                context.lineCap = 'round';
                
                // Draw Arc
                const startAngle = 135 * Math.PI / 180;
                const sweepAngle = 270 * Math.PI / 180 * this.progress;
                const endAngle = startAngle + sweepAngle;
                
                context.beginPath();
                context.arc(center, center, radius, startAngle, endAngle, false);
                context.strokeStyle = this.isActive ? Colors.accentBlue : Colors.textGray;
                context.stroke();

                // Draw Knob
                const knobX = center + radius * Math.cos(endAngle);
                const knobY = center + radius * Math.sin(endAngle);
                
                // Outer white circle
                context.beginPath();
                context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI);
                context.fillStyle = Colors.pureWhite;
                context.fill();
                
                // Inner colored circle
                context.beginPath();
                context.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, 2 * Math.PI);
                context.fillStyle = this.isActive ? Colors.accentBlue : Colors.textGray;
                context.fill();
            })
            .width(Dimensions.dialCanvasSize)
            .height(Dimensions.dialCanvasSize)
    }
}

@Component
struct RoundControlButton {
    iconName: string
    action: () => void
    enabled: boolean

    build() {
        Button() {
            Image(`$r('app.media.${this.iconName}')`) // Placeholder logic
                .width(Dimensions.roundControlButtonIconSize)
                .height(Dimensions.roundControlButtonIconSize)
                .fillColor(this.enabled ? Colors.textBlack : Colors.disabledIconGray)
        }
        .onClick(() => {
            if (this.enabled) this.action();
        })
        .width(Dimensions.roundControlButtonSize)
        .height(Dimensions.roundControlButtonSize)
        .backgroundColor(this.enabled ? Colors.softGrayBg : Colors.lightGrayBg)
        .borderRadius('100%')
        .border({ width: Dimensions.roundControlButtonBorderWidth, color: this.enabled ? Color.Transparent : Colors.lightBorderGray })
        .enabled(this.enabled)
    }
}

@Component
struct ControlGridSection {
    build() {
        Column() {
            Text("QUICK ACTIONS")
                .fontSize(Dimensions.fontSizeLabelSmall)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.textGray)
                .margin({ bottom: Dimensions.quickActionsTitleBottomPadding })

            Row() {
                QuickActionCard({
                    iconName: 'ic_refresh', // Placeholder
                    label: "Fan Speed",
                    status: "Auto"
                })
                QuickActionCard({
                    iconName: 'ic_heart', // Placeholder
                    label: "Eco Mode",
                    status: "On",
                    isActive: true
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .margin({ bottom: Dimensions.quickActionsRowSpacing })

            Row() {
                QuickActionCard({
                    iconName: 'ic_info', // Placeholder
                    label: "Timer",
                    status: "Set 2h"
                })
                QuickActionCard({
                    iconName: 'ic_home', // Placeholder
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

@Component
struct QuickActionCard {
    iconName: string
    label: string
    status: string
    isActive: boolean = false

    build() {
        Column() {
            Image(`$r('app.media.${this.iconName}')`) // Placeholder logic
                .width(Dimensions.quickActionCardIconSize)
                .height(Dimensions.quickActionCardIconSize)
                .fillColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                .margin({ bottom: 8 })

            Spacer()

            Column() {
                Text(this.label)
                    .fontSize(Dimensions.fontSizeLabelMedium)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                Text(this.status)
                    .fontSize(Dimensions.fontSizeBodySmall)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(Colors.textGray)
            }
        }
        .width('48%') // Approximate weight(1f) in a row with spacing
        .height(Dimensions.quickActionCardHeight)
        .padding(Dimensions.quickActionCardPadding)
        .backgroundColor(this.isActive ? Colors.textBlack : Colors.softGrayBg)
        .borderRadius(Dimensions.quickActionCardCornerRadius)
    }
}