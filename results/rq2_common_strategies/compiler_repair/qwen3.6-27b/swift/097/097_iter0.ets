import { Color, FontSize, FontWeight } from '@kit.ArkUI'

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
    activeOrange: '#FFFF9500',
    lightGrayBg: '#FFF9F9F9',
    lightBorderGray: '#FFEEEEEE',
    disabledIconGray: '#FFD1D1D6',
}

@Entry
@Component
struct ClimateControllerApp {
    build() {
        Column() {
            ClimateControllerView()
        }
        .backgroundColor(Colors.pureWhite)
        .width('100%')
        .height('100%')
    }
}

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
        .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
        .width('100%')
        .height('100%')
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
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)

            Flex().justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                .width('100%')
                .layoutWeight(1)

            Column() {
                Text("LIVING ROOM")
                    .fontSize(Dimensions.fontSizeLabelMedium)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Colors.textGray)
                    .letterSpacing(Dimensions.letterSpacingSmall)
                Text("Connected")
                    .fontSize(Dimensions.fontSizeBodySmall)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Colors.accentBlue)
            }

            Flex().justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                .width('100%')
                .layoutWeight(1)

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
                    iconName: 'ic_arrow_down', // Placeholder
                    action: () => this.adjustTemp(-0.5),
                    enabled: this.isActive
                })

                Toggle({ type: ToggleType.Switch, isOn: this.isActive })
                    .onChange((isOn: boolean) => {
                        this.isActive = isOn;
                    })
                    .width(50)
                    .height(30)
                    .selectedColor(Colors.textBlack)

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
    @State animatedProgress: number = 0.0

    aboutToAppear() {
        setTimeout(() => {
            this.animatedProgress = this.progress;
        }, 100);
    }

    build() {
        CanvasRenderingContext2D()
            .drawTask((context: CanvasRenderingContext2D, size: Size) => {
                const strokeWidth = Dimensions.dialStrokeWidth;
                const startAngleDegrees = 135;
                const sweepAngleDegrees = 270 * this.animatedProgress;
                const endAngleDegrees = startAngleDegrees + sweepAngleDegrees;

                const radius = (Math.min(size.width, size.height) - strokeWidth) / 2;
                const centerX = size.width / 2;
                const centerY = size.height / 2;

                context.beginPath();
                context.arc(centerX, centerY, radius, 
                    startAngleDegrees * Math.PI / 180, 
                    endAngleDegrees * Math.PI / 180, 
                    false);
                context.lineWidth = strokeWidth;
                context.lineCap = 'round';
                context.strokeStyle = this.isActive ? Colors.accentBlue : Colors.textGray;
                context.stroke();

                // Knob Indicator
                const angleInRadians = endAngleDegrees * Math.PI / 180;
                const knobX = centerX + radius * Math.cos(angleInRadians);
                const knobY = centerY + radius * Math.sin(angleInRadians);

                context.beginPath();
                context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI);
                context.fillStyle = Colors.pureWhite;
                context.fill();

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
            Image(`common/${this.iconName}`) // Placeholder path
                .width(Dimensions.roundControlButtonIconSize)
                .height(Dimensions.roundControlButtonIconSize)
                .fillColor(this.enabled ? Colors.textBlack : Colors.disabledIconGray)
        }
        .width(Dimensions.roundControlButtonSize)
        .height(Dimensions.roundControlButtonSize)
        .backgroundColor(this.enabled ? Colors.softGrayBg : Colors.lightGrayBg)
        .borderRadius('100%')
        .onClick(() => {
            if (this.enabled) {
                this.action();
            }
        })
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
                    iconName: 'ic_refresh',
                    label: "Fan Speed",
                    status: "Auto"
                })
                QuickActionCard({
                    iconName: 'ic_heart',
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
                    iconName: 'ic_timer',
                    label: "Timer",
                    status: "Set 2h"
                })
                QuickActionCard({
                    iconName: 'ic_home',
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
            Image(`common/${this.iconName}`)
                .width(Dimensions.quickActionCardIconSize)
                .height(Dimensions.quickActionCardIconSize)
                .fillColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                .margin({ bottom: 8 })

            Flex().justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                .height('100%')
                .layoutWeight(1)

            Column() {
                Text(this.label)
                    .fontSize(Dimensions.fontSizeLabelMedium)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
                Text(this.status)
                    .fontSize(Dimensions.fontSizeBodySmall)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Colors.textGray)
            }
        }
        .padding(Dimensions.quickActionCardPadding)
        .height(Dimensions.quickActionCardHeight)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(this.isActive ? Colors.textBlack : Colors.softGrayBg)
        .borderRadius(Dimensions.quickActionCardCornerRadius)
    }
}