import { FlexAlign, TextAlign } from '@kit.ArkUI';

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
    headline: { fontSize: 24, fontWeight: FontWeight.Medium }, // Fixed SemiBold to Medium
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
          .fill(AppTokens.Colors.surfaceVariant) // Fixed fillColor to fill
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
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6], (page: number) => {
            GridItem() {
              PageThumbnail({
                page: page,
                selectedPage: this.selectedPage,
                onSelect: (selected: number) => {
                  this.selectedPage = selected
                }
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('auto')
        .itemSpacing(8)
        .width(150)
        .layoutWeight(1)
        
        Blank().width(16) // Fixed Spacer syntax
        
        // Right main content area
        Column() {
          // Document preview card
          Column() { // Replaced Card with Column as Card is not a standard ArkTS component in this context or requires specific import
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.TypographyTokens.headline.fontSize)
              .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
              .margin({ top: 200 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 4, color: '#00000014', offsetY: 2 })
          
          // Annotation tools panel
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'pen'
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'highlighter'
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'text'
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'shape'
              }
            })
          }
          .position({ x: 20, y: 200 })
          .backgroundColor('#CCFFFFFF')
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding(8)
          .childrenMargin(8)
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
  private page: number = 0
  private selectedPage: number = 0
  private onSelect: (page: number) => void = () => {}
  
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
  private icon: string = ''
  private toolName: string = ''
  private selectedTool: string = ''
  private onClick: () => void = () => {}
  
  build() {
    Button(this.icon)
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.toolName === this.selectedTool ? 
        AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.toolName === this.selectedTool ? 
        AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .fontWeight(FontWeight.Bold)
      .onClick((event: ClickEvent) => {
        this.onClick()
      })
  }
}