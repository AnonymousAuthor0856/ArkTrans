// AppTokens.ts - Design tokens and theme definitions
export class AppTokens {
  static Colors = {
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
  }

  static TypographyTokens = {
    display: { fontSize: 45, fontWeight: FontWeight.Bold },
    headline: { fontSize: 24, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5 }
  }

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

// RootScreen.ets - Main screen component
@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  
  build() {
    Column() {
      // Top bar
      Row() {
        // Back button placeholder
        Circle({ width: 24, height: 24 })
          .fillColor(AppTokens.Colors.surfaceVariant)
          .margin({ left: 16 })
        
        Text('Document.pdf')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Button('Share')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(20)
          .width(80)
          .height(40)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(60)
      .padding({ top: 16, bottom: 16 })
      
      // Main content area
      Row() {
        // Left sidebar with page thumbnails
        GridContainer()
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto')
          .gap(8)
          .width(150)
          .layoutWeight(1)
          .forEach((page: number) => {
            PageThumbnail(page, this.selectedPage, (selected: number) => {
              this.selectedPage = selected
            })
          })
        
        Spacer().width(16)
        
        // Right main content area
        Column() {
          // Document preview card
          Card()
            .width('100%')
            .height('100%')
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.surface)
            .shadow({ radius: 4, color: '#00000014', offsetY: 2 })
            .child(
              Column() {
                Text(`Page ${this.selectedPage}`)
                  .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                  .margin({ top: 200 })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
            )
          
          // Annotation tools panel
          Column() {
            AnnotationToolButton('P', 'pen', this.selectedTool, (tool: string) => {
              this.selectedTool = tool
            })
            AnnotationToolButton('H', 'highlighter', this.selectedTool, (tool: string) => {
              this.selectedTool = tool
            })
            AnnotationToolButton('T', 'text', this.selectedTool, (tool: string) => {
              this.selectedTool = tool
            })
            AnnotationToolButton('S', 'shape', this.selectedTool, (tool: string) => {
              this.selectedTool = tool
            })
          }
          .position({ x: 20, y: 200 })
          .backgroundColor('#CCFFFFFF')
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding(8)
          .gap(8)
        }
        .layoutWeight(2)
        .position({ x: 0, y: 0 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// PageThumbnail component
@Component
struct PageThumbnail {
  private page: number
  private selectedPage: number
  private onSelect: (page: number) => void
  
  build() {
    Column() {
      Text(this.page.toString())
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(this.selectedPage === this.page ? 
          AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .width('100%')
    .aspectRatio(0.7)
    .borderRadius(AppTokens.Shapes.medium)
    .backgroundColor(this.selectedPage === this.page ? 
      AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.onSelect(this.page)
    })
  }
}

// AnnotationToolButton component
@Component
struct AnnotationToolButton {
  private icon: string
  private toolName: string
  private selectedTool: string
  private onClick: (tool: string) => void
  
  build() {
    Button()
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.toolName === this.selectedTool ? 
        AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .child(
        Text(this.icon)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.toolName === this.selectedTool ? 
            AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      )
      .onClick(() => {
        this.onClick(this.toolName)
      })
  }
}

// Helper function to create grid items
function GridContainer(): Component {
  return new ComponentBuilder<Grid>()
    .build()
}

// Custom Circle component for back button
@Component
struct Circle {
  private width: number
  private height: number
  
  build() {
    Column()
      .width(this.width)
      .height(this.height)
      .borderRadius(this.width / 2)
  }
}

// Custom Card component
@Component
struct Card {
  private child?: Component
  
  build() {
    Column() {
      if (this.child) {
        this.child
      }
    }
  }
}

// Entry point
@Entry
@Component
struct MainApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}