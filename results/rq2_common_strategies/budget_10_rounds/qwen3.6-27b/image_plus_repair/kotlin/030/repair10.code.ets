import { ClipboardItem } from '../viewmodel/ClipboardItem';
import { AppTokens } from '../constants/AppTokens';
import { ClipboardCard } from '../components/ClipboardCard';
import { SettingsPane } from '../components/SettingsPane';

@Entry
@Component
struct Index {
  @State clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ];
  @State sliderValue: number = 24;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Clipboard History")
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button("Clear")
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(FontWeight.Medium)
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

      // List of Clipboard Items
      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg })
      .edgeEffect(EdgeEffect.Spring)

      // Settings Pane
      SettingsPane({ sliderValue: this.sliderValue })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}