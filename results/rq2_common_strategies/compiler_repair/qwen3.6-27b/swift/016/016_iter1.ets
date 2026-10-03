import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
interface ColorTokens {
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

interface TypographyTokens {
    displaySize: number;
    titleSize: number;
    bodySize: number;
    labelSize: number;
}

interface ShapeTokens {
    smallCornerRadius: number;
    mediumCornerRadius: number;
    largeCornerRadius: number;
}

interface SpacingTokens {
    xs: number;
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
}

const AppTokens = {
    Colors: {
        primary: '#00FFFF',
        secondary: '#9D00FF',
        tertiary: '#00FFA3',
        background: '#0B0B0D',
        surface: '#1A1A1D',
        surfaceVariant: '#2E2E33',
        outline: '#3F3F46',
        success: '#22C55E',
        warning: '#F59E0B',
        error: '#EF4444',
        onPrimary: '#000000',
        onSecondary: '#FFFFFF',
        onTertiary: '#000000',
        onBackground: '#E5E7EB',
        onSurface: '#E5E7EB'
    } as ColorTokens,
    TypographyTokens: {
        displaySize: 28,
        titleSize: 18,
        bodySize: 14,
        labelSize: 12
    } as TypographyTokens,
    Shapes: {
        smallCornerRadius: 6.0,
        mediumCornerRadius: 10.0,
        largeCornerRadius: 14.0
    } as ShapeTokens,
    Spacing: {
        xs: 4.0,
        sm: 8.0,
        md: 12.0,
        lg: 16.0,
        xl: 24.0,
        xxl: 32.0
    } as SpacingTokens
};

@Entry
@Component
struct ContentView {
    @State title: string = '';
    @State recording: boolean = false;
    @State seconds: number = 0;
    private timerId: number = -1;

    aboutToAppear() {
        // Initialize state if needed
    }

    aboutToDisappear() {
        this.stopTimer();
    }

    startTimer(): void {
        this.stopTimer();
        this.timerId = setInterval(() => {
            this.seconds += 1;
        }, 1000);
    }

    stopTimer(): void {
        if (this.timerId !== -1) {
            clearInterval(this.timerId);
            this.timerId = -1;
        }
    }

    build() {
        Column() {
            // Top Bar
            Text('Neon Recorder')
                .fontSize(AppTokens.TypographyTokens.displaySize)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.primary)
                .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
                .width('100%')
                .backgroundColor(AppTokens.Colors.background)

            // Content Area
            Column() {
                // Recording Name Input
                Column() {
                    Text('Recording name')
                        .fontSize(AppTokens.TypographyTokens.labelSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(Color.AppTokens.Colors.onSurface.opacity(0.7))
                        .alignSelf(ItemAlign.Start)

                    TextInput({ placeholder: '' })
                        .text(this.title)
                        .type(InputType.Text)
                        .onChange((value: string) => {
                            this.title = value;
                        })
                        .fontSize(AppTokens.TypographyTokens.bodySize)
                        .fontColor(AppTokens.Colors.onSurface)
                        .placeholderColor(Color.AppTokens.Colors.onSurface.opacity(0.5))
                        .padding(AppTokens.Spacing.md)
                        .backgroundColor(AppTokens.Colors.surface)
                        .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                        .border({
                            width: 1,
                            color: this.title === '' ? AppTokens.Colors.outline : AppTokens.Colors.primary,
                            radius: AppTokens.Shapes.mediumCornerRadius
                        })
                        .height(44)
                }
                .alignItems(HorizontalAlign.Start)
                .spacing(AppTokens.Spacing.sm)

                // Recording Status Card
                Stack() {
                    Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
                        .fontSize(AppTokens.TypographyTokens.titleSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                }
                .width('100%')
                .height(200)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)

                // Button Row
                Row() {
                    Button(this.recording ? 'Stop' : 'Record')
                        .onClick(() => {
                            this.recording = !this.recording;
                            if (this.recording) {
                                this.seconds = 0;
                                this.startTimer();
                            } else {
                                this.stopTimer();
                            }
                        })
                        .fontSize(AppTokens.TypographyTokens.titleSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onPrimary)
                        .width(160)
                        .height(52)
                        .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
                        .borderRadius(AppTokens.Shapes.largeCornerRadius)

                    Button('Reset')
                        .onClick(() => {
                            this.seconds = 0;
                            if (this.recording) {
                                this.stopTimer();
                                this.startTimer();
                            }
                        })
                        .fontSize(AppTokens.TypographyTokens.titleSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onSecondary)
                        .width(120)
                        .height(52)
                        .backgroundColor(AppTokens.Colors.secondary)
                        .borderRadius(AppTokens.Shapes.largeCornerRadius)
                }
                .justifyContent(FlexAlign.Center)
                .spacing(AppTokens.Spacing.xl)

                Blank().height(AppTokens.Spacing.xxl)

                Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
                    .fontSize(AppTokens.TypographyTokens.bodySize)
                    .fontColor(Color.AppTokens.Colors.onSurface.opacity(0.7))
                    .alignSelf(ItemAlign.Start)
            }
            .padding(AppTokens.Spacing.lg)
            .width('100%')
            .layoutWeight(1)
            .linearGradient({
                angle: 90,
                colors: [
                    [AppTokens.Colors.background, 0],
                    [AppTokens.Colors.surfaceVariant, 1]
                ]
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
        .systemBarProperties({ statusBarVisibility: false })
    }
}