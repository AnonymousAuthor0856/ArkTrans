import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

const NAME = "206_StudyFocusSplit_en"
const UI_TYPE = "Education SplitPane"
const STYLE_THEME = "Clay Morph"
const LANG = "en"
const BASELINE_SIZE = "720x1280"
const DENSITY_SPACING = "Medium"
const COMPLEXITY = "Pairs TabRow and Pager views to organize study modules alongside dual focus panes and actions."
const EXTRA = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts."

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

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
  lineHeight: number;
  letterSpacing: number;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
  level3: ElevationToken;
  level4: ElevationToken;
  level5: ElevationToken;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#C08552',
    secondary: '#9BB1C8',
    tertiary: '#E6CFAF',
    background: '#F3EFE6',
    surface: '#FFFFFF',
    surfaceVariant: '#E7DDCF',
    outline: '#D4C5B6',
    success: '#6BB187',
    warning: '#E2A458',
    error: '#D66B5D',
    onPrimary: '#2A1C13',
    onSecondary: '#15202B',
    onTertiary: '#2C1F10',
    onBackground: '#261E19',
    onSurface: '#2E251D'
  }

  static TypographyTokens: TypographyTokens = {
    display: { fontSize: 30, fontWeight: FontWeight.Bold, lineHeight: 36, letterSpacing: 0 },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28, letterSpacing: 0 },
    title: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24, letterSpacing: 0 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20, letterSpacing: 0 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16, letterSpacing: 0 }
  }

  static Shapes: ShapeTokens = {
    small: 12, // dp
    medium: 16, // dp
    large: 20 // dp
  }

  static Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  }

  static ElevationMapping: ElevationMapping = {
    level1: { elevation: 2, radius: 6, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 10, dy: 4, opacity: 0.16 },
    level3: { elevation: 8, radius: 14, dy: 6, opacity: 0.2 },
    level4: { elevation: 12, radius: 18, dy: 8, opacity: 0.24 },
    level5: { elevation: 16, radius: 22, dy: 10, opacity: 0.28 }
  }
}

interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

// --- Components ---

@Component
struct RootScreen {
  @State currentPageIndex: number = 0;
  @State focusNote: string = "Focus on tone shifts across clay gradients";
  
  private modules: StudyModule[] = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ];

  private tasks: TaskItem[] = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Button("Back")
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .onClick(() => {
            // Back action placeholder
          })

        Text("Study Focus Split")
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)

        Button("Share")
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .onClick(() => {
            // Share action placeholder
          })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Scroll() {
        Column() {
          // Tab Row
          Row() {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              Button(module.name)
                .type(ButtonType.Normal)
                .backgroundColor(index === this.currentPageIndex ? AppTokens.Colors.primary : Color.Transparent)
                .fontColor(index === this.currentPageIndex ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .borderRadius(AppTokens.Shapes.small)
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.currentPageIndex = index;
                })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })
          .justifyContent(FlexAlign.Start)

          // Horizontal Pager Simulation (Card View)
          CardView({ module: this.modules[this.currentPageIndex] })
            .margin({ top: AppTokens.Spacing.sm })

          // Dual Focus Panes
          Row() {
            // Focus Board
            Column() {
              Text("Focus board")
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .margin({ bottom: AppTokens.Spacing.sm })

              Column() {
                ForEach(this.tasks, (task: TaskItem) => {
                  Column() {
                    Text(task.title)
                      .fontColor(AppTokens.Colors.onSurface)
                      .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    
                    Text(task.duration)
                      .fontColor(AppTokens.Colors.secondary)
                      .fontSize(AppTokens.TypographyTokens.label.fontSize)
                      .margin({ top: AppTokens.Spacing.xs })
                  }
                  .width('100%')
                  .padding(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .opacity(0.6)
                  .borderRadius(AppTokens.Shapes.small)
                  .margin({ bottom: AppTokens.Spacing.sm })
                })
                
                Button("Add checkpoint")
                  .type(ButtonType.Capsule)
                  .backgroundColor(AppTokens.Colors.primary)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .margin({ top: AppTokens.Spacing.sm })
              }
              .layoutWeight(1)
            }
            .layoutWeight(1)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: 'rgba(0,0,0,0.1)', offsetY: AppTokens.ElevationMapping.level1.dy })

            Blank()
              .width(AppTokens.Spacing.md)

            // Reflection Pane
            Column() {
              Text("Reflection")
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .margin({ bottom: AppTokens.Spacing.sm })

              Column() {
                Text(this.focusNote)
                  .fontColor(AppTokens.Colors.onSurface)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
                  .width('100%')
              }
              .layoutWeight(1)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)

              Button("Shuffle note")
                .type(ButtonType.Capsule)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .margin({ top: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.focusNote = "Blend high and low tones before next critique";
                })
            }
            .layoutWeight(1)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: 'rgba(0,0,0,0.1)', offsetY: AppTokens.ElevationMapping.level1.dy })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })
        }
        .padding({ 
          left: AppTokens.Spacing.lg, 
          right: AppTokens.Spacing.lg, 
          top: AppTokens.Spacing.md, 
          bottom: AppTokens.Spacing.xxxl // Space for bottom bar
        })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Row() {
        Column() {
          Text("Next checkpoint")
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          
          Text("12:40 Studio")
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .opacity(0.8)
            .margin({ top: AppTokens.Spacing.xs })
        }

        Button("Launch session")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .onClick(() => {
            // Launch session action
          })
      }
      .width('100%')
      .padding({ 
        left: AppTokens.Spacing.lg, 
        right: AppTokens.Spacing.lg, 
        top: AppTokens.Spacing.sm, 
        bottom: AppTokens.Spacing.sm 
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.16)', offsetY: AppTokens.ElevationMapping.level2.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CardView {
  @Prop module: StudyModule;

  build() {
    Column() {
      Text(this.module.name)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
      
      Text(this.module.summary)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .opacity(0.8)
        .margin({ top: AppTokens.Spacing.sm })

      Divider()
        .color(AppTokens.Colors.outline)
        .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

      Row() {
        Text("Progress")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        
        Text(`${this.module.progress}%`)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Progress Bar
      Row() {
        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(12)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .margin({ top: AppTokens.Spacing.sm })

      Button("Review outline")
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .margin({ top: AppTokens.Spacing.sm })
        .onClick(() => {
          // Review outline action
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: 'rgba(0,0,0,0.12)', offsetY: AppTokens.ElevationMapping.level1.dy })
  }
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      RootScreen()
    }
  }
}