import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens Translation
// This section translates the AppTokens object from Kotlin to ArkTS.
// It defines custom colors, typography styles, shapes, spacing, and elevation for consistent UI elements.

/**
 * Helper function to convert hex color string to Color resource compatible with ArkUI.
 * ArkUI prefers ColorResource or specific Color constructors.
 */
function getHexColor(hex: number): string {
  // ArkUI Color constructor accepts hex strings like '#A0C4FF'
  const r = ((hex >> 16) & 255).toString(16).padStart(2, '0');
  const g = ((hex >> 8) & 255).toString(16).padStart(2, '0');
  const b = (hex & 255).toString(16).padStart(2, '0');
  return `#${r}${g}${b}`;
}

interface ColorToken {
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

interface TypographyStyle {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
  circle: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationLevel {
  opacity: number;
  radius: number;
  dy: number;
}

interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
}

class AppTokens {
  static Colors: ColorToken = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 45, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium }, // SemiBold not available in standard ArkTS, using Medium
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeToken = {
    small: 4.0,
    medium: 8.0,
    large: 12.0,
    circle: 999.0 // Large radius for circle effect in ArkUI clipShape
  };

  static Spacing: SpacingToken = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0
  };

  static ElevationMapping: ElevationMapping = {
    level1: { opacity: 0.08, radius: 2.0, dy: 1.0 },
    level2: { opacity: 0.10, radius: 4.0, dy: 2.0 },
    level3: { opacity: 0.12, radius: 8.0, dy: 4.0 }
  };
}

// MARK: - Reusable Components

@Component
struct AnnotationToolButton {
  @Prop icon: string;
  @Prop toolName: string;
  @Link selectedTool: string;
  onClick?: () => void;

  build() {
    Column() {
      Text(this.icon)
        .fontSize(AppTokens.TypographyTokens.label.size + 5) // Approximate visual parity
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.toolName === this.selectedTool ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.circle)
    .onClick(() => {
      if (this.onClick) {
        this.onClick();
      }
    })
  }
}

// MARK: - RootScreen Translation

@Entry
@Component
struct RootScreenCorrected {
  @State selectedPage: number = 1;
  @State selectedTool: string = "pen";

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Circle()
            .fill(AppTokens.Colors.surfaceVariant)
            .width(24)
            .height(24)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Blank()

        Text("Document.pdf")
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Button("Share")
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content HStack Equivalent
      Row() {
        // Left: Page Grid
        Column() {
          LazyForEach(Array.from({ length: 12 }, (_, i) => i + 1)) { (page: number) => {
            this.createPageButton(page)
          }}
          .gridTemplateColumns('1fr 1fr')
          .gridTemplateRows('auto')
          .gap(AppTokens.Spacing.sm)
        }
        .width(150)
        .padding(AppTokens.Spacing.sm)
        .layoutWeight(0)

        // Right: Document View
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: Color.Black.withOpacity(AppTokens.ElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })

          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'pen'; }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'highlighter'; }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'text'; }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'shape'; }
            })
          }
          .padding(AppTokens.Spacing.sm)
          .backgroundColor(Color.White.withOpacity(0.8))
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .position({ x: AppTokens.Spacing.md, y: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  createPageButton(page: number): BuilderNode {
    return builder {
      Button() {
        Column() {
          Text(page.toString())
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .aspectRatio(0.7)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .border({
          width: this.selectedPage === page ? 2 : 0,
          color: AppTokens.Colors.primary,
          radius: AppTokens.Shapes.medium
        })
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
      .onClick(() => {
        this.selectedPage = page;
      })
    }
  }
}