import { FontWeight } from '@kit.ArkUI';

/**
 * Centralized design tokens for consistency across the application.
 */
export class AppTokens {
  static readonly Colors: AppTokenColors = {
    primary: '#007BFF',
    secondary: '#6C757D',
    tertiary: '#17A2B8',
    background: '#F8F9FA',
    surface: '#FFFFFF',
    surfaceVariant: '#E9ECEF',
    outline: '#DEE2E6',
    onBackground: '#212529',
    onSurface: '#212529'
  }

  static readonly Typography: AppTokenTypography = {
    title: { size: 22, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  }

  static readonly Shapes: AppTokenShapes = {
    small: 4,
    medium: 8,
    large: 12
  }

  static readonly Spacing: AppTokenSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

interface AppTokenColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokenTypographyItem {
  size: number;
  weight: FontWeight;
}

interface AppTokenTypography {
  title: AppTokenTypographyItem;
  body: AppTokenTypographyItem;
  label: AppTokenTypographyItem;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

/**
 * Data model representing a single clipboard history item.
 */
export interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number; // Value between 0 and 1
}

@Component
export struct ClipboardCard {
  @Prop item: ClipboardItem;

  build() {
    Column() {
      // Header Row: Icon, Type, Timestamp
      Row() {
        // Blue Icon Box
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(24)
          .height(24)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontColor(AppTokens.Colors.primary)
          .fontWeight(FontWeight.Bold)
          .fontSize(AppTokens.Typography.label.size)
          .margin({ left: AppTokens.Spacing.sm })

        Blank() // Spacer

        Text(this.item.timestamp)
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(AppTokens.Typography.label.size)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppTokens.Spacing.sm })

      // Content Text
      Text(this.item.content)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.Typography.body.size)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: AppTokens.Spacing.md })

      // Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        // Track (Background)
        Rect()
          .fill(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .height(4)
          .borderRadius(AppTokens.Shapes.small)

        // Fill (Progress)
        Rect()
          .fill(AppTokens.Colors.tertiary)
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .clip(true)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.05)', offsetY: 2 })
  }
}

@Entry
@Component
struct Index {
  @State sliderValue: number = 24;

  // Mock data matching the screenshot
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Clipboard History")
          .fontColor(AppTokens.Colors.onBackground)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Medium)
        
        Blank()

        Button("Clear")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.Typography.label.size)
          .height(32)
          .margin({ right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.05)', offsetY: 2 })

      // Scrollable List Area
      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        })
      }
      .width('100%')
      .layoutWeight(1) // Takes up remaining space
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      // Settings Pane
      Column() {
        Row() {
          Text("History Limit (Hours)")
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.label.size)
          
          Blank()

          Text(`${this.sliderValue}`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.sm })

        Slider({
          value: this.sliderValue,
          min: 1,
          max: 72,
          step: 1
        })
        .width('100%')
        .trackThickness(4)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor('#FFFFFF')
        .blockSize({ width: 24, height: 24 })
        .onChange((value: number) => {
          this.sliderValue = value;
        })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: 'rgba(0, 0, 0, 0.1)', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}