// entry/src/main/ets/viewmodel/ClipboardItem.ts
export interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number; // 0.0 to 1.0
}

// entry/src/main/ets/constants/AppTokens.ts
import { Color, FontSize, FontWeight, LengthUnit } from '@kit.ArkUI';

export class AppTokens {
  static readonly Colors = {
    primary: '#007BFF',
    secondary: '#6C757D',
    tertiary: '#17A2B8',
    background: '#F8F9FA',
    surface: '#FFFFFF',
    surfaceVariant: '#E9ECEF',
    outline: '#DEE2E6',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#212529',
    onSurface: '#212529'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 36, fontWeight: FontWeight.Bold },
    headline: { fontSize: 28, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 22, fontWeight: FontWeight.Medium },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 24 },
    label: { fontSize: 14, fontWeight: FontWeight.Medium, letterSpacing: 0.25 }
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };
}

// entry/src/main/ets/components/ClipboardCard.ets
import { ClipboardItem } from '../viewmodel/ClipboardItem';
import { AppTokens } from '../constants/AppTokens';

@Component
export struct ClipboardCard {
  @Prop item: ClipboardItem;

  build() {
    Column() {
      Row() {
        // Icon placeholder
        Row()
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontColor(AppTokens.Colors.primary)
          .fontWeight(FontWeight.Bold)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .margin({ left: AppTokens.Spacing.sm })

        Blank().layoutWeight(1)

        Text(this.item.timestamp)
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')

      Text(this.item.content)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: AppTokens.Spacing.sm })

      // Progress Bar
      Row() {
        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.small)
        
        Row()
          .layoutWeight(1)
          .height(4)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.1)', offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
  }
}

// entry/src/main/ets/components/SettingsPane.ets
import { AppTokens } from '../constants/AppTokens';

@Component
export struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column() {
      Row() {
        Text("History Limit (Hours)")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
        
        Blank().layoutWeight(1)

        Text(`${Math.round(this.sliderValue)}`)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(FontWeight.SemiBold)
      }
      .width('100%')

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        style: SliderStyle.InSet
      })
      .blockColor(AppTokens.Colors.primary)
      .selectedColor(AppTokens.Colors.primary)
      .trackColor(AppTokens.Colors.surfaceVariant)
      .showTips(false)
      .width('100%')
      .onChange((value: number) => {
        this.sliderValue = value;
      })
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
  }
}

// entry/src/main/ets/pages/Index.ets
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
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg })
      .edgeEffect(EdgeEffect.Spring)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}