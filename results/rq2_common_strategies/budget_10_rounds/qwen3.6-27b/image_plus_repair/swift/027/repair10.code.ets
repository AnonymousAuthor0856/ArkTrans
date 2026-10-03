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

interface TypographyStyle {
  size: number;
  weight: number;
}

interface TypographyTokens {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
  circle: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
}

export const AppTokens = {
  Colors: {
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
  } as ColorTokens,
  Typography: {
    display: { size: 45, weight: 700 },
    headline: { size: 24, weight: 600 },
    title: { size: 18, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 }
  } as TypographyTokens,
  Shapes: {
    small: 4,
    medium: 8,
    large: 12,
    circle: 9999
  } as ShapeTokens,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  } as SpacingTokens,
  Elevation: {
    level1: { radius: 2, dy: 1, opacity: 0.08 },
    level2: { radius: 4, dy: 2, opacity: 0.10 },
    level3: { radius: 8, dy: 4, opacity: 0.12 }
  } as ElevationTokens
}

@Component
export struct AnnotationToolButton {
  @Prop icon: string
  @Prop toolName: string
  @Prop selectedTool: string
  @State isSelected: boolean = false

  aboutToAppear() {
    this.isSelected = this.toolName === this.selectedTool
  }

  build() {
    Column() {
      Text(this.icon)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.circle)
    .onClick(() => {
      // In a real app, you'd emit an event or use a state management solution
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon
        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.surfaceVariant)
        
        Blank()
        
        Text('Document.pdf')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
        
        Blank()
        
        // Share Button
        Text('Share')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(56)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content
      Row() {
        // Left side: Page Grid
        GridContainer()
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto')
          .gap(AppTokens.Spacing.sm)
          .width(150)
          .padding(AppTokens.Spacing.sm)
          .forEach((_, index: number) => {
            let page: number = index + 1
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .aspectRatio(0.7)
              .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
                this.selectedPage = page
              })
            }
          }, 12)

        // Right side: Document View
        Stack() {
          // Main document card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          })

          // Annotation tools column
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool
            })
          }
          .padding(AppTokens.Spacing.sm)
          .backgroundColor('#CCFFFFFF') // 80% opacity white
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .alignSelf(ItemAlign.Start)
          .margin(AppTokens.Spacing.md)
        }
        .layoutWeight(1)
      }
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}