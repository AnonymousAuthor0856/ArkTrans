// AppTokens (Atomic Design System)
interface ColorsType {
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

interface TypographyItemType {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItemType;
  headline: TypographyItemType;
  title: TypographyItemType;
  body: TypographyItemType;
  label: TypographyItemType;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecItemType {
  radius: number;
  y: number;
  opacity: number;
}

interface ShadowSpecType {
  level1: ShadowSpecItemType;
  level2: ShadowSpecItemType;
  level3: ShadowSpecItemType;
}

class AppTokens {
  static readonly Colors: ColorsType = {
    primary: '#1E293B',
    secondary: '#0EA5E9',
    tertiary: '#FACC15',
    background: '#1E293B',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#E2E8F0',
    onSurface: '#E2E8F0'
  };

  static readonly Typography: TypographyType = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapesType = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing: SpacingType = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly ShadowSpec: ShadowSpecType = {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  };
}

// Data Model
interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

// Custom Views
@Component
struct CustomTopAppBar {
  @Prop title: string = '';

  build() {
    Row() {
      Blank()
      Text(this.title)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
      Blank()
    }
    .width('100%')
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CodeMarkerCard {
  @Prop marker: CodeMarker = { id: 0, name: '', desc: '' };

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Text(this.marker.id.toString())
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
      }
      .width(32)
      .height(32)
      .borderRadius(AppTokens.Shapes.small)
      .backgroundColor(AppTokens.Colors.secondary)

      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ShadowSpec.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ShadowSpec.level1.y
    })
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ];

  build() {
    Column() {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Project Files')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          // List rendering
          ForEach(this.markers, (marker: CodeMarker) => {
            CodeMarkerCard({ marker: marker })
          }, (marker: CodeMarker) => marker.id.toString())

          Text('Live Terminal')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })

          Button('Run Code')
            .width('60%')
            .height(48)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ShadowSpec.level1.radius,
              color: `rgba(0,0,0,${AppTokens.ShadowSpec.level1.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ShadowSpec.level1.y
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.primary, 0.8], [AppTokens.Colors.surface, 0.9]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}