// AppTokens.ts
export class AppTokens {
  static Colors = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B'
  }

  static TypographyTokens = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  }
}

// CustomUnitButton.ets
@Component
export struct CustomUnitButton {
  @Prop isActive: boolean
  @State isPressed: boolean = false
  content: () => Builder = () => {}

  build() {
    Column() {
      this.content()
    }
    .font({
      size: AppTokens.TypographyTokens.title.size,
      weight: AppTokens.TypographyTokens.title.weight
    })
    .padding({
      left: AppTokens.Spacing.buttonContentHorizontal,
      right: AppTokens.Spacing.buttonContentHorizontal,
      top: AppTokens.Spacing.buttonContentVertical,
      bottom: AppTokens.Spacing.buttonContentVertical
    })
    .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .foregroundColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    .borderRadius(AppTokens.Shapes.small)
    .scaleEffect({ x: this.isPressed ? 0.95 : 1.0, y: this.isPressed ? 0.95 : 1.0 })
    .animation({ duration: 100, curve: Curve.EaseOut })
    .onClick(() => {
      this.isPressed = true
      setTimeout(() => {
        this.isPressed = false
      }, 100)
    })
  }
}

// MarkerBox.ets
@Component
export struct MarkerBox {
  unit: string = ''
  value: string = ''
  active: boolean = false

  build() {
    Column() {
      Text(this.unit)
        .font({
          size: AppTokens.TypographyTokens.headline.size,
          weight: AppTokens.TypographyTokens.headline.weight
        })
        .foregroundColor(AppTokens.Colors.onSurface)
      
      Text(this.value)
        .font({
          size: AppTokens.TypographyTokens.body.size,
          weight: AppTokens.TypographyTokens.body.weight
        })
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(80)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(this.active ? Color('#38BDF8').withOpacity(0.3) : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

// MapArea.ets
@Component
export struct MapArea {
  selected: string = ''

  build() {
    Column() {
      Text('Unit Map Visualization')
        .font({
          size: AppTokens.TypographyTokens.headline.size,
          weight: AppTokens.TypographyTokens.headline.weight
        })
        .foregroundColor(AppTokens.Colors.onSurface)
      
      Text(`Active Unit: ${this.selected}`)
        .font({
          size: AppTokens.TypographyTokens.body.size,
          weight: AppTokens.TypographyTokens.body.weight
        })
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    .padding(AppTokens.Spacing.lg)
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = this.markers[0]

  build() {
    Column() {
      Text('Unit Converter')
        .font({
          size: AppTokens.TypographyTokens.display.size,
          weight: AppTokens.TypographyTokens.display.weight
        })
        .foregroundColor(AppTokens.Colors.onBackground)
      
      MapArea({ selected: this.active })
      
      ForEach(this.markers, (marker: string) => {
        MarkerBox({ 
          unit: marker, 
          value: 'Tap to convert', 
          active: this.active === marker 
        })
      })
      
      Blank()
        .height(AppTokens.Spacing.md)
      
      Row() {
        ForEach(this.markers, (marker: string) => {
          CustomUnitButton({ isActive: this.active === marker }) {
            Text(marker)
              .font({
                size: AppTokens.TypographyTokens.title.size,
                weight: AppTokens.TypographyTokens.title.weight
              })
          }
          .onClick(() => {
            this.active = marker
          })
        })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 90,
      colors: [
        [Color('#38BDF8'), 0.15],
        [Color('#2563EB'), 0.15]
      ]
    })
  }
}