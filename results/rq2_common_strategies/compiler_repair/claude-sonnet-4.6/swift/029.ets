// Color tokens
class Colors {
  static primary: string = '#111111';
  static secondary: string = '#333333';
  static tertiary: string = '#555555';
  static background: string = '#FFFFFF';
  static surface: string = '#F9F9F9';
  static surfaceVariant: string = '#EAEAEA';
  static outline: string = '#D0D0D0';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#DC2626';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#111111';
  static onSurface: string = '#111111';
}

// Spacing tokens
class Spacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static totalAppBarHeight: number = 100;
}

// Shape tokens
class Shapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 14;
}

// Shadow tokens
class ShadowConfig {
  static level1: ShadowOptions = {
    radius: 4,
    color: '#1F000000',
    offsetX: 0,
    offsetY: 2,
  };
}

// Data model
interface FileItem {
  id: number;
  name: string;
  type: string;
  size: string;
}

const files: FileItem[] = [
  { id: 1, name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
  { id: 2, name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
  { id: 3, name: 'Design.psd', type: 'Image', size: '4.7 MB' },
  { id: 4, name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
  { id: 5, name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' },
]

// BoxView component
@Component
struct BoxView {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor(Colors.onSurface)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 6, bottom: 6, left: 8, right: 8 })
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.medium)
  }
}

// FileCard component
@Component
struct FileCard {
  file: FileItem = { id: 0, name: '', type: '', size: '' }

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column({ space: 2 }) {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.tertiary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.md)
    .height(120)
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow(ShadowConfig.level1)
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Stack() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(Spacing.totalAppBarHeight)
      .backgroundColor(Colors.background)
      .alignContent(Alignment.Center)

      // Main content
      Scroll() {
        Column({ space: Spacing.lg }) {
          Text('Recent Files')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 2-column grid
          Grid() {
            ForEach(files, (file: FileItem) => {
              GridItem() {
                FileCard({ file: file })
              }
            }, (file: FileItem) => file.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(Spacing.md)
          .rowsGap(Spacing.md)
          .width('100%')
          .height(Math.ceil(files.length / 2) * (120 + Spacing.md))
        }
        .alignItems(HorizontalAlign.Start)
        .padding(Spacing.lg)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}