import { FontWeight } from '@kit.ArkUI';

export interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
}

export interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  buttonContentHorizontal: number;
  buttonContentVertical: number;
}

export class AppTokens {
  static readonly Colors: ColorTokens = {
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
  };

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular }
  };

  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing: SpacingTokens = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  };
}

@Component
export struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
      
      Text(this.value)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? AppTokens.Colors.secondary + '4D' : AppTokens.Colors.surface) // 0.3 opacity approx
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

@Component
export struct MapArea {
  @Prop selected: string = '';

  build() {
    Column() {
      Text("Unit Map Visualization")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
      
      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(240)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct CustomUnitButton {
  private isActive: boolean = false;
  private child: string = '';

  aboutToAppear() {
    // Initialization if needed, though props are usually passed via constructor in newer versions or state
  }

  build() {
    Button(this.child)
      .type(ButtonType.Capsule)
      .fontSize(AppTokens.TypographyTokens.title.size)
      .fontWeight(AppTokens.TypographyTokens.title.weight)
      .padding({ left: AppTokens.Spacing.buttonContentHorizontal, right: AppTokens.Spacing.buttonContentHorizontal, top: AppTokens.Spacing.buttonContentVertical, bottom: AppTokens.Spacing.buttonContentVertical })
      .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .foregroundColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .borderRadius(AppTokens.Shapes.small)
      .scaleEffect({ x: this.isActive ? 0.95 : 1.0, y: this.isActive ? 0.95 : 1.0 })
      .animation({ duration: 100, curve: Curve.EaseOut })
  }
}

@Entry
@Component
struct RootScreen {
  private markers: string[] = ["Length", "Weight", "Temperature", "Speed"];
  @State active: string = this.markers[0];

  build() {
    Column() {
      Text("Unit Converter")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .foregroundColor(AppTokens.Colors.onBackground)
      
      MapArea({ selected: this.active })
      
      ForEach(this.markers, (marker: string) => {
        MarkerBox({ 
          unit: marker, 
          value: "Tap to convert", 
          active: this.active === marker 
        })
      })
      
      Row() {
        ForEach(this.markers, (marker: string) => {
          Button(marker)
            .onClick(() => {
              this.active = marker;
            })
            .type(ButtonType.Capsule)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .padding({ left: AppTokens.Spacing.buttonContentHorizontal, right: AppTokens.Spacing.buttonContentHorizontal, top: AppTokens.Spacing.buttonContentVertical, bottom: AppTokens.Spacing.buttonContentVertical })
            .backgroundColor(this.active === marker ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .foregroundColor(this.active === marker ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.md })
        })
      }
      .justifyContent(FlexAlign.Start)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.15],
        [AppTokens.Colors.primary, 0.15]
      ]
    })
  }
}