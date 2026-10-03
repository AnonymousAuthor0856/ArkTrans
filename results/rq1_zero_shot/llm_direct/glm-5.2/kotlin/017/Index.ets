// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF00FF66',
    secondary: '#FFCCCCCC',
    tertiary: '#FF999999',
    background: '#FF000000',
    surface: '#FF0A0A0A',
    surfaceVariant: '#FF141414',
    outline: '#FF2A2A2A',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FFE0E0E0',
    onSurface: '#FFE0E0E0',
  };

  static readonly TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

@Component
export struct MixerSlider {
  private label: string = '';
  @Link value: number;
  private onChange: (value: number) => void = () => {};

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Column()
            .width('100%')
            .height(4)
            .borderRadius(2)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          // Active Track
          Column()
            .width(`${this.value * 100}%`)
            .height(4)
            .borderRadius(2)
            .backgroundColor(AppTokens.Colors.primary)

          // Thumb
          Column()
            .width(16)
            .height(16)
            .borderRadius(8)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ left: `${this.value * 100}%` })
            .markAnchor({ x: 8, y: 0 })
        }
        .width('100%')
        .height(16)
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              const parentWidth = vp2px(300); // Approximate width for calculation
              let newValue = event.fingerList[0].localX / parentWidth;
              newValue = Math.max(0, Math.min(1, newValue));
              this.value = newValue;
              this.onChange(newValue);
            })
            .onActionUpdate((event: GestureEvent) => {
              const parentWidth = vp2px(300); 
              let newValue = event.fingerList[0].localX / parentWidth;
              newValue = Math.max(0, Math.min(1, newValue));
              this.value = newValue;
              this.onChange(newValue);
            })
        )
      }
      .width('100%')
      .height(24)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text("Audio Mixer Terminal")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: "Bass", value: $bass, onChange: (v: number) => this.bass = v })
          MixerSlider({ label: "Mid", value: $mid, onChange: (v: number) => this.mid = v })
          MixerSlider({ label: "Treble", value: $treble, onChange: (v: number) => this.treble = v })
          
          // Spacer
          Column().height(AppTokens.Spacing.lg)

          // Linear Progress Indicator
          Stack({ alignContent: Alignment.Start }) {
            Column()
              .width('100%')
              .height(6)
              .borderRadius(3)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
            Column()
              .width(`${this.master * 100}%`)
              .height(6)
              .borderRadius(3)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(6)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          // Master Slider
          Row() {
            Stack({ alignContent: Alignment.Start }) {
              Column()
                .width('100%')
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
              Column()
                .width(`${this.master * 100}%`)
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.primary)
              Column()
                .width(16)
                .height(16)
                .borderRadius(8)
                .backgroundColor(AppTokens.Colors.primary)
                .margin({ left: `${this.master * 100}%` })
                .markAnchor({ x: 8, y: 0 })
            }
            .width('100%')
            .height(16)
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  const parentWidth = vp2px(300);
                  let newValue = event.fingerList[0].localX / parentWidth;
                  newValue = Math.max(0, Math.min(1, newValue));
                  this.master = newValue;
                })
                .onActionUpdate((event: GestureEvent) => {
                  const parentWidth = vp2px(300);
                  let newValue = event.fingerList[0].localX / parentWidth;
                  newValue = Math.max(0, Math.min(1, newValue));
                  this.master = newValue;
                })
            )
          }
          .width('100%')
          .height(24)
          .justifyContent(FlexAlign.Center)

          // Apply Settings Button
          Button("Apply Settings", { type: ButtonType.Normal })
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(48)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}