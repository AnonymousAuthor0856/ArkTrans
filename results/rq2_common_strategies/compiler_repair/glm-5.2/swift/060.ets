// AppTokens.ets
interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF60A5FA',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B'
  }

  static TypographyTokens: Record<string, TypographyToken> = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  }

  static Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14
  }

  static Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  }
}

// MarkerBox.ets
@Component
export struct MarkerBox {
  @Prop unit: string;
  @Prop value: string;
  @Prop active: boolean;

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.value)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4D38BDF8' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

// MapArea.ets
@Component
export struct MapArea {
  @Prop selected: string;

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.md })

      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(240)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    .padding(AppTokens.Spacing.lg)
  }
}

// CustomButton.ets
@Component
export struct CustomButton {
  @Prop isActive: boolean;
  @Prop isPressed: boolean;
  @BuilderParam content: () => void;
  
  build() {
    Text() {
      this.content()
    }
    .fontSize(AppTokens.TypographyTokens.title.size)
    .fontWeight(AppTokens.TypographyTokens.title.weight)
    .fontColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    .padding({
      left: AppTokens.Spacing.buttonContentHorizontal,
      right: AppTokens.Spacing.buttonContentHorizontal,
      top: AppTokens.Spacing.buttonContentVertical,
      bottom: AppTokens.Spacing.buttonContentVertical
    })
    .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .scale({ x: this.isPressed ? 0.95 : 1.0, y: this.isPressed ? 0.95 : 1.0 })
    .animation({ duration: 100, curve: Curve.EaseOut })
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';
  @State pressedButton: string = '';

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg })

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({ unit: marker, value: 'Tap to convert', active: this.active === marker })
      }, (marker: string) => marker)

      Blank().height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          Button({ type: ButtonType.Normal }) {
            CustomButton({
              isActive: this.active === marker,
              isPressed: this.pressedButton === marker,
              content: () => {
                Text(marker)
              }
            })
          }
          .stateStyles({
            pressed: {
              .backgroundColor(this.active === marker ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            }
          })
          .onClick(() => {
            this.active = marker;
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              this.pressedButton = marker;
            } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
              this.pressedButton = '';
            }
          })
        }, (marker: string) => marker)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
  }
}