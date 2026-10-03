import { ClipboardItem, AppTokens } from './AppData'

@Entry
@Component
struct RootScreen {
  @State clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ] as ClipboardItem[]
  @State sliderValue: number = 24

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Clear")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .onClick(() => {
            // Clear action
          })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium.borderRadius)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .alignItems(VerticalAlign.Center)

      // List
      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')

      // Settings Pane
      SettingsPane({ 
        sliderValue: this.sliderValue, 
        onSliderChange: (value: number) => {
          this.sliderValue = value
        } 
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct ClipboardCard {
  private item: ClipboardItem = {} as ClipboardItem

  aboutToAppear(): void {
    // Initialization handled by prop passing if needed, or default values
  }

  build() {
    Column() {
      Row() {
        Row() {
          Rect()
            .width(24)
            .height(24)
            .fill(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small.borderRadius)
          
          Text(this.item.type)
            .fontColor(AppTokens.Colors.primary)
            .fontWeight(FontWeight.Bold)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .margin({ left: AppTokens.Spacing.sm })
        }
        
        Blank().layoutWeight(1)
        
        Text(this.item.timestamp)
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.item.content)
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
        .margin({ top: AppTokens.Spacing.sm })

      Progress({ value: this.item.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.tertiary)
        .background(AppTokens.Colors.surfaceVariant)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large.borderRadius)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: 'rgba(0,0,0,0.1)', offsetY: AppTokens.ElevationMapping.level1.dy })
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
  }
}

@Component
struct SettingsPane {
  @Prop sliderValue: number = 0
  @Prop onSliderChange: (value: number) => void = () => {}

  aboutToAppear(): void {
  }

  build() {
    Column() {
      Row() {
        Text("History Limit (Hours)")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
        
        Blank().layoutWeight(1)
        
        Text(`${Math.round(this.sliderValue)}`)
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1
      })
      .width('100%')
      .selectedColor(AppTokens.Colors.primary)
      .trackColor(AppTokens.Colors.surfaceVariant)
      .onChange((value: number) => {
        this.onSliderChange(value)
      })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.1)', offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}