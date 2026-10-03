// Index.ets
interface ColorToken {
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

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static Colors: ColorToken = {
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

  static Shapes: ShapeToken = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing: SpacingToken = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20
  };
}

@Component
struct MarkerBox {
  @Prop unit: string;
  @Prop value: string;
  @Prop active: boolean;

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(this.active ? '#4D38BDF8' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

@Component
struct MapArea {
  @Prop selected: string;

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
      Blank().height(AppTokens.Spacing.md)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
      
      MapArea({ selected: this.active })
      
      ForEach(this.markers, (item: string) => {
        MarkerBox({ unit: item, value: 'Tap to convert', active: this.active === item })
      }, (item: string) => item)
      
      Blank().height(AppTokens.Spacing.md)
      
      Row() {
        ForEach(this.markers, (item: string) => {
          Button(item)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.active === item ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .fontColor(this.active === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .onClick(() => {
              this.active = item;
            })
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}