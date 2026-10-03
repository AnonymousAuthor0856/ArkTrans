// app_tokens.ets
export class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Normal },
    body: { size: 12, weight: FontWeight.Normal }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  };
}

// root_screen.ets
@Component
export struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State private active: string = 'Length';

  @Builder
  MarkerBox(unit: string, value: string, active: boolean) {
    Column() {
      Text(unit)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(value)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .borderRadius(AppTokens.Shapes.medium)
    .backgroundColor(active ? '#4D38BDF8' : AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }

  @Builder
  MapArea(selected: string) {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(`Active Unit: ${selected}`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    .padding(AppTokens.Spacing.lg)
  }

  @Builder
  CustomButton(marker: string, isActive: boolean) {
    Button({ type: ButtonType.Normal }) {
      Text(marker)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.buttonContentHorizontal,
          right: AppTokens.Spacing.buttonContentHorizontal,
          top: AppTokens.Spacing.buttonContentVertical,
          bottom: AppTokens.Spacing.buttonContentVertical
        })
    }
    .backgroundColor(isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .onClick(() => {
      this.active = marker;
    })
  }

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      this.MapArea(this.active)

      ForEach(this.markers, (marker: string) => {
        this.MarkerBox(marker, 'Tap to convert', this.active === marker)
      })

      Blank().height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          this.CustomButton(marker, this.active === marker)
        })
      }
    }
    .space(AppTokens.Spacing.lg)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
  }
}

// entry.ets
import { RootScreen } from './root_screen.ets';

@Entry
struct UnitConverterApp {
  build() {
    Column() {
      RootScreen({ active: 'Length' })
    }
  }
}