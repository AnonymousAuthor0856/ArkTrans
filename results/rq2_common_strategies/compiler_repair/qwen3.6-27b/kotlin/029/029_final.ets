import { window } from '@kit.ArkUI'

// Token Definitions matching the Kotlin AppTokens
interface Colors {
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

interface Spacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface Shapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensConfig {
  Colors: Colors;
  Spacing: Spacing;
  Shapes: Shapes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#555555',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#EAEAEA',
    outline: '#D0D0D0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#111111',
    onSurface: '#111111'
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  }
}

interface FileItem {
  name: string;
  type: string;
  size: string;
}

@Entry
@Component
struct RootScreen {
  @State files: FileItem[] = [
    { name: "Report.pdf", type: "PDF", size: "2.1 MB" },
    { name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB" },
    { name: "Design.psd", type: "Image", size: "4.7 MB" },
    { name: "Presentation.pptx", type: "Slides", size: "5.4 MB" },
    { name: "MeetingNotes.txt", type: "Text", size: "64 KB" }
  ]

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("File Manager")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(56) // Standard top bar height approximation
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        Text("Recent Files")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        GridComponent({ items: $files })
          .layoutWeight(1)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct GridComponent {
  @Link items: FileItem[]

  build() {
    Grid() {
      ForEach(this.items, (item: FileItem) => {
        GridItem() {
          CardComponent({ file: item })
        }
      }, (item: FileItem) => JSON.stringify(item))
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.md)
    .columnsGap(AppTokens.Spacing.md)
  }
}

@Component
struct CardComponent {
  @Prop file: FileItem

  build() {
    Column() {
      Row() {
        Text(this.file.type)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .height(120)
    .padding(AppTokens.Spacing.md)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct MainEntry {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}